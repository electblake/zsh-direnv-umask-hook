# zsh-direnv-umask-hook

This plugin manages and configures the shell's umask setting dynamically. This plugin is based on an original script by `laggardkernel`, which you can find [here](https://gist.github.com/laggardkernel/38566f4473068c065f1a1ef15e6e1b4a).

It adjusts the umask based on a user-specified environment variable (`UMASK`), or utilizes a sensible default that is set when the shell session starts, making it useful in environments requiring specific security settings for file and directory creation.

Use this with <https://direnv.net> to change UMASK per directory.

## Features

- **Dynamic Umask Configuration:** Sets the umask based on the `UMASK` variable, allowing for custom configuration.
- **Default Umask Backup:** Utilizes a fallback umask set at session start if no custom umask is specified.
- **Environment Flexibility:** Ensures consistent umask settings across various shell instances and working conditions.

## Install

Probably works with all the other plugin managers, install it using github pattern, in zgen its:

**zgen / zgenom**
```sh
if ! zgenom saved; then
    echo "Creating a zgenom save"
    ...

    zgenom load electblake/zsh-direnv-umask-hook

    zgenom save
fi
```

## Usage

The plugin automatically adjusts the umask whenever the working directory changes or a new shell prompt is displayed, ensuring the umask is correctly set without manual intervention.

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

```

### Hooks Used

- **`chpwd` Hook:** This hook triggers the `_umask_hook` function when the current working directory changes.
- **`precmd` Hook:** Executes `_umask_hook` before each command prompt is displayed to set the umask.

## Credits

This plugin is adapted from a script developed by `laggardkernel`, available at [this gist](https://gist.github.com/laggardkernel/38566f4473068c065f1a1ef15e6e1b4a). All modifications and improvements are made with respect to the original work.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any problems or have suggestions, please file an issue on the GitHub repository issue tracker.

