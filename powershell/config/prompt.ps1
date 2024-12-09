# Set up starship prompt
Invoke-Expression (&starship init powershell)

# Set up zoxide
Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
