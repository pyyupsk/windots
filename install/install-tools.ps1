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
    "GlazeWM",
    "AmN.yasb",
    "wez.wezterm",
    "Starship.Starship",
    "eza-community.eza",
    "sharkdp.fd",
    "fzf",
    "ajeetdsouza.zoxide",
    "Schniz.fnm",
    "sharkdp.bat",
    "GNU.Wget2",
    "BurntSushi.ripgrep.MSVC"
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

# Bat theme
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme"
bat cache --build

Write-Host "Tools installed successfully!"
