#!/usr/bin/env node
/**
 * update_fido_table.js — Generate the FIDO2 hardware vendor attestation markdown table.
 *
 * Reads a .csv or .xlsx source file containing FIDO Alliance MDS data,
 * filters for approved AAGUIDs, and either prints the table or updates
 * docs/identity/authentication/concept-fido2-hardware-vendor.md in place.
 *
 * Usage:
 *   node scripts/update_fido_table.js <source_file> [--version <N>] [--md-file <path>] [--dry-run]
 *
 * Source file columns (case-insensitive):
 *   Aaguid, Description, Biometric, Usb, Nfc, Bluetooth, ApprovalStatus
 *
 * For .xlsx support, install: npm install xlsx
 */

const fs = require("fs");
const path = require("path");

const YES = "&#x2705;";
const NO = "&#10060;";
const APPROVED = new Set(["AllowedByAllowList", "AllowedByAutoApproval"]);

// ── CSV parser (no dependencies) ────────────────────────────────────────────

function parseCsv(text) {
  const lines = text.split(/\r?\n/).filter((l) => l.trim());
  if (lines.length === 0) return [];

  const parseRow = (line) => {
    const fields = [];
    let current = "";
    let inQuotes = false;
    for (let i = 0; i < line.length; i++) {
      const ch = line[i];
      if (inQuotes) {
        if (ch === '"' && line[i + 1] === '"') {
          current += '"';
          i++;
        } else if (ch === '"') {
          inQuotes = false;
        } else {
          current += ch;
        }
      } else {
        if (ch === '"') {
          inQuotes = true;
        } else if (ch === ",") {
          fields.push(current.trim());
          current = "";
        } else {
          current += ch;
        }
      }
    }
    fields.push(current.trim());
    return fields;
  };

  const headers = parseRow(lines[0]);
  return lines.slice(1).map((line) => {
    const values = parseRow(line);
    const row = {};
    headers.forEach((h, i) => {
      row[h] = values[i] || "";
    });
    return row;
  });
}

// ── XLSX reader (requires 'xlsx' package) ───────────────────────────────────

function readXlsx(filePath) {
  let XLSX;
  try {
    XLSX = require("xlsx");
  } catch {
    console.error("ERROR: 'xlsx' package required for .xlsx files.");
    console.error("Install with: npm install xlsx");
    process.exit(1);
  }
  const wb = XLSX.readFile(filePath);
  const ws = wb.Sheets[wb.SheetNames[0]];
  return XLSX.utils.sheet_to_json(ws, { defval: "" });
}

// ── Column normalization ────────────────────────────────────────────────────

function normalizeColumns(rows) {
  if (rows.length === 0) return rows;

  const canonical = {
    aaguid: "Aaguid",
    description: "Description",
    biometric: "Biometric",
    usb: "Usb",
    nfc: "Nfc",
    bluetooth: "Bluetooth",
    approvalstatus: "ApprovalStatus",
  };

  // Also match common alternate names
  const altMap = {
    bio: "Biometric",
    ble: "Bluetooth",
    status: "ApprovalStatus",
    approval: "ApprovalStatus",
    approval_status: "ApprovalStatus",
  };

  const sample = rows[0];
  const colMap = {};

  for (const key of Object.keys(sample)) {
    const lower = key.toLowerCase().trim();
    if (canonical[lower]) {
      colMap[key] = canonical[lower];
    } else if (altMap[lower]) {
      colMap[key] = altMap[lower];
    }
  }

  const found = new Set(Object.values(colMap));
  const required = new Set(Object.values(canonical));
  const missing = [...required].filter((c) => !found.has(c));
  if (missing.length > 0) {
    console.error(`ERROR: Missing required columns: ${missing.join(", ")}`);
    console.error(`Found columns: ${Object.keys(sample).join(", ")}`);
    process.exit(1);
  }

  return rows.map((row) => {
    const out = {};
    for (const [actual, canon] of Object.entries(colMap)) {
      out[canon] = String(row[actual] || "").trim();
    }
    return out;
  });
}

// ── Table generation ────────────────────────────────────────────────────────

function toEmoji(val) {
  const v = String(val).trim().toUpperCase();
  return ["TRUE", "1", "YES", "Y"].includes(v) ? YES : NO;
}

function formatRow(row) {
  return [
    row.Description,
    row.Aaguid.toLowerCase(),
    toEmoji(row.Biometric),
    toEmoji(row.Usb),
    toEmoji(row.Nfc),
    toEmoji(row.Bluetooth),
  ].join("|");
}

