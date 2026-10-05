$ProgressPreference = 'SilentlyContinue'
$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

$url = "https://www.gaviaonaturevillage.com/alojamento.html"
$response = Invoke-WebRequest -Uri $url -UserAgent $UserAgent -UseBasicParsing
$html = $response.Content

# Find any occurrence of image paths, .jpg, .png, etc.
$matches = [regex]::Matches($html, '[^"''\s><=]+\.(?:jpg|jpeg|png|webp|svg)[^"''\s><=]*', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
Write-Host "Total image pattern matches: $($matches.Count)"
$matches | ForEach-Object { $_.Value } | Select-Object -Unique | Select-Object -First 25 | ForEach-Object { Write-Host " - $_" }
