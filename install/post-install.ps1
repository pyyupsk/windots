# Function to handle errors
function Handle-Error {
    param (
        [string]$ErrorMessage
    )
    Write-Error $ErrorMessage
    exit 1
}

# Define URLs for the profile and theme scripts
$profileScriptUrl = "https://github.com/pyyupsk/dotfiles/raw/main/powershell/profile.ps1"
$themeScriptUrl = "https://github.com/pyyupsk/dotfiles/raw/main/oh-my-posh/pyyupsk.omp.json"

# Define paths for the downloaded scripts
$profilePath = $PROFILE
$themePath = "$env:POSH_THEMES_PATH\pyyupsk.omp.json"

try {
    if (-not (Test-Path $themePath)) {
        New-Item -ItemType File -Path $themePath -Force | Out-Null
    }
} catch {
    Handle-Error "Failed to create theme file: $_"
}

# Download profile script
try {
    Invoke-WebRequest -Uri $profileScriptUrl -OutFile $profilePath -UseBasicParsing | Out-Null
} catch {
    Handle-Error "Failed to download profile script: $_"
}

# Download theme script
try {
    Invoke-WebRequest -Uri $themeScriptUrl -OutFile $themePath
} catch {
    Handle-Error "Failed to download theme script: $_"
}

# Reload the profile
try {
    & $profile
} catch {
    Handle-Error "Failed to reload profile: $_"
}

Write-Host "Profile and theme scripts downloaded and profile reloaded successfully!"
