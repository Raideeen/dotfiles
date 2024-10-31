# Things to know when using chezmoi

## Testing and understanding chezmoi mechanic

First thing first, the best way to learn how to use chezmoi is to see other people dotfiles ([example](https://github.com/shunk031/dotfiles)) and also to check out the [reference](https://www.chezmoi.io/reference/) section of the wiki. The reference section is a in-depth approach on how chezmoi works, that covers what the [quick start](https://www.chezmoi.io/quick-start/) don't.  

To test how chezmoi works pratically, initialize chezmoi with

```bash
chezmoi init
```

> Any time you change the `.chezmoi.toml.tmpl` you'll have to run `chezmoi init` to update `chezmoi` database :)

Use `chezmoi cd` to automatically `cd` to `$HOME/.local/share/chezmoi`.
Here, you can create script that use [templates](https://www.chezmoi.io/user-guide/templating/) to perform certains tasks depending on variables created either in :

- `.chezmoidata.$FORMAT` where all the variables you create are now accessible in script using : {{ .NameOfTheVariable }} (the format is either `json`, `jsonc`, `toml` or `yaml`)
- `.chezmoi.$FORMAT.tmpl` which is run on a new machine after doing `chezmoi init`. It is useful to prompt the user for their email address. The variables defined in the `data` section, (`[data]`) if you use `FORMAT=toml`. You can also use the variables in script with this syntax : {{ .NameOfTheVariable }}. For example : email={{ .email }}
- `.chezmoi.NameOfTheVariable` which is all the variables that are populated by default (and also, later, all the variables added by using .chezmoidata.$FORMAT and .chezmoi.$FORMAT.tmpl) and usable using the following syntax : {{ .chezmoi.NameOfTheVariable }. For example : username={{ .chezmoi.username }}. You can check all the variables that are usable using this command `chezmoi data`.

> A good thing to know is that the variable must **not** have spaces in the value! For example, you want to create a message in `.chezmoidata.toml` you should write `message = "Hello_From_Chezmoi_Data!` rather than `message = "Hello From Chezmoi Data!"`
>
> Basically, you have to consider the value of a variable as being "valid" which means it have to respect certains rules like :
>
> 1. Not leaving `'` trailing without another closing '`'
> 2. Having spaces..
> 3. etc..

Now, see the script called `run_chezmoi_demonstration.sh.tmpl`. It uses the variable defined in all the different sources to showcase how everything works. :)

If you want to run the script `run_chezmoi_demonstration.sh.tmpl`, run :

```bash
chezmoi apply
```

Now you should see the execution of the script `run_chezmoi_demonstration.sh.tmpl` as `chezmoi_demonstration.sh` :)

## Using Scripts in the Special Folder `.chezmoiscripts`

The special folder `.chezmoiscripts`, located inside the `chezmoi` **source directory** (accessible by running `chezmoi cd`), is intended for scripts that will be executed with a `run_` prefix. Scripts within this folder are designed to be executed rather than sourced or called by other scripts.

For scripts that are meant to be sourced or called by other scripts within `.chezmoiscripts`, they should be placed outside of this folder. This ensures they are accessible without being executed directly by `chezmoi`.

### Example Scenario

Let's say we want to always run a script called `greetings.sh` whenever we execute `chezmoi apply`. This script requires the username from another script called `variables.sh`.

If we placed both `greetings.sh` and `variables.sh` in `.chezmoiscripts`, both would need the `run_` prefix to avoid the `chezmoi: [path_to_the_script]: not a script` error. However, we only want `greetings.sh` to be executed directly, while `variables.sh` should be sourced by `greetings.sh`.

To handle this, we create another folder in our source directory called `dot_scripts` to store `variables.sh`. This folder will be created in the `$HOME` directory when using `chezmoi apply`.

Here's the structure:

```
.chezmoiscripts/
└── run_greetings.sh
dot_scripts/
└── variables.sh
```

#### `variables.sh` (stored in `dot_scripts`)

```bash
#!/usr/bin/env bash
USER_NAME="John Doe"
```

#### `run_greetings.sh` (stored in `.chezmoiscripts`)

```bash
#!/usr/bin/env bash

# Source the variables.sh script
source "$HOME/.scripts/variables.sh" # Note that we replaced "_dot" with an actual dot "."

# Print a greeting message
echo "Hello, $USER_NAME! Welcome to your configured environment."
```

### Explanation

1. **Script Placement**: `run_greetings.sh` is placed in the `.chezmoiscripts` folder and will be executed when you run `chezmoi apply`. `variables.sh` is placed in the `dot_scripts` folder, which will be created in `$HOME` after applying `chezmoi`.

2. **Script Execution**: `run_greetings.sh` sources `variables.sh` from `$HOME/dot_scripts` as if `run_greetings.sh` itself is in `$HOME`.

3. **Running `chezmoi apply`**: This will execute `run_greetings.sh`, which in turn sources `variables.sh` and prints the greeting message.

> **Note**: Scripts stored in `.chezmoiscripts` are not copied to the `$HOME` folder after running `chezmoi apply`. They are simply executed directly.

This setup allows you to organize your scripts efficiently, ensuring that only the necessary scripts are executed while others are sourced as needed.
