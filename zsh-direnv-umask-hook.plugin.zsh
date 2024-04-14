# Zsh umask hook plugin that adjusts umask dynamically based on the user environment

# Set the default umask when the shell starts
DEFAULT_UMASK=$(umask)
export DEFAULT_UMASK

# Function to update umask based on a condition
_umask_hook() {
  if [[ -n $UMASK ]]; then
    umask "$UMASK"
  else
    umask "$DEFAULT_UMASK"
  fi
}

# Register _umask_hook to run whenever the working directory changes
autoload -U add-zsh-hook
add-zsh-hook chpwd _umask_hook

# Ensure _umask_hook runs at shell startup
add-zsh-hook precmd _umask_hook
