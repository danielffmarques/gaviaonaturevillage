param([string]$Url = "https://www.gaviaonaturevillage.com/servicio_piscina.html")
$resp = Invoke-WebRequest -Uri $Url -UserAgent "Mozilla/5.0"
Write-Host "URL: $Url"
Write-Host "Status: $($resp.StatusCode)"
Write-Host "Content length: $($resp.Content.Length)"

# Look for text inside <main>
if ($resp.Content -match '(?s)<main[^>]*>(.*?)</main>') {
    $main = $matches[1] -replace '(?s)<script.*?</script>', '' -replace '(?s)<style.*?</style>', ''
    $cleanText = ($main -replace '<[^>]+>', ' ' -replace '&nbsp;', ' ' -replace '\s+', ' ').Trim()
    Write-Host "Main text: $cleanText"
}