function generateTable(rows) {
  const approved = rows.filter((r) => APPROVED.has(r.ApprovalStatus));
  if (approved.length === 0) {
    console.error("WARNING: No approved AAGUIDs found!");
    return { lines: [], count: 0 };
  }

  // Sort alphabetically by Description, then AAGUID
  approved.sort((a, b) => {
    const cmp = a.Description.toLowerCase().localeCompare(
      b.Description.toLowerCase()
    );
    return cmp !== 0
      ? cmp
      : a.Aaguid.toLowerCase().localeCompare(b.Aaguid.toLowerCase());
  });

  const lines = [
    "Description|AAGUID|Bio|USB|NFC|BLE",
    "-----------|------|---------|-----|----|------",
    ...approved.map(formatRow),
  ];

  return { lines, count: approved.length };
}

// ── Markdown file update ────────────────────────────────────────────────────

function updateMarkdown(mdPath, tableLines, newVersion) {
  let content = fs.readFileSync(mdPath, "utf-8");
  const lines = content.split("\n");

  // Find table boundaries
  let tableStart = -1;
  let tableEnd = -1;

  for (let i = 0; i < lines.length; i++) {
    if (lines[i].startsWith("Description|AAGUID|Bio|USB|NFC|BLE")) {
      tableStart = i;
    } else if (tableStart >= 0 && tableEnd < 0) {
      if (lines[i].startsWith("-----------")) continue;
      if (
        lines[i].includes("|") &&
        (lines[i].includes("&#x2705;") || lines[i].includes("&#10060;"))
      ) {
        continue;
      }
      tableEnd = i;
    }
  }

  if (tableStart < 0) {
    console.error(
      "ERROR: Could not find the attestation table in the markdown file."
    );
    process.exit(1);
  }
  if (tableEnd < 0) tableEnd = lines.length;

  // Replace table section
  const newLines = [
    ...lines.slice(0, tableStart),
    ...tableLines,
    ...lines.slice(tableEnd),
  ];
  let result = newLines.join("\n");

  // Update MDS version reference
  if (newVersion) {
    result = result.replace(/MDS version \d+/g, `MDS version ${newVersion}`);
  }

  fs.writeFileSync(mdPath, result, "utf-8");
  return result;
}

// ── Main ────────────────────────────────────────────────────────────────────

function main() {
  const args = process.argv.slice(2);
  if (args.length === 0 || args.includes("--help") || args.includes("-h")) {
    console.log(`
Usage: node update_fido_table.js <source_file> [options]

Options:
  --version <N>    MDS version number (updates version reference in markdown)
  --md-file <path> Path to concept-fido2-hardware-vendor.md (updates in place)
  --dry-run        Print the table without modifying files

Source file must be .csv or .xlsx with columns:
  Aaguid, Description, Biometric, Usb, Nfc, Bluetooth, ApprovalStatus
    `.trim());
    process.exit(0);
  }

  const sourceFile = args[0];
  const versionIdx = args.indexOf("--version");
  const mdIdx = args.indexOf("--md-file");
  const dryRun = args.includes("--dry-run");
  const version = versionIdx >= 0 ? args[versionIdx + 1] : null;
  const mdFile = mdIdx >= 0 ? args[mdIdx + 1] : null;

  if (!fs.existsSync(sourceFile)) {
    console.error(`ERROR: Source file not found: ${sourceFile}`);
    process.exit(1);
  }

  // Read source file
  const ext = path.extname(sourceFile).toLowerCase();
  let rows;
  if (ext === ".csv") {
    const text = fs.readFileSync(sourceFile, "utf-8");
    // Strip BOM if present
    rows = parseCsv(text.replace(/^\uFEFF/, ""));
  } else if (ext === ".xlsx" || ext === ".xls") {
    rows = readXlsx(sourceFile);
  } else {
    console.error(`ERROR: Unsupported file format: ${ext}. Use .csv or .xlsx.`);
    process.exit(1);
  }

  // Normalize and generate table
  rows = normalizeColumns(rows);
  const { lines: tableLines, count } = generateTable(rows);

  if (dryRun || !mdFile) {
    console.log(`# Approved AAGUIDs: ${count}\n`);
    tableLines.forEach((l) => console.log(l));
    return;
  }

  // Update markdown file
  if (!fs.existsSync(mdFile)) {
    console.error(`ERROR: Markdown file not found: ${mdFile}`);
    process.exit(1);
  }

  updateMarkdown(mdFile, tableLines, version);
  console.log(`✅ Updated ${mdFile}`);
  console.log(`   Approved AAGUIDs: ${count}`);
  if (version) console.log(`   MDS version: ${version}`);
}

main();
