[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$files = Get-ChildItem -Path "c:\Users\niela\OneDrive\Desktop\Gavião Nature Village\content\texts\0[0-6]*.md" | Sort-Object Name

foreach ($f in $files) {
    Write-Host "================================================================="
    Write-Host "FILE: $($f.Name)"
    $content = Get-Content $f.FullName -Encoding utf8
    $content | Select-Object -First 25 | ForEach-Object { Write-Host "   $_" }
}
