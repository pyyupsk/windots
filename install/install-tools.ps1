# Function to handle errors
function Handle-Error {
    param (
        [string]$ErrorMessage
    )
    Write-Error $ErrorMessage
    exit 1
}

# Ensure the script is run with admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Handle-Error "Please run the script with Administrator privileges."
}

# Install Chocolatey
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    try {
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    } catch {
        Handle-Error "Failed to install Chocolatey: $_"
    }
}

# Install winget if not already installed
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    try {
        $releases_url = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
        $asset = (Invoke-RestMethod -Uri $releases_url).assets | Where-Object { $_.name -like "*.msixbundle" }
        $download_url = $asset.browser_download_url
        $output_path = "$env:TEMP\winget.msixbundle"
        Invoke-WebRequest -Uri $download_url -OutFile $output_path
        Add-AppxPackage -Path $output_path
    } catch {
        Handle-Error "Failed to install winget: $_"
    }
}

# Install common tools using winget
try {
    winget install Schniz.fnm
} catch {
    Handle-Error "Failed to install fnm using winget: $_"
}

Write-Host "Tools installed successfully!"
