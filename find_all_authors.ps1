# Get all markdown files in global-secure-access folder
$files = Get-ChildItem -Path 'docs/global-secure-access' -Filter '*.md' -Recurse

$authorsFound = @{}
$nonKenwithFiles = @()

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Look for ms.author line
    if ($content -match 'ms\.author\s*:\s*(.+)') {
        $author = $matches[1].Trim()
        
        # Track all authors found
        if (-not $authorsFound.ContainsKey($author)) {
            $authorsFound[$author] = @()
        }
        $authorsFound[$author] += $file.FullName.Replace((Get-Location).Path + '\', '')
        
        # If author is not kenwith, add to non-kenwith list
        if ($author -ne 'kenwith') {
            $nonKenwithFiles += [PSCustomObject]@{
                File = $file.FullName.Replace((Get-Location).Path + '\', '')
                Author = $author
            }
        }
    }
}

Write-Output "=== ALL AUTHORS FOUND ==="
foreach ($author in $authorsFound.Keys | Sort-Object) {
    Write-Output "$author ($($authorsFound[$author].Count) files)"
}

Write-Output ""
Write-Output "=== FILES NOT AUTHORED BY KENWITH ==="
if ($nonKenwithFiles.Count -gt 0) {
    $nonKenwithFiles | Sort-Object File | ForEach-Object {
        Write-Output "$($_.File) - Author: $($_.Author)"
    }
    Write-Output ""
    Write-Output "Total files not authored by kenwith: $($nonKenwithFiles.Count)"
} else {
    Write-Output "No files found where kenwith is not the author."
}
