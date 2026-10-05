$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
$resp = Invoke-WebRequest -Uri "https://www.gaviaonaturevillage.com/galeria.html" -UserAgent $UserAgent
$content = $resp.Content

Write-Host "Page size: $($content.Length) bytes"

# Look for image URLs or gallery JSON
$lines = $content -split "`n"
$matches = $lines | Select-String -Pattern 'jpg|png|webp|svg|images|photo|gallery' -Context 0,0

Write-Host "Found $($matches.Count) matching lines in galeria.html"
$matches | Select-Object -First 30 | ForEach-Object { $_.Line.Trim() }
