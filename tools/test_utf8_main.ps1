$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
$resp = Invoke-WebRequest -Uri "https://www.gaviaonaturevillage.com/CORK-SHELTERS.html" -UserAgent $UserAgent
$stream = $resp.RawContentStream
$stream.Position = 0
$bytes = [byte[]]::new($stream.Length)
$stream.Read($bytes, 0, $stream.Length) | Out-Null
$html = [System.Text.Encoding]::UTF8.GetString($bytes)

# Extract <main> ... </main>
if ($html -match '(?s)<main[^>]*>(.*?)</main>') {
    $mainContent = $matches[1]
    
    # Strip scripts, styles, SVGs
    $cleanMain = $mainContent -replace '(?s)<script.*?</script>', ''
    $cleanMain = $cleanMain -replace '(?s)<style.*?</style>', ''
    $cleanMain = $cleanMain -replace '(?s)<svg.*?</svg>', ''
    $cleanMain = $cleanMain -replace '(?s)<!--.*?-->', ''
    
    # Extract headings and paragraphs
    $items = [regex]::Matches($cleanMain, '<(h[1-6]|p|li|div class="[^"]*text[^"]*")[^>]*>(.*?)</\1>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    
    Write-Host "Extracted content elements:"
    foreach ($item in $items) {
        $tag = $item.Groups[1].Value
        $txt = $item.Groups[2].Value -replace '<[^>]+>', ' ' -replace '&nbsp;', ' ' -replace '\s+', ' '
        $txt = $txt.Trim()
        if ($txt.Length -gt 5 -and $txt -notmatch 'cookies|javascript') {
            Write-Host "[$tag] $txt"
        }
    }
}
