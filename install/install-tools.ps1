# Ensure the script is run with admin privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run the script with Administrator privileges."
    Exit
}

# Install Chocolatey
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install winget if not already installed
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    # Download and install the latest release of winget
    $releases_url = "https://api.github.com/repos/microsoft/winget-cli/releases/latest"
    $asset = (Invoke-RestMethod -Uri $releases_url).assets | Where-Object { $_.name -like "*.msixbundle" }
    $download_url = $asset.browser_download_url
    $output_path = "$env:TEMP\winget.msixbundle"
    Invoke-WebRequest -Uri $download_url -OutFile $output_path
    Add-AppxPackage -Path $output_path
}

# Install common tools using winget
scoop install fnm

Write-Host "Tools installed successfully!"
