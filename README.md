# sourcerer

__DON'T USE THIS - THIS IS DANGEROUS__

A tool to automatically source a `.sourcerer` file in your shell when entering
this directory via `cd`.

![example](example.gif "example")

This can be used to define startup processes for projects for example start 
docker-containers, boot a database, open an ssh-tunnel or anything else you can 
control via your shell. You could define some aliases or functions on a 
per project basis and much more.

## installation

### Automatically

`curl https://raw.githubusercontent.com/mstruebing/sourcerer/master/install.sh | bash`

This creates a `~/.sourcerer` directory with an `sourcerer` file in there and 
sources this file in your `.profile`, `.bashrc`, `.bash_profile` or `.zshrc`
to give you the `sourcerer` command.
If you are using `zsh` it automatically installs an hook to automatically 
executes `sourcerer` on changing the directory. 
If you are using `bash` it automatically installs a function called `cd`
which uses the built in `cd` command and then calls `sourcerer`.

You are free to change this if you don't want this behavior.

### Manual

If you want to install `sourcerer` manually either need to clone this 
repository and copy or link the `sourcerer` file into your `$PATH`
or source it via your shell: `source /path/to/sourcerer`.
If you want to automatically run `sourcerer` on a directory change read 
the Automatic sourcing on `cd` section below.
 
## usage

You only need to change to a directory with a `.sourcerer` file in it and 
this file gets automatically sourced.
If you want to re-source the file just run `sourcerer`

## Automatic sourcing on `cd`

This is only needed when you have installed `sourcerer` manually, otherwise 
this is already set up for you.

### zsh

If you are using `zsh` you could add this lines to the end of your `.zshrc`:

```
add-zsh-hook chpwd sourcerer
sourcerer
```

This will add an change directory hook that executes `sourcerer` on every `cd`
command and executes `sourcerer` when the shell starts.

Please make sure to add this __after__ the sourcing of 
`sourcerer` (`source /home/<username>/.sourcerer/sourcerer`)

### bash

If you are using `bash` you could add a function that first executes `cd`
and then executes `sourcerer`:

```
function cd() {
    builtin cd "$@" && sourcerer
}
```

Please make sure to add this __after__ the sourcing of 
`sourcerer` (`source /home/<username>/.sourcerer/sourcerer`)
