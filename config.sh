#!/bin/sh

apply_settings() {
    # Configure git
    git config --global omzgit.branchprefixlength 0
    git config --global omzgit.branchsuffixlength 8
    git config --global omzgit.branchnamestripprefixregex '^(feature|bugfix|hotfix)/'
    git config --global omzgit.branchnamefixedprefixlength 0

    # Git aliases
    git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    git config --global alias.ci "commit"
    git config --global alias.st "status -sb"
    git config --global alias.br "branch -vv"

    echo "cpwillis/omz-git-branch git settings applied."
}

reset_settings() {

    # Reset or unbind git configurations
    git config --global --unset omzgit.branchprefixlength
    git config --global --unset omzgit.branchsuffixlength
    git config --global --unset omzgit.branchnamestripprefixregex
    git config --global --unset omzgit.branchnamefixedprefixlength

    # Unbind Git aliases
    git config --global --unset alias.lg
    git config --global --unset alias.ci
    git config --global --unset alias.st
    git config --global --unset alias.br

    echo "cpwillis/omz-git-branch git settings reset."
}
