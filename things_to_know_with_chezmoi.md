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
> 1. Not leaving `'` trailing without another closing '`'
> 2. Having spaces..
> 3. etc..

Now, see the script called `run_chezmoi_demonstration.sh.tmpl`. It uses the variable defined in all the different sources to showcase how everything works. :)

If you want to run the script `run_chezmoi_demonstration.sh.tmpl`, run :
```bash
chezmoi apply
```

Now you should see the execution of the script `run_chezmoi_demonstration.sh.tmpl` as `chezmoi_demonstration.sh` :)

## Using scripts in the special folder .chezmoiscripts 

Using scripts inside the special folder .chezmoiscripts located inside the chezmoi **source directory** accessible by `chezmoi cd` are meant for scripts that will have the prefix `run_` and are **meant** to be run. The "modules" scripts that are meant to be sourced or called by the scripts inside `.chezmoiscripts` are to be placed outside of this folder and be called by the scripts inside the `.chezmoiscripts` from `$HOME`.
Let's do an example, say we want to always run the script called `greetings.sh` when executing chezmoi with `chezmoi apply` but `greetings.sh` require the name of the user from another script called `variables.sh`. If we put both in `.chezmoiscripts`, both would have to be rename to add the prefix `run_` or else chezmoi would call an error "chezmoi: [path_to_the_script] : not a script" and since we only want `variables.sh` to be called by `greetings.sh` but not run, then we have to create another folder outside `.chezmoiscripts` to store `variables.sh`. For convenience, say we created a folder in our `source directory` (accessible by `chezmoi cd` !) called `dot_scripts` and place `variables.sh` in it. This folder will be created in the `$HOME` directory of our user when using `chezmoi apply`. Now... how would we call the `variables.sh` script from `greetings.sh` ? We would call `variables.sh` as if `greetings.sh` is placed inside the `$HOME` directory. 
> **Note** : the scripts stored in `.chezmoiscripts` aren't copied to the `$HOME` folder after using `chezmoi apply`. Those scripts are simply run!
