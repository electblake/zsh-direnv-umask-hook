# zsh-direnv-umask-hook

This plugin manages and configures the shell's umask setting dynamically. This plugin is based on an original script by `laggardkernel`, which you can find [here](https://gist.github.com/laggardkernel/38566f4473068c065f1a1ef15e6e1b4a).

It adjusts the umask based on a user-specified environment variable (`UMASK`), or utilizes a sensible default that is set when the shell session starts, making it useful in environments requiring specific security settings for file and directory creation.

Use this with <https://direnv.net> to change UMASK per directory.

## Features

- **Dynamic Umask Configuration:** Sets the umask based on the `UMASK` variable, allowing for custom configuration.
- **Default Umask Backup:** Utilizes a fallback umask set at session start if no custom umask is specified.
- **Environment Flexibility:** Ensures consistent umask settings across various shell instances and working conditions.

## Configuration

### Silent Mode

The `silent` mode controls whether the plugin outputs status messages when the umask is set. To configure this behavior, use the `zstyle` command:

```zsh
# Enable silent mode - suppresses messages about umask changes
zstyle ':direnv-umask-hook' silent true

# Disable silent mode - enables messages about umask changes
zstyle ':direnv-umask-hook' silent false

## Install Instructions

I like zengom so lets start there:

### zgenom

```sh
if ! zgenom saved; then
    echo "Creating a zgenom save"
    # .. other plugins
    zgenom load electblake/zsh-direnv-umask-hook
    
    # save
    zgenom save
fi
```

### Oh My Zsh

1. **Clone the Repository to Oh My Zsh's Custom Plugin Directory:**
   Open your terminal and execute the following command to clone the plugin into the custom plugins directory of Oh My Zsh:
   ```zsh
   git clone https://github.com/electblake/zsh-direnv-umask-hook ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-direnv-umask-hook
   ```

2. **Add the Plugin to Your List of Plugins:**
   You need to edit your `.zshrc` file to include this plugin in the list of Oh My Zsh plugins. Open your `.zshrc` file in a text editor and find the line starting with `plugins=(`. Add `zsh-direnv-umask-hook` to this array. For example:
   ```zsh
   plugins=(git zsh-direnv-umask-hook)
   ```

3. **Apply the Changes:**
   To apply the changes, reload your Zsh configuration by running:
   ```zsh
   source ~/.zshrc
   ```

### Prezto

```zsh
git clone https://github.com/electblake/zsh-direnv-umask-hook ${ZDOTDIR:-~}/.zprezto/contrib/zsh-direnv-umask-hook
echo "zstyle ':prezto:load' pmodule ... 'zsh-direnv-umask-hook'" >> ${ZDOTDIR:-~}/.zpreztorc
source ${ZDOTDIR:-~}/.zpreztorc
```

### Zplug

```zsh
zplug "electblake/zsh-direnv-umask-hook"
zplug install
zplug load
```

### Antigen

```zsh
antigen bundle electblake/zsh-direnv-umask-hook
antigen apply
```

### Zinit

```zsh
zinit light electblake/zsh-direnv-umask-hook
```

### Manual Installation

```zsh
git clone https://github.com/electblake/zsh-direnv-umask-hook ~/path/to/zsh-direnv-umask-hook
echo "source ~/path/to/zsh-direnv-umask-hook/umask-hook.plugin.zsh" >> ~/.zshrc
source ~/.zshrc
```

## Usage

The plugin automatically adjusts the umask whenever the working directory changes or a new shell prompt is displayed, ensuring the umask is correctly set without manual intervention.

> If new to umask <https://www.webune.com/forums/umask-calculator.html> is my favourite calculator

```bash
# set umask for chmod 664
# UMASK     File Permissions    Directory Permissions
# 002       rw-rw-r--           rwxrwxr-x

echo 'export UMASK=002' > /path/to/group/application/.envrc
direnv allow .

# set umask for chmod 644
# UMASK     File Permissions    Directory Permissions
# 022       rw-r--r--           rwxr-xr-x

echo 'export UMASK=022' > /path/to/my/application/.envrc
direnv allow .
```

### Zsh Hooks Used

- **`chpwd` Hook:** This hook triggers the `_umask_hook` function when the current working directory changes.
- **`precmd` Hook:** Executes `_umask_hook` before each command prompt is displayed to set the umask.

## Credits

This plugin is adapted from a script developed by `laggardkernel`, available at [this gist](https://gist.github.com/laggardkernel/38566f4473068c065f1a1ef15e6e1b4a). All modifications and improvements are made with respect to the original work.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any problems or have suggestions, please file an issue on the GitHub repository issue tracker.

