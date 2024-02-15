#!/bin/zsh

# Install the omz-git-branch plugin
PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins/omz-git-branch"

# Ensure git is installed
if ! command -v git &>/dev/null; then
    echo "Error: Please install Git first, visit https://git-scm.com/downloads for more information."
    exit 1
fi

# Remove existing plugin directory if it exists (prompt for confirmation)
if [[ -d "$PLUGIN_DIR" ]]; then
    echo "The omz-git-branch plugin directory already exists at $PLUGIN_DIR."
    echo -n "Do you want to remove it and proceed with the installation? (y/n) "
    read REPLY

    # Normalize the response to lowercase before matching for broader acceptance of user input
    case "${REPLY:l}" in
    y | yes)
        if rm -rf "$PLUGIN_DIR"; then
            echo "Existing omz-git-branch plugin directory removed successfully."
        else
            echo "Failed to remove the existing directory. Check your permissions."
            exit 1
        fi
        ;;
    *)
        echo "Installation cancelled by the user."
        exit 1
        ;;
    esac
fi

# Clone the omz-git-branch repository
git clone https://github.com/cpwillis/omz-git-branch.git "$PLUGIN_DIR" || {
    echo "Failed to clone the repository. Please check your connection or if the URL is correct."
    exit 1
}

# Add omz-git-branch plugin to .zshrc
if ! grep -q "omz-git-branch" ~/.zshrc; then
    echo "omz-git-branch plugin added to your .zshrc file."
    sed -i.bak '/^plugins=(/s/$/ omz-git-branch/' ~/.zshrc && rm ~/.zshrc.bak
else
    echo "omz-git-branch plugin already exists in .zshrc."
fi

# Ask whether to configure additional git settings and aliases
read -p "Would you like to configure additional useful git settings and aliases? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "You can run ${PLUGIN_DIR}/config.sh later if you decide you want to configure additional settings."
    exit 1
fi

echo "omz-git-branch plugin setup complete. Please restart your terminal or run 'source ~/.zshrc' to apply changes."
