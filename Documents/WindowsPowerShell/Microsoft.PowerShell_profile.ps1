# The following should exist:
# git
# fzf
# PSfzf (Install with Install-Module)
# Posh Git (Install with Install-Module)
# Get-ChildItemColor (Install with Install-Module)

# config as a git alias for managing dotfiles
function config { & git --git-dir=$HOME\.cfg\ --work-tree=$HOME $args}

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
Set-PSReadlineOption -Colors $colors

# fzf integration:
# Ctrl+t to paste file path
# Ctrl+r to search history
# Alt+c to cd to directory
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

# nicer ls with colors
Import-Module Get-ChildItemColor
Set-Alias -Name dir -Value Get-ChildItemColor -Option AllScope
Set-Alias -Name ls -Value Get-ChildItemColorFormatWide -Option AllScope

# PROMPT

# Disable Python venv's own prompt decoration
$env:VIRTUAL_ENV_DISABLE_PROMPT = '1'

# ANSI helpers
$script:e      = [char]27  # ESC
$script:Reset  = "${e}[0m"
$script:Red    = "${e}[31m"
$script:Green  = "${e}[32m"
$script:Yellow = "${e}[33m"
$script:Cyan   = "${e}[36m"

function Get-VirtualEnvSegment {
    # Prefer VIRTUAL_ENV_PROMPT; else use venv folder name
    $venvPrompt = $env:VIRTUAL_ENV_PROMPT
    if ([string]::IsNullOrWhiteSpace($venvPrompt) -and -not [string]::IsNullOrWhiteSpace($env:VIRTUAL_ENV)) {
        $venvPrompt = Split-Path -Path $env:VIRTUAL_ENV -Leaf
    }
    if (-not [string]::IsNullOrWhiteSpace($venvPrompt)) {
        return "(${Red}${venvPrompt}${Reset}) "
    }
    return ""
}

function Get-PathSegment {
    $path = (Get-Location).Path
    return "${Cyan}${path}${Reset}"
}

function Get-GitSegment {
    if (-not (Get-Module posh-git)) {
        Import-Module posh-git -ErrorAction SilentlyContinue | Out-Null
    }
    $s = Get-GitStatus
    if ($null -ne $s -and -not [string]::IsNullOrWhiteSpace($s.Branch)) {
        $branch = $s.Branch
        if ($s.Working.Unmerged) {
            return " ${Red}${branch}${Reset}"
        } elseif ($s.HasIndex -or $s.HasWorking -or $s.HasUntracked) {
            return " ${Yellow}${branch}${Reset}"
        } else {
            return " ${Green}${branch}${Reset}"
        }
    }
    return ""
}

function Prompt {
    $venv = Get-VirtualEnvSegment
    $path = Get-PathSegment
    $git  = Get-GitSegment
    $end  = "> "
    return "$venv$path$git$end"
}
