# Function to handle errors
function Handle-Error {
    param (
        [string]$ErrorMessage
    )
    Write-Error $ErrorMessage
    exit 1
}

try {
    # Run the install-tools.ps1 script
    irm "https://github.com/pyyupsk/dotfiles/raw/main/install/install-tools.ps1" | iex
} catch {
    Handle-Error "Failed to run install-tools.ps1: $_"
}

# Find or create PowerShell profile
if (!(Test-Path -Path $PROFILE)) {
    try {
        New-Item -ItemType File -Path $PROFILE -Force
    } catch {
        Handle-Error "Failed to create PowerShell profile: $_"
    }
}

# Install PowerShell modules
$modules = @("PSFzf", "PSReadLine", "Terminal-Icons", "PowerType")
foreach ($module in $modules) {
    if (!(Get-Module -ListAvailable -Name $module)) {
        try {
            Install-Module -Name $module -Scope CurrentUser -Force -AllowPrerelease -SkipPublisherCheck
        } catch {
            Handle-Error "Failed to install module $module: $_"
        }
    }
}

# Install Oh-My-Posh
try {
    winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
} catch {
    Handle-Error "Failed to install Oh-My-Posh: $_"
}

# Install Nerd Font (CascadiaCode)
# Credit to https://github.com/ChrisTitusTech/powershell-profile/blob/main/setup.ps1#L20
function Install-NerdFonts {
    param (
        [string]$FontName = "CascadiaCode",
        [string]$FontDisplayName = "CaskaydiaCove NF",
        [string]$Version = "3.2.1"
    )

    try {
        [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
        $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
        if ($fontFamilies -notcontains "${FontDisplayName}") {
            $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${Version}/${FontName}.zip"
            $zipFilePath = "$env:TEMP\${FontName}.zip"
            $extractPath = "$env:TEMP\${FontName}"

            $webClient = New-Object System.Net.WebClient
            $webClient.DownloadFileAsync((New-Object System.Uri($fontZipUrl)), $zipFilePath)

            while ($webClient.IsBusy) {
                Start-Sleep -Seconds 2
            }

            Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force
            $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
            Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
                If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {
                    $destination.CopyHere($_.FullName, 0x10)
                }
            }

            Remove-Item -Path $extractPath -Recurse -Force
            Remove-Item -Path $zipFilePath -Force
        } else {
            Write-Host "Font ${FontDisplayName} already installed"
        }
    }
    catch {
        Write-Error "Failed to download or install ${FontDisplayName} font. Error: $_"
    }
}
try {
    Install-NerdFonts -FontName "CascadiaCode" -FontDisplayName "CaskaydiaCove NF"
} catch {
    Handle-Error "Failed to install Nerd Font: $_"
}

Write-Host "PowerShell profile setup, modules installed, Oh-My-Posh installed, and Nerd Font installed successfully!"

# Run the post-install.ps1 script
try {
    irm "https://github.com/pyyupsk/dotfiles/raw/main/install/post-install.ps1" | iex
} catch {
    Handle-Error "Failed to run post-install.ps1: $_"
}