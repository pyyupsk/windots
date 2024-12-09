# Common aliases
function la { eza -l -a --icons }
function ll { eza -T --icons }
function lla { eza -T -a --icons }
function l { eza -l --icons }
function nf { param($name) New-Item -ItemType "file" -Name $name }
function nd { param($name) New-Item -ItemType "directory" -Name $name }
function rm { param($name) Remove-Item $name }
function rmrf { param($name) Remove-Item $name -Force -Recurse }
function c { Clear-Host }
function wget { wget2 $args }

# Git aliases
function gs { git status }
function gsvl { git status -v > gitstatus.txt }
function ga { git add $args }
function gaa { git add . }
function gcl { git clone $args }

# Docker aliases
function dps { docker ps $args }
function dimg { docker images $args }
function dexec { docker exec -it $args }
function dc { docker-compose $args }

# Development aliases
function dev { Set-Location "G:\Projects" }
function code { windsurf $args }
function kill-port {
    param(
        [Parameter(Mandatory=$true)]
        [int]$port
    )
    $process = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue | Select-Object -ExpandProperty OwningProcess
    if ($process) {
        Stop-Process -Id $process -Force
        Write-Host "Process using port $port has been terminated"
    } else {
        Write-Host "No process found using port $port"
    }
}

# fzf aliases
function ff { fd $args | fzf }
function fdir { fd --type d }
function fexe { fd --type x }
function bf { fzf --preview "bat --color=always --style=numbers --line-range=:500 {}" }

# Other aliases
function http {
    param(
        [Parameter(Mandatory=$false)]
        [ValidateSet(
            "100", "101", "200", "201", "202", "203", "204", "205", "206", "207", "208", "226",
            "300", "301", "302", "303", "304", "305", "306", "307", "308",
            "400", "401", "402", "403", "404", "405", "406", "407", "408", "409", "410", "411", "412",
            "413", "414", "415", "416", "417", "418", "421", "422", "423", "424", "425", "426", "428",
            "429", "431", "451",
            "500", "501", "502", "503", "504", "505", "506", "507", "508", "510", "511"
        )]
        [string]$code
    )

    # Create a hash table with all the HTTP status codes
    $httpCodes = @{
        "100"="Continue"; "101"="Switching Protocols"
        "200"="OK"; "201"="Created"; "202"="Accepted"; "203"="Non-Authoritative Information"; "204"="No Content"; "205"="Reset Content"; "206"="Partial Content"; "207"="Multi-Status"; "208"="Already Reported"; "226"="IM Used"
        "300"="Multiple Choices"; "301"="Moved Permanently"; "302"="Found"; "303"="See Other"; "304"="Not Modified"; "305"="Use Proxy"; "306"="Switch Proxy"; "307"="Temporary Redirect"; "308"="Permanent Redirect"
        "400"="Bad Request"; "401"="Unauthorized"; "402"="Payment Required"; "403"="Forbidden"; "404"="Not Found"; "405"="Method Not Allowed"; "406"="Not Acceptable"; "407"="Proxy Authentication Required"; "408"="Request Timeout"; "409"="Conflict"; "410"="Gone"; "411"="Length Required"; "412"="Precondition Failed"; "413"="Payload Too Large"; "414"="URI Too Long"; "415"="Unsupported Media Type"; "416"="Range Not Satisfiable"; "417"="Expectation Failed"; "418"="I'm a teapot"; "421"="Misdirected Request"; "422"="Unprocessable Entity"; "423"="Locked"; "424"="Failed Dependency"; "425"="Too Early"; "426"="Upgrade Required"; "428"="Precondition Required"; "429"="Too Many Requests"; "431"="Request Header Fields Too Large"; "451"="Unavailable For Legal Reasons"
        "500"="Internal Server Error"; "501"="Not Implemented"; "502"="Bad Gateway"; "503"="Service Unavailable"; "504"="Gateway Timeout"; "505"="HTTP Version Not Supported"; "506"="Variant Also Negotiates"; "507"="Insufficient Storage"; "508"="Loop Detected"; "510"="Not Extended"; "511"="Network Authentication Required"
    }

    # If no code is given, show all the HTTP status codes
    if (!$code) {
        $httpCodes.GetEnumerator() | Sort-Object -Property Name | Format-List
    }

    # If a code is given, show the corresponding status text
    if ($httpCodes.ContainsKey($code)) {
        Write-Host $httpCodes[$code]
    }
}