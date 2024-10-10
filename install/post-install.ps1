# Function to handle errors
function Handle-Error {
    param (
        [string]$ErrorMessage
    )
    Write-Error $ErrorMessage
    exit 1
}

# Define paths for the source and destination scripts\
$sourceWeztermPath = ".\wezterm\.wezterm.lua"
$sourceGlazeWMPath = ".\glazewm\config.yaml"
$sourceYasbPath = ".\yasb"
$sourceProfilePath = ".\powershell\profile.ps1"

# Copy wezterm script
try {
    Copy-Item -Path $sourceWeztermPath -Destination "$env:HOMEPATH\.wezterm.lua" -Force
} catch {
    Handle-Error "Failed to copy wezterm script: $_"
}

# Ensure the destination glazewm directory exists
try {
    if (-not (Test-Path "$env:HOMEPATH\.glzr")) {
        New-Item -ItemType Directory -Path "$env:HOMEPATH\.glzr" -Force | Out-Null
    } elseif (-not (Test-Path "$env:HOMEPATH\.glzr\glazewm")) {
        New-Item -ItemType Directory -Path "$env:HOMEPATH\.glzr\glazewm" -Force | Out-Null
    }
} catch {
    Handle-Error "Failed to create glazewm directory: $_"
}

# Copy glazewm config
try {
    Copy-Item -Path $sourceGlazeWMPath -Destination "$env:HOMEPATH\.glzr\glazewm\config.yaml" -Force
} catch {
    Handle-Error "Failed to copy glazewm script: $_"
}

# E:\Users\pthip\.config\yasb
# Ensure the destination yasb directory exists
try {
    if (-not (Test-Path "$env:USERPROFILE\.config\yasb")) {
        New-Item -ItemType Directory -Path "$env:USERPROFILE\.config\yasb" -Force | Out-Null
    }
} catch {
    Handle-Error "Failed to create yasb directory: $_"
}

# Copy yasb directory
try {
    Copy-Item -Path $sourceYasbPath -Destination "$env:USERPROFILE\.config\yasb" -Recurse -Force
} catch {
    Handle-Error "Failed to copy yasb directory: $_"
}

# Copy profile script
try {
    Copy-Item -Path $sourceProfilePath -Destination $PROFILE -Force
} catch {
    Handle-Error "Failed to copy profile script: $_"
}

# Ensure the destination theme directory exists
try {
    if (-not (Test-Path $env:POSH_THEMES_PATH)) {
        New-Item -ItemType Directory -Path $env:POSH_THEMES_PATH -Force | Out-Null
    }
} catch {
    Handle-Error "Failed to create theme directory: $_"
}

Write-Host "Profile and theme scripts copied successfully!"
Write-Host "Please restart your PowerShell session to apply the changes."
