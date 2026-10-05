$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
New-Item -ItemType Directory -Force -Path "content/images/test" | Out-Null

$testUrls = @(
    "https://synergy.booking-channel.com/api/hotels/3142/medias/34",
    "https://www.gaviaonaturevillage.com/templates/cadenas/air/images/hotels/SYN3142/logoGaviao_noBG.svg",
    "https://images.booking-channel.com/templates/cadenas/air/images/hotels/SYN3142/1500/menus_navidad.jpg"
)

foreach ($u in $testUrls) {
    $filename = [System.IO.Path]::GetFileName(($u -split '#')[0])
    if ($u -match 'medias/(\d+)') {
        $filename = "media_" + $matches[1] + ".jpg"
    }
    $dest = "content/images/test/$filename"
    Write-Host "Downloading $u to $dest..."
    Invoke-WebRequest -Uri $u -OutFile $dest -UserAgent $UserAgent
    $size = (Get-Item $dest).Length
    Write-Host "Downloaded $filename ($size bytes)"
}
