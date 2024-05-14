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

#fzf integration:
# Ctrl+t to paste file path
# Ctrl+r to search history
# Alt+c to cd to directory
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# Aliase
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
