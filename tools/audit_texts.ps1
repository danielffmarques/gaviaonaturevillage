[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$files = Get-ChildItem -Path "c:\Users\niela\OneDrive\Desktop\Gavião Nature Village\content\texts\*.md" | Sort-Object Name

foreach ($f in $files) {
    $content = Get-Content $f.FullName -Raw -Encoding utf8
    $lines = $content -split "`n" | Where-Object { $_.Trim().Length -gt 0 }
    $title = ($lines | Select-Object -First 1) -replace '^#\s*', ''
    $headings = $lines | Where-Object { $_ -match '^#{2,4}\s' }
    $bodySnippets = $lines | Where-Object { $_ -notmatch '^[#\-\*]' -and $_ -notmatch 'URL Original|Descrição SEO|---' } | Select-Object -First 3

    Write-Host "================================================================="
    Write-Host "FILE: $($f.Name)"
    Write-Host "TITLE: $title"
    Write-Host "HEADINGS:"
    $headings | ForEach-Object { Write-Host "   $_" }
    Write-Host "KEY TEXT:"
    $bodySnippets | ForEach-Object { Write-Host "   $_" }
}
