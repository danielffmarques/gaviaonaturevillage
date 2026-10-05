$resp = Invoke-WebRequest -Uri "https://www.gaviaonaturevillage.com/galeria.html" -UserAgent "Mozilla/5.0"
$html = $resp.Content

# Extract the multiGalerias script
if ($html -match 'json_multiGalerias\s*=\s*\[\];([\s\S]*?)<\/script>') {
    $scriptBody = $matches[1]
    $scriptBody | Out-File -FilePath "tools/raw_gallery.js" -Encoding utf8
    Write-Host "Saved raw gallery script, size: $($scriptBody.Length) bytes"

    # Find all category names and photo URLs
    $categories = [regex]::Matches($scriptBody, '"name"\s*:\s*"([^"]+)",\s*"photos"\s*:\s*\[([\s\S]*?)\]')
    Write-Host "Found $($categories.Count) gallery categories:"
    foreach ($cat in $categories) {
        $catName = $cat.Groups[1].Value
        $photosBlock = $cat.Groups[2].Value
        $photoMatches = [regex]::Matches($photosBlock, 'https:\\/\\/synergy\.booking-channel\.com\\/api\\/hotels\\/3142\\/medias\\/(\d+)')
        Write-Host " - Category: '$catName' with $($photoMatches.Count) photos"
    }
} else {
    Write-Warning "Could not find json_multiGalerias"
}
