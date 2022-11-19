pfetch
echo "S5230837"
python /srv/todo.py
python /srv/reminder/reminder.py
echo "🔋: $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "[[:digit:]]\{2\}"% | head -n 1  | awk '{print $2 "\t"}')"
echo " " 

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/apri/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE='nerdfont-complete'

plugins=(git zsh-syntax-highlighting z dirhistory web-search colorize copyfile)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias bashelp="firefox /srv/bash_cheatsheet.html && echo 'Check your browser'"
alias j="joplin"
alias toyaga="sudo openvpn --config /srv/toyaga.ovpn"
alias battery="upower -i /org/freedesktop/UPower/devices/battery_BAT0"
export EDITOR="nvim"
alias batt="battery | grep percentage"
alias bands="/srv/bands.sh"
alias todo="python /srv/todo.py -t"
alias prepefi="sudo mount /dev/nvme0n1p1 /boot/ && echo 'Mounted!'"
alias less="cless"
alias cat="ccat"
alias wormhole="python -m wormhole"
alias monitor="xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1 --rate 144"
