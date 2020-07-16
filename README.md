# rcm-managed dotfiles

This repository contains my dotfiles, organized in a way that is
understood by [rcm][].

If you are not me, you will probably not get much use out of it, but
feel free to poke around and borrow any parts you find interesting.


## Setting up

If it's the first time setting up the dotfiles on a machine, run

```bash
$ mkdir -p ~/.config/rcm && cd ~/.config/rcm
$ git clone https://git.kiyuko.org/rcm-dotfiles dotfiles && cd dotfiles
$ git config --local diff.asc.binary true
$ git config --local diff.asc.textconv "gpg -d --quiet --yes --compress-algo=none --no-encrypt-to --batch --use-agent"
```

The last two commands are necessary in order to be able to see plain
text diffs even for encrypted files.

rcm's configuration file is also managed through rcm, but at this
point the software doesn't yet know how to locate it: in order to
bootstrap rcm, run

```bash
$ RCRC=host-$(hostname -s)/rcrc rcup -v
```


## Keeping up to date

Every time changes are made to the repository, run

```bash
$ cd ~/.config/rcm/dotfiles
$ git pull
$ rcup -v
```

to apply them.


## Features

A few bits of functionality that rcm doesn't provide out of the box
are implemented through custom hook scripts.

### Secret files

All `.asc` files in the `_secret/` directory are expected to be
encrypted using GnuPG, and will be decrypted automatically before
being copied to the home directory.

To add a new file, run something like

```bash
$ gpg --armor --encrypt --recipient eof@kiyuko.org --output _secret/foo.asc ~/.foo
```

Quirks / limitations:

  * it's not possible to quickly figure out whether the local version
    of a file is different from the one in the repository;

  * due to the way secret files are handled, it's recommended to add
    the path to the *decrypted* version of a file (eg. `foo` instead
    of `_secret/foo.asc`) to both the `.gitignore` file and the
    `COPY_ALWAYS` rcm variable.

### dconf settings

All files in the `_dconf/` directory are expected to contain dconf
settings. The files must be named after the corresponding dconf path,
with slashes replaced with dots.

To add a new file, run something like

```bash
$ dconf dump /com/example/Foo/ >_dconf/com.example.Foo
```

Quirks / limitations:

  * it's not possible to quickly figure out whether the dconf
    settings currently in use by an application are different from
    those stored in the repository.

### Permissions for ssh configuration files

ssh is, understandably, quite picky about who gets access to its
configuration files. This repository contains a hook that takes care
of adjusting permissions (and SELinux labels where applicable) in a
way that will make ssh accept them.


## License

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.


[rcm]: https://github.com/thoughtbot/rcm
