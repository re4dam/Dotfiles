#!/bin/bash
# Exit immediately if a command exits with a non-zero status.
set -e

# --- Main Function ---
# Organizes the script into logical steps.
main() {
    confirm_system_update
    install_dependencies
    install_pacman_packages
    setup_zsh
    setup_tmux
    install_aur_packages
    final_steps
}

# --- Function Definitions ---

confirm_system_update() {
    read -p "Do you want to perform a full system update? (y/n) " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        echo "INFO: Performing system update..."
        sudo pacman -Syu --noconfirm
    else
        echo "INFO: Update skipped."
    fi
}

install_dependencies() {
    echo "INFO: Installing essential dependencies like git and base-devel..."
    sudo pacman -S --needed --noconfirm git base-devel
}

install_pacman_packages() {
    echo "INFO: Installing official packages from pacman..."
    local packages=(
        stow kitty neovim fastfetch neovide tmux sshfs
        ttf-jetbrains-mono-nerd inter-font exa npm obsidian
    )
    sudo pacman -S --needed --noconfirm "${packages[@]}"
}

setup_zsh() {
    echo "INFO: Setting up Oh My Zsh and plugins..."
    # Install Oh My Zsh non-interactively
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "INFO: Oh My Zsh is already installed. Skipping."
    fi

    # Define the custom plugins directory
    local zsh_custom_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    # Download Zsh plugins
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${zsh_custom_dir}/themes/powerlevel10k" || true
    git clone https://github.com/zsh-users/zsh-completions.git "${zsh_custom_dir}/plugins/zsh-completions" || true
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "${zsh_custom_dir}/plugins/zsh-autosuggestions" || true
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${zsh_custom_dir}/plugins/zsh-syntax-highlighting" || true
}

setup_tmux() {
    echo "INFO: Setting up Tmux Plugin Manager (tpm)..."
    if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    else
        echo "INFO: Tmux Plugin Manager is already installed. Skipping."
    fi
}

install_aur_packages() {
    echo "INFO: Installing packages from the Arch User Repository..."
    local aur_packages=(
        "zen-browser-bin"
        "redhat-fonts"
        "sddm-silent-theme"
    )
    local aur_build_dir="$HOME/git"
    mkdir -p "$aur_build_dir"

    for package in "${aur_packages[@]}"; do
        echo "--- Installing $package ---"
        local package_dir="$aur_build_dir/$package"

        # Remove existing directory to ensure a clean build
        rm -rf "$package_dir"

        git clone "https://aur.archlinux.org/$package.git" "$package_dir"
        cd "$package_dir"

        # Build and install non-interactively
        makepkg -si --noconfirm
    done
}

final_steps() {
    echo "INFO: Running stow command..."
    # This assumes you are running the script from your dotfiles directory.
    # If not, you should run this command manually from the correct location.
    stow .

    echo "✅ Script finished successfully!"
}

# --- Run the Script ---
main
