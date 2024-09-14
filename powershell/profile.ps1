# Set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Initialize Fast Node Manager (fnm) and set up environment
$env:PATH = [System.Environment]::ExpandEnvironmentVariables(
    [System.Environment]::GetEnvironmentVariable("PATH", "Machine") + ";" + 
    [System.Environment]::GetEnvironmentVariable("PATH", "User")
)
fnm env --use-on-cd | Out-String | Invoke-Expression

# Terminal Icons
Import-Module -Name Terminal-Icons

# Enable PowerType
Enable-PowerType

# PSReadLine
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

$ENV:FZF_DEFAULT_OPTS=@"
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
--color=selected-bg:#45475a
--multi
"@

# Initialize Oh My Posh with custom theme
$ohmyposhConfig = "$env:POSH_THEMES_PATH\pyyupsk.omp.json"
oh-my-posh init pwsh --config $ohmyposhConfig | Invoke-Expression

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
function pn { pnpm $args }
function ff { fd $args | fzf }
function fdir { fd --type d }
function fexe { fd --type x }

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
    pn <command> - Run a pnpm command
    ff <name> - Fuzzy find using fd and fzf
    fdir - Find directories
    fexe - Find executables
"@
    Write-Host $helpText
}
