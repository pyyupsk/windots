# Disable PowerShell telemetry if running as SYSTEM
if ([System.Security.Principal.WindowsIdentity]::GetCurrent().IsSystem) {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}

# Initialize Fast Node Manager (fnm) and set up environment
fnm env --use-on-cd | Out-String | Invoke-Expression

# Import modules and configure settings
$modules = @('PSReadLine', 'PSFzf', 'Terminal-Icons')
$modules | ForEach-Object { Import-Module $_ }

Set-PSReadLineOption -PredictionViewStyle ListView -PredictionSource HistoryAndPlugin
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Enable PowerType for AI-powered command-line suggestions
Enable-PowerType

# Set console encoding to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# Initialize Oh My Posh with custom theme
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\pyyupsk.omp.json" | Invoke-Expression

# Custom aliases and functions for common tasks
$aliases = @{
    'la' = { Get-ChildItem -Force }
    'll' = { Get-ChildItem -Force -Hidden }
    'l' = { Get-ChildItem -Force }
    'nf' = { param($name) New-Item -ItemType "file" -Name $name }
    'nd' = { param($name) New-Item -ItemType "directory" -Name $name }
    'rm' = { param($name) Remove-Item $name }
    'rmrf' = { param($name) Remove-Item $name -Force -Recurse }
    'c' = { Clear-Host }
    'export' = { param($name, $value) Set-Item -Force -Path "env:$name" -Value $value }
    'gs' = { git status }
    'ga' = { git add $args }
    'gaa' = { git add . }
    'gc' = { git commit -m $args }
    'gp' = { git push }
    'gcl' = { git clone $args }
}

$aliases.GetEnumerator() | ForEach-Object { Set-Alias -Name $_.Key -Value $_.Value }

# Help function to display available custom commands
function Show-Help {
    $helpText = @"
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
    Write-Host $helpText
}

# Clear the console and display welcome message
Clear-Host
Write-Host "Welcome to the Pyyupsk PowerShell profile"
Write-Host "Type 'Show-Help' to see a list of available commands"
