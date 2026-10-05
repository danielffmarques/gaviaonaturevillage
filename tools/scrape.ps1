# Scraper for Gavião Nature Village
param(
    [string]$BaseUrl = "https://www.gaviaonaturevillage.com"
)

$ProgressPreference = 'SilentlyContinue'
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

$UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# 1. Fetch sitemap.xml
$sitemapUrl = "$BaseUrl/sitemap.xml"
Write-Host "Fetching sitemap from $sitemapUrl..."
$xmlContent = Invoke-RestMethod -Uri $sitemapUrl -UserAgent $UserAgent
$urls = $xmlContent.urlset.url.loc

Write-Host "Found $($urls.Count) URLs in sitemap:"
$urls | ForEach-Object { Write-Host " - $_" }
