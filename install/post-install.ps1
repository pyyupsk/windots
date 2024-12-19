# Function to handle errors
function Handle-Error {
    param (
        [string]$ErrorMessage
    )
    Write-Error $ErrorMessage
    exit 1
}

# Define paths for the source and destination scripts
$sourceBatPath = ".\bat\config"
$sourceFlowLauncherPath = ".\flow-launcher"
$sourceGlazeWMPath = ".\glazewm\config.yaml"
$sourceStarshipPath = ".\starship\starship.toml"
$sourceWeztermPath = ".\wezterm\.wezterm.lua"
$sourceYasbPath = ".\yasb"
$sourceYaziPath = ".\yazi"

# Bat theme
wget -P "$(bat --config-dir)/themes" "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme"
bat cache --build

# Copy the scripts to the correct location
try {
    Copy-Item -Path $sourceBatPath -Destination "$(bat --config-file)" -Force -Recurse
    Copy-Item -Path $sourceFlowLauncherPath -Destination "$env:USERPROFILE\AppData\Roaming\FlowLauncher" -Force -Recurse
    Copy-Item -Path $sourceGlazeWMPath -Destination "$env:HOMEPATH\.glzr\glazewm\config.yaml" -Force -Recurse
    Copy-Item -Path $sourceStarshipPath -Destination "$env:HOMEPATH\.config\starship.toml" -Force -Recurse
    Copy-Item -Path $sourceWeztermPath -Destination "$env:HOMEPATH\.wezterm.lua" -Force -Recurse
    Copy-Item -Path $sourceYasbPath -Destination "$env:HOMEPATH\.config\yasb" -Force -Recurse
    Copy-Item -Path $sourceYaziPath -Destination "$env:USERPROFILE\AppData\Roaming\yazi\config" -Force -Recurse
} catch {
    Handle-Error "Failed to copy scripts: $_"
}

Write-Host "Profile and theme scripts copied successfully!"
Write-Host "Please restart your PowerShell session to apply the changes."
