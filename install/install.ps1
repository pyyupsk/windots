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

try {
    # Run the install-tools.ps1 script
    .\install\install-tools.ps1
} catch {
    Handle-Error "Failed to run install-tools.ps1: $_"
}

# Copy the powershell configuration files to the correct location
$destination = Join-Path (Split-Path -Path $PROFILE) "config"
try {
    # Ensure the config directory exists
    New-Item -ItemType Directory -Path $destination -Force | Out-Null
    Copy-Item -Path ".\powershell\config\*" -Destination $destination -Recurse -Force
    Copy-Item -Path ".\powershell\Microsoft.PowerShell_profile.ps1" -Destination $PROFILE -Force
} catch {
    Handle-Error "Failed to copy PowerShell configuration files: $_"
}

# Install PowerShell modules
$modules = @("PSFzf", "PSReadLine", "Terminal-Icons", "PowerType")
foreach ($module in $modules) {
    if (!(Get-Module -ListAvailable -Name $module)) {
        try {
            Install-Module -Name $module -Scope CurrentUser -Force -AllowPrerelease -SkipPublisherCheck
        } catch {
            Handle-Error "Failed to install module ${module}: ${_}"
        }
    }
}

# Install Nerd Font (JetBrains Mono)
# Credit to https://github.com/ChrisTitusTech/powershell-profile/blob/main/setup.ps1#L20
function Install-NerdFonts {
    param (
        [string]$FontName = "JetBrainsMono",
        [string]$FontDisplayName = "JetBrains Mono",
        [string]$Version = "3.3.0"
    )

    try {
        # Check if script is running as administrator
        if (-not ([bool](net session 2>$null))) {
            Write-Error "This script requires administrator privileges. Please run as administrator."
            return
        }

        # Check if font is already installed
        if (Test-Path "C:\Windows\Fonts\${FontName}NerdFont-Regular.ttf") {
            Write-Host "Font ${FontDisplayName} is already installed"
            return
        }

        # Define paths and URLs
        $fontZipUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v${Version}/${FontName}.zip"
        $zipFilePath = "$env:TEMP\${FontName}.zip"
        $extractPath = "$env:TEMP\${FontName}"

        # Download the font file (synchronous, no loop)
        $webClient = New-Object System.Net.WebClient
        Write-Host "Downloading font from $fontZipUrl..."
        $webClient.DownloadFile($fontZipUrl, $zipFilePath)
        Write-Host "Download complete."

        # Extract the font ZIP
        Write-Host "Extracting ZIP file..."
        $extractedFiles = Expand-Archive -Path $zipFilePath -DestinationPath $extractPath -Force -PassThru

        # Access the Windows Fonts folder (retry 3 times if it fails)
        $destination = $null
        for ($i = 0; $i -lt 3; $i++) {
            try {
                $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
                if ($destination) { break }
            }
            catch {
                Start-Sleep -Seconds 1
            }
        }

        if (-not $destination) {
            Write-Error "Failed to access the Windows Fonts folder after multiple attempts."
            return
        }

        # Copy font files to Windows Fonts folder
        Write-Host "Copying font files to Windows Fonts folder..."
        Get-ChildItem -Path $extractPath -Recurse -Filter "*.ttf" | ForEach-Object {
            $fontFilePath = $_.FullName
            $fontFileName = $_.Name
            try {
                if (-not(Test-Path "C:\Windows\Fonts\$fontFileName")) {
                    Write-Host "Installing font: $fontFileName"
                    $destination.CopyHere($fontFilePath, 0x10)
                }
            }
            catch {
                Write-Warning "Failed to install font: $fontFileName. Error: $_"
            }
        }

        # Clean up temporary files
        Write-Host "Cleaning up temporary files..."
        Remove-Item -Path $extractPath -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item -Path $zipFilePath -Force -ErrorAction SilentlyContinue
        Write-Host "Installation of ${FontDisplayName} complete!"
    }
    catch {
        Write-Error "Failed to download or install ${FontDisplayName} font. Error: $_"
    }
}

try {
    Install-NerdFonts -FontName "JetBrainsMono" -FontDisplayName "JetBrains Mono"
} catch {
    Handle-Error "Failed to install Nerd Font: $_"
}

Write-Host "PowerShell profile setup, modules installed, and Nerd Font installed successfully!"

# Run the post-install.ps1 script
try {
    .\install\post-install.ps1
} catch {
    Handle-Error "Failed to run post-install.ps1: $_"
}