$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
$sitemap = Invoke-RestMethod -Uri "https://www.gaviaonaturevillage.com/sitemap.xml" -UserAgent $UserAgent
$urls = $sitemap.urlset.url.loc

$mediaUrls = [System.Collections.Generic.Dictionary[string, string]]::new()

foreach ($u in $urls) {
    try {
        $html = (Invoke-WebRequest -Uri $u -UserAgent $UserAgent -UseBasicParsing).Content
        
        # Match all data-placeholder, data-src, src, etc.
        $matches = [regex]::Matches($html, 'https://synergy\.booking-channel\.com/api/hotels/3142/medias/\d+#[^"''\s><]+')
        foreach ($m in $matches) {
            $val = $m.Value
            $split = $val -split '#'
            $urlOnly = $split[0]
            $label = if ($split.Length -gt 1) { $split[1] } else { "" }
            if (-not $mediaUrls.ContainsKey($urlOnly)) {
                $mediaUrls[$urlOnly] = $label
            }
        }

        # Also find any other images
        $otherImgs = [regex]::Matches($html, '["''](https?://[^"''\s><)]+\.(?:jpg|jpeg|png|webp|svg)[^"''\s><)]*)["'']')
        foreach ($m in $otherImgs) {
            $val = $m.Groups[1].Value
            if (-not $mediaUrls.ContainsKey($val)) {
                $mediaUrls[$val] = "image"
            }
        }

        # Also find relative images
        $relImgs = [regex]::Matches($html, '["''](/(?:templates|images|modulos|fotos)/[^"''\s><)]+\.(?:jpg|jpeg|png|webp|svg))["'']')
        foreach ($m in $relImgs) {
            $fullUrl = "https://www.gaviaonaturevillage.com" + $m.Groups[1].Value
            if (-not $mediaUrls.ContainsKey($fullUrl)) {
                $mediaUrls[$fullUrl] = "site-asset"
            }
        }

    } catch {
        Write-Warning "Failed ${u}: ${_}"
    }
}

Write-Host "Total unique media items found: $($mediaUrls.Count)"
$mediaUrls.GetEnumerator() | Select-Object -First 30 | ForEach-Object { Write-Host "$($_.Key) -> $($_.Value)" }
