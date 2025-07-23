# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Add user configurations here
# For HyDE not to touch your beloved configurations,
# we added 2 files to the project structure:
# 1. ~/.hyde.zshrc - for customizing the shell related hyde configurations
# 2. ~/.zshenv - for updating the zsh environment variables handled by HyDE // this will be modified across updates

#  Plugins 
# oh-my-zsh plugins are loaded  in ~/.hyde.zshrc file, see the file for more information

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit
source $ZSH/oh-my-zsh.sh

#  Aliases & Functions 
# Add aliases here
# alias HotDown='cd ~/Documents/Scripting; ./Hotspot_Down.sh; cd ~'
# alias HotUp='cd ~/Documents/Scripting; ./Hotspot.sh; cd ~'
# alias ThemeGogh='cd ~/Documents/Scripting; ./Theme.sh; cd ~'
alias ff='clear; fastfetch'
alias ffidol='ff --config hypr'
alias ffbelfast='ff --config hypr1'
alias ffshizuru='ff --config hypr2'
alias ffeibel='ff --config hypr3'
alias ffmomina='ff --config hypr4'
alias ffmiyamura='ff --config hypr5'

fftheme() {
    clear
    fastfetch --config "hypr$1"
}
# Usage: fftheme 2 -> equivalent to `fastfetch --config hypr2`

# alias eyota='~/Documents/Scripting/eyota.sh'
alias eyota='sudo mount -t ntfs-3g -o rw,uid=$(id -u),gid=$(id -g),iocharset=utf8 /dev/sda1 /mnt/readam'
alias lenovo='sudo mount -t ntfs-3g -o rw,uid=$(id -u),gid=$(id -g),iocharset=utf8 /dev/sdb2 /mnt/takeaway'
alias jakdam='sudo mount -t ntfs-3g -o rw,uid=$(id -u),gid=$(id -g),iocharset=utf8 /dev/nvme0n1p3 /mnt/windows'
alias excalibur='tmux attach || tmux new'
# alias set-ip='~/Documents/Scripting/IP-LINK.sh'

# Directory-related commands
alias home='cd'
alias newhome='cd /mnt/windows/Zaki-Adam/'
alias docs='cd ~/Documents'
alias newdocs='newhome; cd Documents'
alias downloads='cd ~/Downloads'
alias newdownloads='newhome; cd Download'
alias web='cd /var/www/html'
alias ..='cd ..'
alias main='cd ~/ZakiAdam/Zaki-Adam'
alias upi='newhome; cd UPI'
alias hiburan='newhome; cd Hiburan'
alias cdprog='newhome; cd Progrm/'
alias cddpbo='newhome; cd DPBO/'
alias cdc='cdprog; cd C/'
alias cdmnt='cd /mnt/'

drive() {
    cd "/mnt/$1" || echo "Drive not found"
}

goto() {
  cd "/mnt/windows/Zaki-Adam/$1" || echo "Directory not found"
}
# Usage: goto DPBO, goto Hiburan

# Pacman aliases
alias install='sudo pacman -S'
alias uninstall='sudo pacman -Rns'
alias update='sudo pacman -Syu'
alias packages='pacman -Qen'
alias cleancache='sudo pacman -Sc'

# Yay aliases
alias aur-install='yay -S'         # Install package from AUR
alias aur-uninstall='yay -Rns'      # Uninstall package cleanly
alias aur-update='yay -Syu'         # Full system update (repo + AUR)
alias aur-packages='yay -Qm'        # List explicitly installed AUR packages
alias aur-search='yay -Ss'          # Search for a package
alias aur-cleancache='yay -Scc'     # Clean the build cache
alias aur-info='yay -Si'            # Show package information
alias aur-own='yay -Qo'             # Show which package owns a file
alias aur-file='yay -F'             # Search for a file in repositories
alias aur-upgrade='yay -Sua'        # Only upgrade AUR packages

# testing unique
alias nvtest='hyprctl dispatch workspace r+1 && neovide'

# Utilities

neovim() {
  if command -v hyprctl &> /dev/null; then
    # If hyprctl exists, run the command for Hyprland and pass arguments
    hyprctl dispatch workspace emptynm && neovide "$@"
  else
    # Otherwise, just run neovide with its flag and pass arguments
    neovide --no-multigrid "$@"
  fi
}
alias nv="echo 'Starting Neovim' && neovim"
alias vim="nvim"
alias snv="sudo nvim"
alias clr="clear"
alias jurnal="newhome; cd Documents/personal-diary/; nvim; newhome"
alias runphp="php -S localhost:8000"
alias dcompile="dart compile exe"
alias javall="javac *.java"
alias runjava="java *.java"
alias ref='source ~/.zshrc; clr'
alias xenv='env SDL_VIDEODRIVER=x11'
alias katalon='hyprctl dispatch workspace emptynm && ~/Katalon_Studio_Linux_64-10.2.0/katalon'
# alias gitrem="docs; cd Scripting/; vim; home"

