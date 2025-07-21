#!/bin/bash

# Prompt the user confirmation to perform system wide update
read -p "Do you want to perform system update? (y/n) " confirm

# Check user's input was 'y' or 'Y'
if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
    echo "Performing system wide update"
    sudo pacman -Syu
else
    echo "Update skipped"
fi

# download desired arch packages for personal used
packages=(stow kitty neovim fastfetch neovide tmux ssh ttf-jetbrains-mono-nerd inter-font exa npm)
sudo pacman -S "$packages"
stow .

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

# configuring tmux and plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# arch user repository packages
mkdir ~/git/
cd ~/git/

# list of aur-packages to install
aur-packages=("zen-browser-bin" "redhat-fonts" "sddm-silent-theme")

for package in "${aur-packages[@]}"; do
    echo "Installing $package"

    # Clone repository from AUR
    git clone "https://aur.archlinux.org/$package.git"

    # change directory to package
    cd $package

    # Build and install package
    # -s: sync and install dependencies.
    # -i: installs the package.
    makepkg -si

    # return to git directory
    cd ~/git/

    echo "$package installed success"
done

# return to home directory
cd
