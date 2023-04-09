if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi


if [ -e /home/ente/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ente/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.cargo/env"

export REALDEBRID_USERNAME="3nt3"
export REALDEBRID_PASSWORD="3F4HYgegvZC~9vMyUkrzc%~4XHW@TYHY"

export TERMINAL="/usr/bin/kitty"

export PATH="/home/ente/src/other/flutter/bin:$PATH"
