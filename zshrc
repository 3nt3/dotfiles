
# I you come from bash you might have to change your $PATH.
#
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ente/.oh-my-zsh"

bindkey -v
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="afowler"
# PROMPT="$ "

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
    fzf
    command-not-found
    colored-man-pages
    zsh-syntax-highlighting
    flutter
    jump
    npm
    systemd
    docker
    docker-compose
    zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

export EDITOR='nvim'
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
export PATH=~/.local/share/npm-global/bin:~/.local/bin:~/.emacs.d/bin:~/.ghcup/bin:~/Android/Sdk/tools/bin:~/Android/Sdk/build-tools:~/.pub-cache/bin:$PATH

export ANDROID_HOME=/home/ente/Android/Sdk

alias ls='exa'

alias gs='git status'
alias pamcan='pacman'
alias pancam='pacman'
alias pacnam='pacman'
alias tp='trash-put'
alias th='( kitty &; disown ) > /dev/null 2>&1'

zmodload zsh/complist

# use the module above for autocomplete selection
zstyle ':completion:*' menu yes select

# now we can define keybindings for complist module
# you want to trigger search on autocomplete items
# so we'll bind some key to trigger history-incremental-search-forward function
bindkey -M menuselect '?' history-incremental-search-forward

math() {
    python -c "from math import *; print(eval('$1'))"
}

# tex live
export TEXMFLOCAL="/usr/locoal/share/texmf:/usr/share/texmf"
export TEXMFHOME="~/texmf"

playlistname() {
    cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

export SPICETIFY_INSTALL="/home/ente/spicetify-cli"
export PATH="$SPICETIFY_INSTALL:$PATH"

export PYTHON_KEYRING_BACKEND=keyring.backends.null.Keyring

ttd() {
    subject="$(ls $HOME/Documents/schule/Q | dmenu -l 10)"
    dir="$HOME/Documents/schule/Q/$subject/`date +'%Y-%m-%d'`"
    mkdir -p "$dir" && cd "$dir"
    pwd
    cp -n ../../template.tex unterricht.tex

    author_line="Fach Lehrer"
    case $subject in
        geschichte)
            author_line="Geschichte-GK Butz"
            ;;

        englisch)
            author_line="Englisch-LK Butz"
            ;;

        physik)
            author_line="Physik-LK Fluchti"
            ;;

        sowi)
            author_line="Sozialwissenschaften-GK Noack"
            ;;

        deutsch)
            author_line="Deutsch-GK Lex"
            ;;

        mathe)
            author_line="Mathematik-GK Gabelin"
            ;;

        philosophie)
            author_line="Philosophie-GK Ligus"
            ;;

        kunst)
            author_line="Kunst-GK Henne"
            ;;
    esac

    sed -i "s/Fach Lehrer/$author_line/" unterricht.tex
}

alias fastreboot="sudo kexec -l /boot/vmlinuz-linux --initrd=/boot/initramfs-linux.img --reuse-cmdline && sudo kexec -e"

subs() {
    if [[ "$1" == "-t" ]]; then
        thunar ~/Documents/schule//$( ls ~/Documents/schule/Q |dmenu -l 10)
    else
        cd ~/Documents/schule//$( ls ~/Documents/schule/Q |dmenu -l 10)
    fi
}

alias td="todo"
alias thu="thunar . &; disown"
alias python="python3"

ix() {
    local opts
    local OPTIND
    [ -f "$HOME/.netrc" ] && opts='-n'
    while getopts ":hd:i:n:" x; do
        case $x in
            h) echo "ix [-d ID] [-i ID] [-n N] [opts]"; return;;
            d) $echo curl $opts -X DELETE ix.io/$OPTARG; return;;
            i) opts="$opts -X PUT"; local id="$OPTARG";;
            n) opts="$opts -F read:1=$OPTARG";;
        esac
    done
    shift $(($OPTIND - 1))
    [ -t 0 ] && {
        local filename="$1"
        shift
        [ "$filename" ] && {
            curl $opts -F f:1=@"$filename" $* ix.io/$id
            return
        }
        echo "^C to cancel, ^D to send."
    }
    curl $opts -F f:1='<-' $* ix.io/$id
}

autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (Eterm*|alacritty*|aterm*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

export GPG_TTY=$(tty)

alias pwlo-on='pw-link "alsa_input.usb-Thomann_SC450USB-00.analog-stereo:capture_FL" "alsa_output.pci-0000_0a_00.4.analog-stereo:playback_FR; pw-link "alsa_input.usb-Thomann_SC450USB-00.analog-stereo:capture_FL" "alsa_output.pci-0000_0a_00.4.analog-stereo:playback_FL'

function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=(
        ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"}
    )
    if (( ${#entries[@]} ))
    then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}"
        do
            # (repo package version file)
            local fields=(
                ${(0)entry}
            )
            if [[ "$pkg" != "${fields[2]}" ]]
            then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
}

chpwd() l

export XDG_CURRENT_DESKTOP=sway

eval $(thefuck --alias)

alias v='nvim'
source /usr/share/nvm/init-nvm.sh

alias get_idf="source ~/esp/esp-idf/export.sh"

export FZF_DEFAULT_COMMAND="fd . $HOME --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME --hidden"

alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias sudo='sudo '

alias spt='spotify_player'
