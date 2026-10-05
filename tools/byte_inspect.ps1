$resp = Invoke-WebRequest -Uri "https://www.gaviaonaturevillage.com/CORK-SHELTERS.html" -UserAgent "Mozilla/5.0"
$stream = $resp.RawContentStream
$stream.Position = 0
$mem = New-Object System.IO.MemoryStream
$stream.CopyTo($mem)
$bytes = $mem.ToArray()

# Find byte index of "capacidade at"
$pattern = [System.Text.Encoding]::ASCII.GetBytes("capacidade at")
for ($i = 0; $i -lt $bytes.Length - $pattern.Length; $i++) {
    $found = $true
    for ($j = 0; $j -lt $pattern.Length; $j++) {
        if ($bytes[$i + $j] -ne $pattern[$j]) {
            $found = $false
            break
        }
    }
    if ($found) {
        Write-Host "Found at byte offset $i"
        $sub = $bytes[$i..($i + 30)]
        $hex = ($sub | ForEach-Object { $_.ToString("X2") }) -join " "
        Write-Host "Hex: $hex"
        Write-Host "ASCII: $([System.Text.Encoding]::ASCII.GetString($sub))"
        break
    }
}
