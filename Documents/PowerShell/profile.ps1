Import-Module posh-git
function config { & git --git-dir=$HOME\.cfg\ --work-tree=$HOME $args}