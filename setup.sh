#!/bin/bash

# update latest package
sudo pacman -Syu

# download stow package through pacman
sudo pacman -S stow

# create symbolic links using stow to all config/local directory
stow .

# download desired packages for personal used
packages=(kitty neovim fastfetch neovide tmux ssh ttf-jetbrains-mono-nerd inter-font exa)

# configuring terminal GUI
# download oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
# download oh my zsh plugins
# powerlevel10k
# zsh-completions
# zsh-autosuggestions
# zsh-syntaxhighlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# arch user repository
mkdir ~/git/
# zen-browser-bin
# redhat-fonts
# sddm-silent-theme
git clone https://aur.archlinux.org/zen-browser-bin.git ~/git/
git clone https://aur.archlinux.org/redhat-fonts.git ~/git/
git clone https://aur.archlinux.org/sddm-silent-theme.git ~/git/
