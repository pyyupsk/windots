# Define URLs for the profile and theme scripts
$profileScriptUrl = "https://github.com/pyyupsk/dotfiles/raw/main/powershell/profile.ps1"
$themeScriptUrl = "https://github.com/pyyupsk/dotfiles/raw/main/oh-my-posh/pyyupsk.omp.json"

# Define paths for the downloaded scripts
$profilePath = $PROFILE
$themePath = "$env:POSH_THEMES_PATH\pyyupsk.omp.json"

if (-not (Test-Path $themePath)) {
    New-Item -ItemType File -Path $themePath -Force | Out-Null
}

# Download profile script
Invoke-WebRequest -Uri $profileScriptUrl -OutFile $profilePath -UseBasicParsing | Out-Null

# Download theme script
Invoke-WebRequest -Uri $themeScriptUrl -OutFile $themePath

# Reload the profile
& $profile

Write-Host "Profile and theme scripts downloaded and profile reloaded successfully!"
