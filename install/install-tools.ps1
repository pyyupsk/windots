# Function to handle errors
function Handle-Error {
    param (
        [string]$ErrorMessage
    )
    Write-Error $ErrorMessage
    exit 1
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
$tools = @(
    "Git.Git",
    "GlazeWM",
    "AmN.yasb",
    "wez.wezterm",
    "Microsoft.PowerShell",
    "Starship.Starship",
    "eza-community.eza",
    "sharkdp.fd",
    "JesseDuffield.lazygit",
    "macchina",
    "fzf"
)

foreach ($tool in $tools) {
    try {
        Write-Host "Installing $tool..."
        winget install $tool --silent
    } catch {
        Write-Warning "Failed to install ${tool}: $_"
    }
}

# Add OpenSSL to PATH
$openssl_path = "$env:ProgramFiles\Git\usr\bin"
if (Test-Path $openssl_path) {
    $env:Path += ";$openssl_path"
    [Environment]::SetEnvironmentVariable("Path", $env:Path, [System.EnvironmentVariableTarget]::User)
    Write-Host "Added OpenSSL to PATH"
} else {
    Write-Warning "OpenSSL path not found. Please add it manually to your PATH if needed."
}

Write-Host "Tools installed successfully!"
