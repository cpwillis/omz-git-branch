#!/bin/sh

# Install the omz-git-branch plugin
PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins/omz-git-branch"

# Ensure git is installed
if ! command -v git >/dev/null 2>&1; then
    echo "Error: Please install Git first, visit https://git-scm.com/downloads for more information." >&2
    exit 1
fi

# Remove existing plugin directory if it exists
if [ -d "$PLUGIN_DIR" ]; then
    printf "The omz-git-branch plugin directory already exists at %s.\n" "$PLUGIN_DIR"
    printf "Do you want to remove it and proceed with the installation? (y/n) "
    read -r REPLY
    case "$(printf "%s" "$REPLY" | tr '[:upper:]' '[:lower:]')" in
    y | yes)
        rm -rf "$PLUGIN_DIR" || {
            echo "Failed to remove the existing directory. Check your permissions." >&2
            exit 1
        }
        printf "Existing omz-git-branch plugin directory removed successfully.\n"
        ;;
    *)
        echo "Installation cancelled by the user."
        exit 1
        ;;
    esac
fi

# Clone the omz-git-branch repository
if ! git clone https://github.com/cpwillis/omz-git-branch.git "$PLUGIN_DIR"; then
    echo "Failed to clone the repository. Please check your connection or if the URL is correct." >&2
    exit 1
fi

# Add omz-git-branch plugin to .zshrc if it's available
ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
    if grep -q "omz-git-branch" "$ZSHRC"; then
        echo "omz-git-branch plugin already exists in .zshrc."
    else
        sed -i.bak '/^plugins=/ s/$/ omz-git-branch/' "$ZSHRC" && rm "$ZSHRC.bak"
        printf "omz-git-branch plugin added to your .zshrc file.\n"
    fi
else
    echo "Warning: .zshrc file not found. You may need to manually add 'omz-git-branch' to your shell configuration." >&2
    exit 1
fi

printf "omz-git-branch plugin setup complete. Please restart your terminal or run 'source ~/.zshrc' to apply changes.\n"
