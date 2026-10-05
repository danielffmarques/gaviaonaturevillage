[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$ProgressPreference = 'SilentlyContinue'
$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# Create directories
$baseDir = "content"
$dirs = @(
    "$baseDir/texts",
    "$baseDir/images/branding",
    "$baseDir/images/alojamentos",
    "$baseDir/images/wellness",
    "$baseDir/images/restaurante",
    "$baseDir/images/village",
    "$baseDir/images/experiencias",
    "$baseDir/images/galeria",
    "$baseDir/images/outros"
)
foreach ($d in $dirs) {
    if (-not (Test-Path $d)) {
        New-Item -ItemType Directory -Force -Path $d | Out-Null
    }
}

Write-Host "Fetching all pages and extracting content..."

$pagesToScrape = @(
    @{ Slug = "00_home"; Url = "https://www.gaviaonaturevillage.com/"; Category = "geral" },
    @{ Slug = "01_reservar"; Url = "https://www.gaviaonaturevillage.com/reservar.html"; Category = "reservas" },
    @{ Slug = "02_alojamento"; Url = "https://www.gaviaonaturevillage.com/alojamento.html"; Category = "alojamentos" },
    @{ Slug = "02a_cork-shelters"; Url = "https://www.gaviaonaturevillage.com/CORK-SHELTERS.html"; Category = "alojamentos" },
    @{ Slug = "02b_tendas-glamping"; Url = "https://www.gaviaonaturevillage.com/TENDAS-GLAMPING.html"; Category = "alojamentos" },
    @{ Slug = "03_wellness-center"; Url = "https://www.gaviaonaturevillage.com/wellness-center.html"; Category = "wellness" },
    @{ Slug = "03a_circuito-bem-estar"; Url = "https://www.gaviaonaturevillage.com/Circuito-Bem-estar.html"; Category = "wellness" },
    @{ Slug = "04_restaurante-sky-lounge"; Url = "https://www.gaviaonaturevillage.com/cadafaz-restaurante-&-sky-lounge.html"; Category = "restaurante" },
    @{ Slug = "04a_sky-lounge-bar"; Url = "https://www.gaviaonaturevillage.com/Sky-Lounge-Bar.html"; Category = "restaurante" },
    @{ Slug = "04b_menus"; Url = "https://www.gaviaonaturevillage.com/Os-nossos-menus.html"; Category = "restaurante" },
    @{ Slug = "05_programas"; Url = "https://www.gaviaonaturevillage.com/programas.html"; Category = "programas" },
    @{ Slug = "05a_lua-de-mel"; Url = "https://www.gaviaonaturevillage.com/lua-de-mel.html"; Category = "programas" },
    @{ Slug = "05b_familia-no-campo"; Url = "https://www.gaviaonaturevillage.com/familia-no-campo.html"; Category = "programas" },
    @{ Slug = "05c_reconnect-thrive"; Url = "https://www.gaviaonaturevillage.com/reconnect-&-thrive.html"; Category = "programas" },
    @{ Slug = "05d_cultura-e-tradicao"; Url = "https://www.gaviaonaturevillage.com/cultura-e-tradicao.html"; Category = "programas" },
    @{ Slug = "05e_cultura-e-gastronomia"; Url = "https://www.gaviaonaturevillage.com/cultura-e-gastronomia.html"; Category = "programas" },
    @{ Slug = "05f_experiencia-gastronomica"; Url = "https://www.gaviaonaturevillage.com/experiencia-gastronomica.html"; Category = "programas" },
    @{ Slug = "06_village"; Url = "https://www.gaviaonaturevillage.com/village.html"; Category = "village" },
    @{ Slug = "06a_piscina"; Url = "https://www.gaviaonaturevillage.com/servicio_piscina.html"; Category = "village" },
    @{ Slug = "06b_animais"; Url = "https://www.gaviaonaturevillage.com/servicio_animales.html"; Category = "village" },
    @{ Slug = "06c_vinhedos"; Url = "https://www.gaviaonaturevillage.com/servicio_vinhedos.html"; Category = "village" },
    @{ Slug = "06d_parque"; Url = "https://www.gaviaonaturevillage.com/servicio_parque.html"; Category = "village" },
    @{ Slug = "06e_recreativa"; Url = "https://www.gaviaonaturevillage.com/servicio_recreativa.html"; Category = "village" },
    @{ Slug = "07_experiencias"; Url = "https://www.gaviaonaturevillage.com/experiencias.html"; Category = "experiencias" },
    @{ Slug = "07a_natureza-e-lazer"; Url = "https://www.gaviaonaturevillage.com/natureza-e-lazer.html"; Category = "experiencias" },
    @{ Slug = "07b_praia-fluvial-alamal"; Url = "https://www.gaviaonaturevillage.com/praia-fluvial-do-alamal.html"; Category = "experiencias" },
    @{ Slug = "07c_passadicos-alamal"; Url = "https://www.gaviaonaturevillage.com/passadicos-do-alamal.html"; Category = "experiencias" },
    @{ Slug = "07d_observatorio-avifauna"; Url = "https://www.gaviaonaturevillage.com/observatorio-de-avifauna.html"; Category = "experiencias" },
    @{ Slug = "07e_praia-ribeira-venda"; Url = "https://www.gaviaonaturevillage.com/praia-fluvial-da-ribeira-da-venda.html"; Category = "experiencias" },
    @{ Slug = "08_patrimonio-cultura"; Url = "https://www.gaviaonaturevillage.com/patrimonio-e-cultura.html"; Category = "experiencias" },
    @{ Slug = "08a_castelo-belver"; Url = "https://www.gaviaonaturevillage.com/castelo-de-belver.html"; Category = "experiencias" },
    @{ Slug = "08b_museu-sabao"; Url = "https://www.gaviaonaturevillage.com/museu-do-sabao.html"; Category = "experiencias" },
    @{ Slug = "08c_mantas-belver"; Url = "https://www.gaviaonaturevillage.com/nucleo-de-mantas-e-tapecarias-de-belver.html"; Category = "experiencias" },
    @{ Slug = "08d_casa-das-artes"; Url = "https://www.gaviaonaturevillage.com/casa-das-artes.html"; Category = "experiencias" },
    @{ Slug = "09_percursos-pedestres"; Url = "https://www.gaviaonaturevillage.com/percursos-pedrestres.html"; Category = "experiencias" },
    @{ Slug = "09a_pr1"; Url = "https://www.gaviaonaturevillage.com/pr1.html"; Category = "experiencias" },
    @{ Slug = "09b_pr2"; Url = "https://www.gaviaonaturevillage.com/pr2.html"; Category = "experiencias" },
    @{ Slug = "09c_pr3"; Url = "https://www.gaviaonaturevillage.com/pr3.html"; Category = "experiencias" },
    @{ Slug = "09d_pr4"; Url = "https://www.gaviaonaturevillage.com/pr4.html"; Category = "experiencias" },
    @{ Slug = "09e_pr8"; Url = "https://www.gaviaonaturevillage.com/pr8.html"; Category = "experiencias" },
    @{ Slug = "10_eventos"; Url = "https://www.gaviaonaturevillage.com/eventos.html"; Category = "eventos" },
    @{ Slug = "10a_clubhouse"; Url = "https://www.gaviaonaturevillage.com/Clubhouse.html"; Category = "eventos" },
    @{ Slug = "10b_eventos-personalizados"; Url = "https://www.gaviaonaturevillage.com/Eventos-personalizados.html"; Category = "eventos" },
    @{ Slug = "11_galeria"; Url = "https://www.gaviaonaturevillage.com/galeria.html"; Category = "galeria" },
    @{ Slug = "12_contacto"; Url = "https://www.gaviaonaturevillage.com/contacto.html"; Category = "contacto" }
)

$mediaCatalog = [System.Collections.Generic.Dictionary[string, PSCustomObject]]::new()

foreach ($p in $pagesToScrape) {
    Write-Host "Scraping $($p.Slug) from $($p.Url)..."
    try {
        $resp = Invoke-WebRequest -Uri $p.Url -UserAgent $UserAgent -UseBasicParsing
        $stream = $resp.RawContentStream
        $stream.Position = 0
        $mem = New-Object System.IO.MemoryStream
        $stream.CopyTo($mem)
        $html = [System.Text.Encoding]::UTF8.GetString($mem.ToArray())

        # Extract title & description
        $title = if ($html -match '<title>(.*?)</title>') { $matches[1].Trim() } else { $p.Slug }
        $desc = if ($html -match '<meta\s+name=["'']description["'']\s+content=["'']([^"'']*)["'']') { $matches[1].Trim() } else { "" }

        # Extract media placeholders
        $matches = [regex]::Matches($html, 'https://synergy\.booking-channel\.com/api/hotels/3142/medias/(\d+)(?:#([^"''\s><]+))?')
        foreach ($m in $matches) {
            $mId = $m.Groups[1].Value
            $mUrl = "https://synergy.booking-channel.com/api/hotels/3142/medias/$mId"
            $mLabel = if ($m.Groups[2].Success) { [System.Uri]::UnescapeDataString($m.Groups[2].Value) } else { "" }
            if (-not $mediaCatalog.ContainsKey($mUrl)) {
                $mediaCatalog[$mUrl] = [PSCustomObject]@{
                    Id = $mId
                    Url = $mUrl
                    Label = $mLabel
                    Category = $p.Category
                    FoundOn = @($p.Slug)
                }
            } else {
                $mediaCatalog[$mUrl].FoundOn += $p.Slug
            }
        }

        # Clean HTML for markdown text extraction
        $bodyHtml = if ($html -match '(?s)<main[^>]*>(.*?)</main>') { $matches[1] } else { $html }
        $bodyHtml = $bodyHtml -replace '(?s)<script.*?</script>', ''
        $bodyHtml = $bodyHtml -replace '(?s)<style.*?</style>', ''
        $bodyHtml = $bodyHtml -replace '(?s)<svg.*?</svg>', ''
        $bodyHtml = $bodyHtml -replace '(?s)<!--.*?-->', ''
        $bodyHtml = $bodyHtml -replace '(?s)<form.*?</form>', ''
        $bodyHtml = $bodyHtml -replace '(?s)<header.*?</header>', ''
        $bodyHtml = $bodyHtml -replace '(?s)<footer.*?</footer>', ''

        # Extract structured text
        $lines = @()
        $lines += "# $title"
        $lines += ""
        $lines += "**URL Original:** $($p.Url)"
        if ($desc) {
            $lines += "**Descrição SEO:** $desc"
        }
        $lines += ""
        $lines += "---"
        $lines += ""

        # Extract headings and content blocks
        $contentBlocks = [regex]::Matches($bodyHtml, '<(h[1-6]|p|li|div class="[^"]*text[^"]*")[^>]*>(.*?)</\1>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
        $seen = [System.Collections.Generic.HashSet[string]]::new()

        foreach ($cb in $contentBlocks) {
            $tag = $cb.Groups[1].Value
            $txt = $cb.Groups[2].Value -replace '<[^>]+>', ' ' -replace '&nbsp;', ' ' -replace '\s+', ' '
            $txt = $txt.Trim()
            
            if ($txt.Length -gt 2 -and $txt -notmatch 'cookies|preferências de cookies|facebook|instagram' -and -not $seen.Contains($txt)) {
                [void]$seen.Add($txt)
                if ($tag -match 'h1') {
                    $lines += "## $txt`n"
                } elseif ($tag -match 'h2') {
                    $lines += "### $txt`n"
                } elseif ($tag -match 'h[3-6]') {
                    $lines += "#### $txt`n"
                } elseif ($tag -match 'li') {
                    $lines += "- $txt"
                } else {
                    $lines += "$txt`n"
                }
            }
        }

        $mdFile = "$baseDir/texts/$($p.Slug).md"
        $lines -join "`n" | Out-File -FilePath $mdFile -Encoding utf8
        Write-Host "Saved $mdFile"

    } catch {
        Write-Warning "Failed $($p.Slug): $_"
    }
}

# Also scrape gallery JSON
Write-Host "`nScraping complete multiGalerias JSON..."
try {
    $galResp = (Invoke-WebRequest -Uri "https://www.gaviaonaturevillage.com/galeria.html" -UserAgent $UserAgent -UseBasicParsing).Content
    $photoMatches = [regex]::Matches($galResp, 'https:\\/\\/synergy\.booking-channel\.com\\/api\\/hotels\\/3142\\/medias\\/(\d+)(?:#([^"''\s><\\]+))?')
    foreach ($m in $photoMatches) {
        $mId = $m.Groups[1].Value
        $mUrl = "https://synergy.booking-channel.com/api/hotels/3142/medias/$mId"
        $mLabel = if ($m.Groups[2].Success) { [System.Uri]::UnescapeDataString($m.Groups[2].Value) } else { "" }
        if (-not $mediaCatalog.ContainsKey($mUrl)) {
            $mediaCatalog[$mUrl] = [PSCustomObject]@{
                Id = $mId
                Url = $mUrl
                Label = $mLabel
                Category = "galeria"
                FoundOn = @("galeria")
            }
        }
    }
} catch {
    Write-Warning "Gallery extraction failed: $_"
}

# Download branding assets
Write-Host "`nDownloading branding assets..."
$brandAssets = @(
    @{ Url = "https://www.gaviaonaturevillage.com/templates/cadenas/air/images/hotels/SYN3142/logoGaviao_noBG.svg"; Name = "logo_gaviao_nobg.svg" },
    @{ Url = "https://www.gaviaonaturevillage.com/templates/cadenas/air/images/hotels/SYN3142/favicon.ico"; Name = "favicon.ico" },
    @{ Url = "https://www.gaviaonaturevillage.com/templates/cadenas/air/images/hotels/SYN3142/map-marker.svg"; Name = "map_marker.svg" }
)
foreach ($ba in $brandAssets) {
    try {
        $dest = "$baseDir/images/branding/$($ba.Name)"
        Invoke-WebRequest -Uri $ba.Url -OutFile $dest -UserAgent $UserAgent
        Write-Host "Downloaded branding: $($ba.Name)"
    } catch {
        Write-Warning "Failed branding $($ba.Name): $_"
    }
}

# Save media catalog to JSON
Write-Host "`nTotal unique photos in catalog: $($mediaCatalog.Count)"
$catalogList = $mediaCatalog.Values | ForEach-Object { $_ }
$catalogList | ConvertTo-Json -Depth 5 | Out-File -FilePath "$baseDir/images/catalog.json" -Encoding utf8
Write-Host "Saved $baseDir/images/catalog.json"

# Download all catalog images into their respective category folders
Write-Host "`nDownloading all $($catalogList.Count) media images..."
$downloadCount = 0
foreach ($item in $catalogList) {
    $folder = switch ($item.Category) {
        "alojamentos" { "alojamentos" }
        "wellness"    { "wellness" }
        "restaurante" { "restaurante" }
        "village"     { "village" }
        "experiencias"{ "experiencias" }
        "galeria"     { "galeria" }
        default       { "outros" }
    }
    
    # Clean label for file name
    $cleanLabel = ($item.Label -replace '[^a-zA-Z0-9_\-]', '_').Trim('_')
    if ($cleanLabel.Length -gt 35) { $cleanLabel = $cleanLabel.Substring(0, 35) }
    $fileName = if ($cleanLabel) { "media_$($item.Id)_$cleanLabel.jpg" } else { "media_$($item.Id).jpg" }
    $dest = "$baseDir/images/$folder/$fileName"

    if (-not (Test-Path $dest)) {
        try {
            Invoke-WebRequest -Uri $item.Url -OutFile $dest -UserAgent $UserAgent
            $downloadCount++
            if ($downloadCount % 5 -eq 0) {
                Write-Host "Downloaded $downloadCount/$($catalogList.Count) images..."
            }
        } catch {
            Write-Warning "Failed to download $($item.Url): $_"
        }
    }
}

Write-Host "`nExtraction and download completed successfully! $downloadCount images downloaded."
