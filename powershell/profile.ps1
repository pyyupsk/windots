# Disable PowerShell telemetry if running as SYSTEM
if ([System.Security.Principal.WindowsIdentity]::GetCurrent().IsSystem) {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}

# Initialize Fast Node Manager (fnm) and set up environment
$env:PATH = [System.Environment]::ExpandEnvironmentVariables(
    [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + 
    [System.Environment]::GetEnvironmentVariable("PATH", "User")
)
fnm env --use-on-cd | Out-String | Invoke-Expression

# Import modules and configure settings
$modules = @('PSReadLine', 'PSFzf', 'Terminal-Icons')
$modules = @('PSReadLine', 'PSFzf', 'Terminal-Icons')
$modules | ForEach-Object { 
    if (Get-Module -ListAvailable -Name $_) {
        Import-Module $_ -ErrorAction SilentlyContinue
    }
}

# Enable the modules and configure settings
Enable-PowerType
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Set console encoding to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# Initialize Oh My Posh with custom theme
$env:POSH_THEMES_PATH = "$env:POSH_THEMES_PATH" # Cache the path
$ohmyposhConfig = "$env:POSH_THEMES_PATH\pyyupsk.omp.json"
if (Test-Path $ohmyposhConfig) {
    oh-my-posh init pwsh --config $ohmyposhConfig | Invoke-Expression
}

# Custom aliases and functions for common tasks
function la { Get-ChildItem -Force }
function ll { Get-ChildItem -Force -Hidden }
function l { Get-ChildItem -Force }
function nf { param($name) New-Item -ItemType "file" -Name $name }
function nd { param($name) New-Item -ItemType "directory" -Name $name }
function rm { param($name) Remove-Item $name }
function rmrf { param($name) Remove-Item $name -Force -Recurse }
function c { Clear-Host }
function export { param($name, $value) Set-Item -Force -Path "env:$name" -Value $value }
function gs { git status }
function gsvl { git status -v > gitstatus.txt }
function ga { git add $args }
function gaa { git add . }
function gcl { git clone $args }

# Help function to display available custom commands
function Show-Help {
    $helpText = @"
Usage:
    ctrl + r - Search for a command
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
    gcl <url> - Clone a git repository
"@
    Write-Host $helpText
}

# Clear the console and display welcome message
Write-Host "Welcome to the Pyyupsk PowerShell profile"
Write-Host "Type 'Show-Help' to see a list of available commands"
