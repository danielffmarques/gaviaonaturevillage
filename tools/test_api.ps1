$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"

# Test synergy API endpoints
$apiUrls = @(
    "https://synergy.booking-channel.com/api/hotels/3142/medias/34",
    "https://synergy.booking-channel.com/api/hotels/3142/medias",
    "https://synergy.booking-channel.com/api/hotels/3142"
)

foreach ($u in $apiUrls) {
    Write-Host "`nTesting $u..."
    try {
        $res = Invoke-RestMethod -Uri $u -UserAgent $UserAgent
        $res | ConvertTo-Json -Depth 3 | Select-Object -First 30 | ForEach-Object { Write-Host $_ }
    } catch {
        Write-Warning "Failed $u : $_"
    }
}
