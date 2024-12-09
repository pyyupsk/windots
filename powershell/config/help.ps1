# Help function to display available custom commands
function Show-Help {
    $helpText = @"
Usage:
    ctrl + r - Search for a command
    la - List all files in the current directory with hidden files
    ll - List all files in the current directory in tree format
    lla - List all files in the current directory in tree format, including hidden files
    l - List all files in the current directory
    nf <n> - Create a new file in the current directory
    nd <n> - Create a new directory in the current directory
    rm <n> - Remove a file
    rmrf <n> - Remove a file and all its contents
    c - Clear the console
    wget - Download a file using wget2 (GNU.Wget2)
    export <n> <value> - Export a variable
    gs - Get the status of the current git repository
    gsvl - Get the verbose status of the current git repository and save to gitstatus.txt
    ga <n> - Add a file to the current git repository
    gaa - Add all files to the current git repository
    gcl <url> - Clone a git repository
    dps - List running Docker containers
    dimg - List Docker images
    dexec <container> <command> - Execute a command in a running Docker container
    dc - Run docker-compose commands
    dev - Navigate to the "G:\Projects" directory
    code <args> - Open files or directories using the windsurf editor
    kill-port <port> - Kill the process using the specified port
    pn <command> - Run a pnpm command
    ff <n> - Fuzzy find files using fd and fzf
    fdir - Find directories using fd
    fexe - Find executables using fd
    lg - Open lazygit interface
    bf - Fuzzy find files with preview using fzf and bat
    mm - Show system information 
    http [code] - Display information about an HTTP status code. If no code is provided, it lists all HTTP status codes.

"@
    Write-Host $helpText
}
