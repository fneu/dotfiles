# Dotfiles, mostly for nvim on windows

## Install on a new machine

- set temporary config alias in current shell.
    - on windows:

    ```function config {& git --git-dir=$HOME\.cfg\ --work-tree=$HOME $args}```

    - on linux:

    ```alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'```

- clone dotfiles into a *bare* repositofy in ~/.cfg:

```git clone --bare git@github.com:fneu/dotfiles.git $HOME/.cfg```

- checkout the actual content from the bare repository to `$HOME`:

```config checkout```

This might fail if some files are already present. Rename or delete them.

- Set the flag `showUntrackedFiles` to `no` locally, to not have everything in `$HOME` show up on running `config status`.

```config config --local status.showUntrackedFiles no```

- done! From now on, the `config` (git) command can be used to manage the dotfiles 

I found this approach in [this](https://www.atlassian.com/git/tutorials/dotfiles) blogpost
