# Define a function named git_prompt_info
function git_prompt_info() {
  # Check if git status should be hidden
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    # Get the current git branch name or commit hash
    ref=$(command git symbolic-ref HEAD 2>/dev/null) ||
      ref=$(command git rev-parse --short HEAD 2>/dev/null) || return 0
    ref="$(command echo ${ref#refs/heads/})" # Extract the branch name if it exists
    length=${#ref}                           # Get the length of the branch name or commit hash

    # Get the maximum length of the branch name to display
    maxLength=$(command git config --get oh-my-zsh.max-branch-length 2>/dev/null)
    if [[ -z ${maxLength} ]]; then
      maxLength=20 # Default maximum length
    fi

    # Trim the branch name if it exceeds the maximum length
    if [[ ${length} -gt ${maxLength} ]]; then
      # Get the regex pattern to remove from the branch name
      regex=$(command git config --get oh-my-zsh.prefix-regex 2>/dev/null)
      if [[ -n ${regex} ]]; then
        ref=$(command echo ${ref} | sed "s/${regex}//1")
      fi

      # Get the length of the prefix to remove from the branch name
      prefixLength=$(command git config --get oh-my-zsh.prefix-length 2>/dev/null)
      if [[ -z ${prefixLength} ]]; then
        prefixLength=0 # Default prefix length
      fi
      if [[ ${prefixLength} -gt 0 ]]; then
        prefix=$(command echo ${ref} | cut -c ${prefixLength})
        ref=$(command echo ${ref} | cut -c $(expr ${prefixLength} + 1)-)
        length=${#ref}
      fi
    fi

    # Trim the branch name further if it still exceeds the maximum length
    if [[ ${length} -gt ${maxLength} ]]; then
      # Get the length of the suffix to remove from the branch name
      suffixLength=$(command git config --get oh-my-zsh.suffix-length 2>/dev/null)
      if [[ -z ${suffixLength} ]]; then
        suffixLength=0 # Default suffix length
      fi

      # Trim the branch name and append ellipsis to indicate truncation
      length=${#ref}
      suffixStart=$(expr ${length} - ${suffixLength} + 1)
      separatorLength=3 # Length of the separator "..."
      nameEnd=$(expr ${maxLength} - ${suffixLength} - ${separatorLength})
      ref="$(command echo ${ref} | cut -c 1-${nameEnd})...$(command echo ${ref} | cut -c ${suffixStart}-)"
    fi

    # Print the formatted branch name
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}
