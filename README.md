# omz-git-branch Plugin

This is an [Oh-My-Zsh](https://github.com/ohmyzsh/ohmyzsh) plugin that augments git features, designed especially for users who prefer aesthetically pleasing branch naming conventions. 

## Example

Branch: `abc-custom-feature-xyz-12345678`
Display: `custom-fe...12345678`

Branch: `user123/repo-9876/fix-bug-in-feature`
Display: `9876/fix...-feature`

## Installation

### Recommened 

To install `omz-git-branch`, you can use the following command:

```sh
sh -c "$(curl -fsSL https://raw.github.com/cpwillis/omz-git-branch/main/install.sh)"
```

### Alternative

You can clone the repository into your `~/.oh-my-zsh/custom/plugins` directory:

```sh
git clone https://github.com/cpwillis/omz-git-branch.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/omz-git-branch
```

After cloning, add `omz-git-branch` to your `.zshrc` plugins list:

```sh
plugins=(... omz-git-branch)
```

### Helpers

During installation, you can enhance Git with extra settings and aliases using `config.sh`. You can run this script later if you initially skip it. Plus, a predefined reset command is available for reverting to default settings.

## Customisation

By default, `omz-git-branch` will truncate branch names to 20 characters in total. It is designed to omit the team name prefix while ensuring the inclusion of critical identifiers like Pivotal Tracker IDs at the end.

You can customize the plugin behavior with the following `git config` commands:

- **max-branch-length:** Sets the maximum length of the branch name displayed in your prompt. Defaults to 20.

  ```sh
  git config --global oh-my-zsh.max-branch-length 20
  ```

- **prefix-regex:** Applies a regex, where the first match will be removed from the branch name. By default, this is not used. For TNWInc style, it would remove everything up to the first '-' character.

  ```sh
  git config --global oh-my-zsh.prefix-regex '.*?-'
  ```

- **prefix-length:** Removes `n` characters from the beginning of the branch name. Useful for branches with a fixed-length prefix. Defaults to 0.

  ```sh
  git config --global oh-my-zsh.prefix-length 0
  ```

- **suffix-length:** Ensures that `n` characters at the end of the branch name are always included. Defaults to 0 with manual install, set to 8 by install script.

  ```sh
  git config --global oh-my-zsh.suffix-length 8
  ```

## Contributing

Contributions are welcome! If you'd like to improve `omz-git-branch`, please feel free to fork the repository, make your changes, and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
