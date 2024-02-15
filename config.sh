#!/bin/zsh

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