# Configurations Shortcut
alias zshconf="nv ~/.zshrc"
alias bashconf="nv ~/.bashrc"
alias tmuxconf="nv ~/.tmux.conf"
# alias Anvconf="cd ~/.config/nvim/; nv"
# alias Ahyprconf="cd ~/.config/hypr/; nv"
# alias Affconf="cd ~/.config/fastfetch/; nv"
# alias Awaybarconf="cd ~/.config/waybar/; nv"

# Fungsi spesifik (lebih mudah dibaca untuk kasus ini)
nvconf() {
    (cd ~/.config/nvim/ && nv "$@") # Menggunakan subshell ( ) agar direktori kembali setelah selesai
                                    # "$@" meneruskan semua argumen ke nv
}
hyprconf() {
    (cd ~/.config/hypr/ && nv "$@")
}
ffconf() {
    (cd ~/.config/fastfetch/ && nv "$@")
}
waybarconf() {
    (cd ~/.config/waybar/ && nv "$@")
}

# custom Clock commands
alias clock-cs="tty-clock -c -s"
alias clock-c="tty-clock -c"

# wireless Link auto set
alias Linkwlan0="sudo ip link set wlan0 down; sudo ip link set wlan0 up"
alias Linkwlan1="sudo ip link set wlan1 down; sudo ip link set wlan1 up"

# Daily Reminder Haha
# alias rmd="~/Documents/Scripting/Queue.sh; echo Use remind for yourself!"
# alias zenrmd="clear; rmd;"
# alias sche="~/Documents/Scripting/schedule.sh; test"

# hyprland mouse configurations
alias miceon="hyprctl keyword 'device[synps/2-synaptics-touchpad]:enabled' 'true'"
alias miceoff="hyprctl keyword 'device[synps/2-synaptics-touchpad]:enabled' 'false'"

# zsh lsd
# alias ls="lsd"
# alias ll="lsd -l"
# alias la="lsd -la"

# zsh exa
alias ls="exa --icons"
alias ll="exa --icons --long"
alias la="exa --icons --long --all"

# aliases systemd
alias sd='sudo systemctl'
alias sdu='systemctl --user'

# just fun
# alias fuck="sudo"

mpvws() {
    hyprctl dispatch workspace emptynm
    sleep 0.01
    mpv "$@"
}

#  This is your file 
# Add your configurations here

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/readam/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/readam/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/readam/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/readam/anaconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

export EDITOR="nvim"

# For Hadoop
export JAVA_HOME='/usr/lib/jvm/java-24-openjdk'
# export JAVA_HOME='/usr/lib/jvm/java-11-openjdk'
# export JAVA_HOME='/usr/lib/jvm/java-17-openjdk'
# export JAVA_HOME='/usr/lib/jvm/java-21-openjdk'
export PATH=$JAVA_HOME/bin:$PATH
export HADOOP_HOME=~/Hadoop/hadoop-3.3.6/
export PATH=$PATH:$HADOOP_HOME/bin
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
export HADOOP_CLASSPATH=$HADOOP_HOME/bin/hadoop
export PATH="$PATH":"$HOME/.pub-cache/bin"

# For Hive
export HIVE_HOME=~/Hadoop/apache-hive-4.0.1-bin
export PATH=$PATH:$HIVE_HOME/bin

# For Pig
export PIG_HOME=~/pig/
export PATH=$PATH:~/pig/bin/
export PIG_CLASSPATH=$HADOOP_HOME/etc/hadoop/

# export ANDROID_HOME=~/Android
# export ANDROID_SDK_ROOT=$ANDROID_HOME
# export PATH=$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH

# For Android Studio
export ANDROID_HOME=~/Android
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$ANDROID_HOME/Sdk/cmdline-tools/latest/bin:$PATH
export PATH=$ANDROID_HOME/Sdk/platform-tools:$PATH
export PATH=$ANDROID_HOME/Sdk/emulator:$PATH

export CHROME_EXECUTABLE=zen
if [ -f "$HOME/.secrets.zsh" ]; then
    source "$HOME/.secrets.zsh"
fi

# For Apache Spark
export SPARK_HOME=~/spark-3.5.5-bin-hadoop3
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

export PATH="$HOME/flutter/bin:$PATH"

export PATH="$HOME/Development/Progrm/bash:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
