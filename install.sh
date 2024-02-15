#!/bin/zsh

# Install the omz-git-branch plugin

PLUGIN_DIR="$HOME/.oh-my-zsh/custom/plugins/omz-git-branch"

# Ensure git is installed
if ! command -v git &> /dev/null; then
    echo "git could not be found, please install git first."
    exit 1
fi

# Remove existing plugin directory if it exists
if [[ -d "$PLUGIN_DIR" ]]; then
    read "REPLY?The omz-git-branch plugin directory already exists. Do you want to remove it and proceed with the installation? (y/N) "
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$PLUGIN_DIR"
        echo "Existing omz-git-branch plugin directory removed."
    else
        echo "Installation cancelled."
        exit 1
    fi
fi

# Clone the omz-git-branch repository
git clone https://github.com/cpwillis/omz-git-branch.git "$PLUGIN_DIR" || { echo "Cloning failed."; exit 1; }

# Add omz-git-branch plugin to .zshrc
if ! grep -q "omz-git-branch" ~/.zshrc; then
    echo "Adding omz-git-branch plugin to your .zshrc file."
    sed -i '' '/^plugins=(/s/$/ omz-git-branch/' ~/.zshrc
else
    echo "omz-git-branch plugin already added to .zshrc."
fi

echo "omz-git-branch plugin setup complete. Please restart your terminal."
