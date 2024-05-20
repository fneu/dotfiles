# install with scoop:
# git
# fzf
# PSfzf
# starship

# config as a git alias for managing dotfiles
function config { & git --git-dir=$HOME\.cfg\ --work-tree=$HOME $args}

# go to C and D drive
function cdc { & cd C:\ }
function cdd { & cd D:\ }

# Fancy completion, especially for git
Import-Module Posh-Git
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Color overrides
$colors =@{}
$colors['Command'] = [System.ConsoleColor]::Yellow # The command token color.
$colors['String'] = [System.ConsoleColor]::Green # The string token color.
$colors['Variable'] = [System.ConsoleColor]::Blue # The variable token color.
$colors['Keyword'] = [System.ConsoleColor]::Magenta # The keyword token color.
$colors['Comment'] = [System.ConsoleColor]::DarkGray #+++ The default token color.
$colors['InlinePrediction'] = "`e[90;2;3m" #+++ The color for the inline view of the predictive suggestion.
Set-PSReadlineOption -Colors $colors

#fzf integration:
# Ctrl+t to paste file path
# Ctrl+r to search history
# Alt+c to cd to directory
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Aliase
function fullrebuild {
    Get-ChildItem -Path . -Include bin,obj -Recurse -Force | Remove-Item -Recurse -Force
    dotnet clean
    dotnet build
}

function frb {
    Get-ChildItem -Path . -Include bin,obj -Recurse -Force | Remove-Item -Recurse -Force
    dotnet clean
    dotnet build
}

function rebuild {
    dotnet clean
    dotnet build
}

function rb {
    dotnet clean
    dotnet build
}

function rebuildrun {
    dotnet clean
    dotnet build
    dotnet run
}

function rbr {
    dotnet clean
    dotnet build
    dotnet run
}

# nicer ls with colors
# Install with `Install-Module Get-ChildItemCOlor`
Import-Module Get-ChildItemColor
Set-Alias -Name dir -Value Get-ChildItemColor -Option AllScope
Set-Alias -Name ls -Value Get-ChildItemColorFormatWide

# prompt
Invoke-Expression (&starship init powershell)
$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    if ($current_location.Provider.Name -eq "FileSystem") {
        $ansi_escape = [char]27
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    $host.ui.Write($prompt)
}
