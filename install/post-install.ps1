# Function to handle errors
function Handle-Error {
    param (
        [string]$ErrorMessage
    )
    Write-Error $ErrorMessage
    exit 1
}

# Define paths for the source and destination scripts
$sourceProfilePath = ".\powershell\profile.ps1"
$sourceThemePath = ".\oh-my-posh\pyyupsk.omp.json"
$sourceWeztermPath = ".\wezterm\.wezterm.lua"

# Ensure the destination theme directory exists
try {
    if (-not (Test-Path $env:POSH_THEMES_PATH)) {
        New-Item -ItemType Directory -Path $env:POSH_THEMES_PATH -Force | Out-Null
    }
} catch {
    Handle-Error "Failed to create theme directory: $_"
}

# Copy profile script
try {
    Copy-Item -Path $sourceProfilePath -Destination $PROFILE -Force
} catch {
    Handle-Error "Failed to copy profile script: $_"
}

# Copy theme script
try {
    Copy-Item -Path $sourceThemePath -Destination "$env:POSH_THEMES_PATH\pyyupsk.omp.json" -Force
} catch {
    Handle-Error "Failed to copy theme script: $_"
}

# Copy wezterm script
try {
    Copy-Item -Path $sourceWeztermPath -Destination "$env:HOMEPATH\.wezterm.lua" -Force
} catch {
    Handle-Error "Failed to copy wezterm script: $_"
}

Write-Host "Profile and theme scripts copied successfully!"
Write-Host "Please restart your PowerShell session to apply the changes."
