$ProgressPreference = 'SilentlyContinue'
$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

$sitemap = Invoke-RestMethod -Uri "https://www.gaviaonaturevillage.com/sitemap.xml" -UserAgent $UserAgent
$urls = $sitemap.urlset.url.loc

$allImages = [System.Collections.Generic.HashSet[string]]::new()
$allLinks = [System.Collections.Generic.HashSet[string]]::new()

foreach ($u in $urls) {
    Write-Host "Fetching $u..."
    try {
        $resp = Invoke-WebRequest -Uri $u -UserAgent $UserAgent -UseBasicParsing
        $html = $resp.Content

        $matches = [regex]::Matches($html, 'https?://[^"''\s><)]+\.(?:jpg|jpeg|png|webp|svg)[^"''\s><)]*', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        foreach ($m in $matches) { [void]$allImages.Add($m.Value) }

        $relMatches = [regex]::Matches($html, '["''](/[^"''\s><)]+\.(?:jpg|jpeg|png|webp|svg))["'']', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        foreach ($m in $relMatches) { [void]$allImages.Add("https://www.gaviaonaturevillage.com" + $m.Groups[1].Value) }

        # Check for internal links
        $linkMatches = [regex]::Matches($html, 'href=["'']([^"'']+)["'']', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        foreach ($m in $linkMatches) { [void]$allLinks.Add($m.Groups[1].Value) }
    } catch {
        Write-Warning "Failed to fetch ${u}: ${_}"
    }
}

Write-Host "Total unique images found across all sitemap pages: $($allImages.Count)"
$allImages | Select-Object -First 30 | ForEach-Object { Write-Host " - $_" }

Write-Host "`nInternal links found:"
$allLinks | Where-Object { $_ -match '\.html' } | Select-Object -Unique | ForEach-Object { Write-Host " - $_" }
