# Zsh umask hook plugin
# This plugin adjusts the umask dynamically based on $UMASK, best used with direnv
# 
# Original Author: laggardkernel <https://gist.github.com/laggardkernel/38566f4473068c065f1a1ef15e6e1b4a>
# (See Original Source for explanations)
#
# Set the initial default umask when the shell starts. This value is used unless overridden by the UMASK variable.

DEFAULT_UMASK=$(umask)
export DEFAULT_UMASK

# Function to update umask
# This function will set the umask to a user-defined value specified in the UMASK variable,
# or revert to the initially recorded default if UMASK is not set.
_umask_hook() {
  # Check if a custom umask is set in UMASK
  if [[ -n $UMASK ]]; then
    if ! zstyle ':direnv-umask-hook' silent true && printf "-- umask-hook: set $UMASK\n"
    umask "$UMASK"
  else
    if ! zstyle ':direnv-umask-hook' silent true && printf "-- umask-hook: reset to $DEFAULT_UMASK\n"
    umask "$DEFAULT_UMASK"
  fi
}

# Utilize autoload to manage function loading efficiently in Zsh
autoload -U add-zsh-hook

# Register _umask_hook to be called whenever the working directory changes
# This ensures that umask is appropriately set based on the current environment conditions.
add-zsh-hook chpwd _umask_hook

# Ensure _umask_hook also runs at shell startup to apply the umask right away.
add-zsh-hook precmd _umask_hook
