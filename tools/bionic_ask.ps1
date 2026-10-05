<#
.SYNOPSIS
    Bionic AI Assistant Bridge
    Connects to the local Bionic / LM Studio instance (http://127.0.0.1:1234/v1)
.DESCRIPTION
    Sends prompts or instructions to Bionic to generate content, Astro components,
    Tailwind styling, or TypeScript logic.
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$Prompt,
    
    [string]$SystemPrompt = "És o assistente Bionic especializado em Astro, Tailwind CSS e TypeScript para o projeto Gavião Nature Village. Responde sempre em Português com código limpo e moderno.",
    
    [string]$Model = "google/gemma-3n-e4b",
    [int]$MaxTokens = 2048,
    [double]$Temperature = 0.7
)

$ProgressPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$endpoint = "http://127.0.0.1:1234/v1/chat/completions"

# Verify active model if not specified
try {
    $modelsResp = Invoke-RestMethod -Uri "http://127.0.0.1:1234/v1/models" -Method Get -TimeoutSec 3
    if ($modelsResp.data.Count -gt 0) {
        $chatModels = $modelsResp.data | Where-Object { $_.id -notmatch 'embed' }
        if ($chatModels.Count -gt 0) {
            $Model = $chatModels[0].id
        }
    }
} catch {
    Write-Warning "Could not retrieve models list, using default: $Model"
}

$payload = @{
    model = $Model
    messages = @(
        @{ role = "system"; content = $SystemPrompt },
        @{ role = "user"; content = $Prompt }
    )
    max_tokens = $MaxTokens
    temperature = $Temperature
} | ConvertTo-Json -Depth 5

try {
    $response = Invoke-RestMethod -Uri $endpoint -Method Post -ContentType "application/json; charset=utf-8" -Body $payload -TimeoutSec 120
    $output = $response.choices[0].message.content
    return $output
} catch {
    Write-Error "Failed to communicate with Bionic on $endpoint : $_"
    return $null
}
