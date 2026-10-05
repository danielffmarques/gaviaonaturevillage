$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"

# Load HTML agility pack or use regex / regex DOM parser
# In PowerShell 7, we can parse HTML tags, clean scripts, styles, comments, and extract clean text sections.

function Get-CleanPageContent($url) {
    try {
        $html = (Invoke-WebRequest -Uri $url -UserAgent $UserAgent -UseBasicParsing).Content
        
        # Extract title
        $title = ""
        if ($html -match '<title>(.*?)</title>') { $title = $matches[1].Trim() }

        # Extract meta description
        $desc = ""
        if ($html -match '<meta\s+name=["'']description["'']\s+content=["'']([^"'']*)["'']') { $desc = $matches[1].Trim() }

        # Remove scripts, styles, SVG paths, noscript
        $clean = $html -replace '(?s)<script.*?</script>', ' '
        $clean = $clean -replace '(?s)<style.*?</style>', ' '
        $clean = $clean -replace '(?s)<svg.*?</svg>', ' '
        $clean = $clean -replace '(?s)<!--.*?-->', ' '
        $clean = $clean -replace '(?s)<header.*?</header>', ' '
        $clean = $clean -replace '(?s)<footer.*?</footer>', ' '

        # Extract headings (h1, h2, h3, h4)
        $headings = [regex]::Matches($clean, '<h([1-6])[^>]*>(.*?)</h\1>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        
        # Extract paragraphs
        $paragraphs = [regex]::Matches($clean, '<p[^>]*>(.*?)</p>', [System.Text.RegularExpressions.RegexOptions]::Singleline)

        # Extract media placeholders
        $medias = [regex]::Matches($html, 'https://synergy\.booking-channel\.com/api/hotels/3142/medias/(\d+)(?:#([^"''\s><]+))?')

        return [PSCustomObject]@{
            Url = $url
            Title = $title
            Description = $desc
            Headings = ($headings | ForEach-Object { 
                $txt = $_.Groups[2].Value -replace '<[^>]+>', ' ' -replace '&nbsp;', ' ' -replace '\s+', ' '
                "H$($_.Groups[1].Value): $($txt.Trim())"
            } | Where-Object { $_ -notmatch 'H\d+:\s*$' })
            Paragraphs = ($paragraphs | ForEach-Object {
                $txt = $_.Groups[1].Value -replace '<[^>]+>', ' ' -replace '&nbsp;', ' ' -replace '\s+', ' '
                $txt.Trim()
            } | Where-Object { $_.Length -gt 15 })
            Medias = ($medias | ForEach-Object {
                [PSCustomObject]@{
                    Id = $_.Groups[1].Value
                    Label = [System.Uri]::UnescapeDataString($_.Groups[2].Value)
                }
            })
        }
    } catch {
        Write-Warning "Failed $url : $_"
        return $null
    }
}

$sampleUrls = @(
    "https://www.gaviaonaturevillage.com/",
    "https://www.gaviaonaturevillage.com/alojamento.html",
    "https://www.gaviaonaturevillage.com/CORK-SHELTERS.html",
    "https://www.gaviaonaturevillage.com/wellness-center.html",
    "https://www.gaviaonaturevillage.com/cadafaz-restaurante-&-sky-lounge.html"
)

foreach ($u in $sampleUrls) {
    Write-Host "`n==============================================="
    Write-Host "URL: $u"
    $page = Get-CleanPageContent $u
    Write-Host "TITLE: $($page.Title)"
    Write-Host "DESC:  $($page.Description)"
    Write-Host "`nHEADINGS:"
    $page.Headings | ForEach-Object { Write-Host " - $_" }
    Write-Host "`nPARAGRAPHS (sample 3):"
    $page.Paragraphs | Select-Object -First 3 | ForEach-Object { Write-Host " - $_" }
    Write-Host "`nMEDIAS ($($page.Medias.Count)):"
    $page.Medias | Select-Object -Unique -First 5 | ForEach-Object { Write-Host " - Media $($_.Id): $($_.Label)" }
}
