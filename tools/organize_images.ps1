[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Read the raw gallery script
$galContent = Get-Content "tools/raw_gallery.js" -Raw

$categories = [regex]::Matches($galContent, '"name"\s*:\s*"([^"]+)",\s*"photos"\s*:\s*\[([\s\S]*?)\]')
$galMap = @{}
foreach ($cat in $categories) {
    $cName = $cat.Groups[1].Value
    $photosBlock = $cat.Groups[2].Value
    $photoMatches = [regex]::Matches($photosBlock, 'medias\\/(\d+)')
    foreach ($pm in $photoMatches) {
        $id = $pm.Groups[1].Value
        $galMap[$id] = $cName
    }
}

# Source folder with all downloaded images
$allFiles = Get-ChildItem -Path "content/images" -Recurse -File | Where-Object { $_.Extension -eq ".jpg" }

foreach ($f in $allFiles) {
    if ($f.Name -match 'media_(\d+)') {
        $id = $matches[1]
        $targetFolder = "outros"

        # Check gallery map
        if ($galMap.ContainsKey($id)) {
            $cat = $galMap[$id]
            if ($cat -match 'Alojamento') { $targetFolder = "alojamentos" }
            elseif ($cat -match 'Restaurante|Sky') { $targetFolder = "restaurante" }
            elseif ($cat -match 'Wellness') { $targetFolder = "wellness" }
            elseif ($cat -match 'Village') { $targetFolder = "village" }
        } else {
            # Specific known IDs
            if ($id -in @("10","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56")) {
                $targetFolder = "alojamentos"
            } elseif ($id -in @("20","21","22","23","24","25","26")) {
                $targetFolder = "restaurante"
            } elseif ($id -in @("37","38","39","40","41")) {
                $targetFolder = "wellness"
            } elseif ($id -in @("34","35","36","87","88","89","90","91","92","93","94")) {
                $targetFolder = "village"
            } elseif ($id -in @("104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128")) {
                $targetFolder = "experiencias"
            }
        }

        $destDir = "content/images/$targetFolder"
        if (-not (Test-Path $destDir)) { New-Item -ItemType Directory -Force -Path $destDir | Out-Null }
        $destPath = "$destDir/$($f.Name)"
        if ($f.FullName -ne (Get-Item $destDir).FullName + "\" + $f.Name) {
            Move-Item -Path $f.FullName -Destination $destPath -Force
        }
    }
}

# Remove empty test folder if present
if (Test-Path "content/images/test") { Remove-Item -Recurse -Force "content/images/test" }

Write-Host "Folder counts after organization:"
Get-ChildItem -Path "content/images" -Directory | ForEach-Object {
    [PSCustomObject]@{
        Folder = $_.Name
        Count = (Get-ChildItem -Path $_.FullName -File).Count
    }
}
