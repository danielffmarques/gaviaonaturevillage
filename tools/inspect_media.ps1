$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
$res = Invoke-RestMethod -Uri "https://synergy.booking-channel.com/api/hotels/3142/medias/34" -UserAgent $UserAgent
Write-Host "Keys in response:"
$res | Get-Member -MemberType NoteProperty | ForEach-Object { Write-Host $_.Name }
Write-Host "`nSample data:"
$res | ConvertTo-Json -Depth 5 | Out-File -FilePath "tools/sample_media_34.json" -Encoding utf8
Get-Content "tools/sample_media_34.json" | Select-Object -First 40
