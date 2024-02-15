#!/bin/sh

# Install the omz-git-branch plugin
PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins/omz-git-branch"

# Ensure git is installed
if ! command -v git >/dev/null 2>&1; then
    printf "Error: Please install Git first, visit https://git-scm.com/downloads for more information.\n" >&2
    exit 1
fi

# Remove existing plugin directory if it exists (prompt for confirmation)
if [ -d "$PLUGIN_DIR" ]; then
    printf "The omz-git-branch plugin directory already exists at %s.\n" "$PLUGIN_DIR"
    printf "Do you want to remove it and proceed with the installation? (y/n) "
    read -r REPLY

    # Normalize the response to lowercase before matching for broader acceptance of user input
    case "$(printf "%s" "$REPLY" | tr '[:upper:]' '[:lower:]')" in
    y | yes)
        if rm -rf "$PLUGIN_DIR"; then
            printf "Existing omz-git-branch plugin directory removed successfully.\n"
        else
            printf "Failed to remove the existing directory. Check your permissions.\n" >&2
            exit 1
        fi
        ;;
    *)
        printf "Installation cancelled by the user.\n"
        exit 1
        ;;
    esac
fi

# Clone the omz-git-branch repository
if ! git clone https://github.com/cpwillis/omz-git-branch.git "$PLUGIN_DIR"; then
    printf "Failed to clone the repository. Please check your connection or if the URL is correct.\n" >&2
    exit 1
fi

# Add omz-git-branch plugin to .zshrc if it's available
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    # Check if the plugin is already added
    if grep -q "omz-git-branch" "$ZSHRC"; then
        printf "omz-git-branch plugin already exists in .zshrc.\n"
    else
        # Append the plugin to the .zshrc file
        if ! grep -q "^plugins=" "$ZSHRC"; then
            printf "plugins=(omz-git-branch)\n" >>"$ZSHRC"
        else
            sed -i.bak 's/^plugins=(/&omz-git-branch /' "$ZSHRC" && rm "$ZSHRC.bak"
        fi

        if [ $? -eq 0 ]; then
            printf "omz-git-branch plugin added to your .zshrc file.\n"
        else
            printf "Failed to add omz-git-branch plugin to .zshrc. Check your permissions.\n" >&2
            exit 1
        fi
    fi
else
    printf "Warning: .zshrc file not found. You may need to manually add 'omz-git-branch' to your shell configuration.\n" >&2
    exit 1
fi

# Ask whether to configure additional git settings and aliases
printf "Would you like to configure additional useful git settings and aliases? (y/n) "
read -r REPLY
if printf "%s" "$REPLY" | grep -Eq '^[Yy]$'; then
    # Grant execute permissions to config.sh
    if chmod +x "${PLUGIN_DIR}/config.sh"; then
        # Execute config.sh
        if "${PLUGIN_DIR}/config.sh"; then
            apply_settings
            printf "Additional git settings and aliases have been applied.\n"
        else
            printf "Failed to execute ${PLUGIN_DIR}/config.sh. Check the script path and permissions.\n" >&2
            exit 1
        fi
    fi
else
    printf "You chose not to configure additional git settings and aliases.\n"
    printf "You can run %s/config.sh later if you decide you want to configure additional settings.\n" "$PLUGIN_DIR"
fi

printf "omz-git-branch plugin setup complete. Please restart your terminal or run 'source ~/.zshrc' to apply changes.\n"
