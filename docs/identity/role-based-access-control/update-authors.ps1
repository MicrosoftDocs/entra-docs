# PowerShell script to update author fields in all files
# Updates author, manager, and ms.author fields to the specified values

param(
    [string]$FolderPath = ".",
    [string]$NewAuthor = "barclayn",
    [string]$NewManager = "pmwongera"
)

Write-Host "Starting author field updates..."
Write-Host "New author: $NewAuthor"
Write-Host "New manager: $NewManager"
Write-Host "Target folder: $FolderPath"
Write-Host ""

# Get all .md and .yml files in the folder
$files = Get-ChildItem -Path $FolderPath -Include "*.md", "*.yml" -Recurse

$updatedFiles = 0
$totalFiles = $files.Count

foreach ($file in $files) {
    Write-Host "Processing: $($file.Name)"
    
    try {
        $content = Get-Content -Path $file.FullName -Raw
        $originalContent = $content
        $fileUpdated = $false
        
        # For YAML files (.yml) - handle metadata section
        if ($file.Extension -eq ".yml") {
            # Update author field
            if ($content -match "(\s+author:\s+)(.+)") {
                $content = $content -replace "(\s+author:\s+)(.+)", "`${1}$NewAuthor"
                $fileUpdated = $true
                Write-Host "  - Updated author field"
            }
            
            # Update manager field
            if ($content -match "(\s+manager:\s+)(.+)") {
                $content = $content -replace "(\s+manager:\s+)(.+)", "`${1}$NewManager"
                $fileUpdated = $true
                Write-Host "  - Updated manager field"
            }
            
            # Update ms.author field
            if ($content -match "(\s+ms\.author:\s+)(.+)") {
                $content = $content -replace "(\s+ms\.author:\s+)(.+)", "`${1}$NewAuthor"
                $fileUpdated = $true
                Write-Host "  - Updated ms.author field"
            }
        }
        # For Markdown files (.md) - handle YAML front matter
        elseif ($file.Extension -eq ".md") {
            # Update author field in YAML front matter
            if ($content -match "(?m)^author:\s+(.+)$") {
                $content = $content -replace "(?m)^author:\s+(.+)$", "author: $NewAuthor"
                $fileUpdated = $true
                Write-Host "  - Updated author field"
            }
            
            # Update manager field in YAML front matter
            if ($content -match "(?m)^manager:\s+(.+)$") {
                $content = $content -replace "(?m)^manager:\s+(.+)$", "manager: $NewManager"
                $fileUpdated = $true
                Write-Host "  - Updated manager field"
            }
            
            # Update ms.author field in YAML front matter
            if ($content -match "(?m)^ms\.author:\s+(.+)$") {
                $content = $content -replace "(?m)^ms\.author:\s+(.+)$", "ms.author: $NewAuthor"
                $fileUpdated = $true
                Write-Host "  - Updated ms.author field"
            }
        }
        
        # Write updated content back to file if changes were made
        if ($fileUpdated) {
            Set-Content -Path $file.FullName -Value $content -NoNewline
            $updatedFiles++
            Write-Host "  ✓ File updated successfully" -ForegroundColor Green
        } else {
            Write-Host "  - No author/manager fields found to update" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "  ✗ Error processing file: $($_.Exception.Message)" -ForegroundColor Red
    }
    
    Write-Host ""
}

Write-Host "Update complete!"
Write-Host "Total files processed: $totalFiles"
Write-Host "Files updated: $updatedFiles"
Write-Host "Files with no changes: $($totalFiles - $updatedFiles)"
