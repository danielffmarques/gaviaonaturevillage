$ProgressPreference = 'SilentlyContinue'
$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

$url = "https://www.gaviaonaturevillage.com/alojamento.html"
$response = Invoke-WebRequest -Uri $url -UserAgent $UserAgent -UseBasicParsing
$html = $response.Content

$imgRegex = [regex]'<img[^>]+src=["\x27]([^"\x27]+)["\x27]'
$dataSrcRegex = [regex]'data-src=["\x27]([^"\x27]+)["\x27]'
$dataImgRegex = [regex]'data-img=["\x27]([^"\x27]+)["\x27]'
$bgRegex = [regex]'url\((?:["\x27])?([^"\x27\)]+)(?:["\x27])?\)'

$imgs = @()
foreach ($m in $imgRegex.Matches($html)) { $imgs += $m.Groups[1].Value }
foreach ($m in $dataSrcRegex.Matches($html)) { $imgs += $m.Groups[1].Value }
foreach ($m in $dataImgRegex.Matches($html)) { $imgs += $m.Groups[1].Value }
foreach ($m in $bgRegex.Matches($html)) { $imgs += $m.Groups[1].Value }

$imgs = $imgs | Where-Object { $_ -match '\.(jpg|jpeg|png|webp|svg|gif)($|\?)' } | Select-Object -Unique

Write-Host "Found $($imgs.Count) image candidates on alojamento.html"
$imgs | ForEach-Object { Write-Host " - $_" }
