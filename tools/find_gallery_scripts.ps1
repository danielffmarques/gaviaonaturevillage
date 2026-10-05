$resp = Invoke-WebRequest -Uri "https://www.gaviaonaturevillage.com/galeria.html" -UserAgent "Mozilla/5.0"
$html = $resp.Content

# Find script tags or gallery definitions
$scripts = [regex]::Matches($html, '<script[^>]*>([\s\S]*?)</script>')
Write-Host "Found $($scripts.Count) script tags"
foreach ($s in $scripts) {
    $code = $s.Groups[1].Value
    if ($code -match 'gallery|galeria|media|photos|images|SYN3142') {
        Write-Host "=== Script Match ==="
        $code.Substring(0, [Math]::Min(500, $code.Length))
    }
}
