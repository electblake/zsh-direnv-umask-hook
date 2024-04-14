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
# Sets the umask based on the UMASK environment variable, or falls back to DEFAULT_UMASK if UMASK is not set.
_umask_hook() {
  if [[ -n $UMASK ]]; then
    # Check if silent mode is not enabled before printing; print umask setting message.
    if ! zstyle -t ':direnv-umask-hook' silent; then
      printf "-- umask-hook: set to $UMASK\n"
    fi
    umask "$UMASK"
  else
    local current_umask=$(umask)
    if [[ "$current_umask" != "$DEFAULT_UMASK" ]]; then
      # Print message if umask is reset and silent mode is not enabled.
      if ! zstyle -t ':direnv-umask-hook' silent; then
        printf "-- umask-hook: reset to $DEFAULT_UMASK\n"
      fi
      umask "$DEFAULT_UMASK"
    fi
  fi
}

# Utilize autoload to manage function loading efficiently in Zsh
autoload -U add-zsh-hook

# Register _umask_hook to be called whenever the working directory changes
# This ensures that umask is appropriately set based on the current environment conditions.
add-zsh-hook chpwd _umask_hook

# Ensure _umask_hook also runs at shell startup to apply the umask right away.
add-zsh-hook precmd _umask_hook
