$resp = Invoke-WebRequest -Uri "https://www.gaviaonaturevillage.com/CORK-SHELTERS.html" -UserAgent "Mozilla/5.0"
Write-Host "ContentType: $($resp.Headers['Content-Type'])"

$stream = $resp.RawContentStream
$stream.Position = 0
$mem = New-Object System.IO.MemoryStream
$stream.CopyTo($mem)
$bytes = $mem.ToArray()

# Test searching for the word "informação" or "capacidade até"
$encUtf8 = [System.Text.Encoding]::UTF8.GetString($bytes)
$encIso = [System.Text.Encoding]::GetEncoding("iso-8859-1").GetString($bytes)
$encWin = [System.Text.Encoding]::GetEncoding("windows-1252").GetString($bytes)

Write-Host "=== UTF-8 check ==="
if ($encUtf8 -match 'capacidade[^<]+') { Write-Host $matches[0] }
Write-Host "=== ISO-8859-1 check ==="
if ($encIso -match 'capacidade[^<]+') { Write-Host $matches[0] }
Write-Host "=== Windows-1252 check ==="
if ($encWin -match 'capacidade[^<]+') { Write-Host $matches[0] }
