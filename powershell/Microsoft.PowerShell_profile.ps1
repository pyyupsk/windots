# Source all configuration files
$configPath = Join-Path $PSScriptRoot "config"

$source = @(
    "encoding.ps1",
    "modules.ps1",
    "aliases.ps1",
    "help.ps1",
    "prompt.ps1"
)

# Source each configuration file
foreach ($file in $source) {
    $filePath = Join-Path $configPath $file
    if (Test-Path $filePath) {
        . $filePath
    } else {
        Write-Warning "Configuration file not found: $file"
    }
}
