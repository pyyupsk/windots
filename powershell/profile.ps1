# Disable PowerShell telemetry if running as SYSTEM
if ([bool]([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem) {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}

# Initialize Fast Node Manager (fnm) and set up environment
fnm env --use-on-cd | Out-String | Invoke-Expression

# Import and configure PSReadLine for better command-line editing
Import-Module PSReadLine
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Import and configure PSFzf for fuzzy finding
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Import Terminal-Icons for better file and folder icons in the console
Import-Module -Name Terminal-Icons

# Enable PowerType for AI-powered command-line suggestions
Enable-PowerType
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView

# Set console encoding to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Initialize Oh My Posh with custom theme
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\pyyupsk.omp.json" | Invoke-Expression

# Custom aliases and functions for common tasks
function la { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function ll { Get-ChildItem -Path . -Force -Hidden | Format-Table -AutoSize }
function l { Get-ChildItem -Path . -Force | Format-Table -AutoSize }
function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }
function nd { param($name) New-Item -ItemType "directory" -Path . -Name $name }
function rm { param($name) Remove-Item -Path $name }
function rmrf { param($name) Remove-Item -Path $name -Force -Recurse }
function c { Clear-Host }
function export { param($name, $value) set-item -force -path "env:$name" -value $value; }

# Git-related aliases
function gs { git status }
function ga { param($name) git add $name }
function gaa { git add . }
function gc { param($message) git commit -m $message }
function gp { git push }
function gcl { param($url) git clone $url }

# Help function to display available custom commands
function Show-Help {
@"
Usage:
    la - List all files in the current directory
    ll - List all files in the current directory with hidden files
    l - List all files in the current directory
    nf <name> - Create a new file in the current directory
    nd <name> - Create a new directory in the current directory
    rm <name> - Remove a file
    rmrf <name> - Remove a file and all its contents
    c - Clear the console
    export <name> <value> - Export a variable
    gs - Get the status of the current git repository
    ga <name> - Add a file to the current git repository
    gaa - Add all files to the current git repository
    gc <message> - Commit changes to the current git repository
    gp - Push changes to the current git repository
    gcl <url> - Clone a git repository
"@
}

# Clear the console and display welcome message
Clear-Host
Write-Host "Welcome to the Pyyupsk PowerShell profile"
Write-Host "Type 'Show-Help' to see a list of available commands"
