numlockx on

export HARDWARE_MONITOR_NAME="DisplayPort-0"
export MONITOR_1="Virtual-1"
export MONITOR_2="Virtual-2"
export MONITOR_1_WIDTH=""
export MONITOR_1_HEIGHT=""
export MONITOR_2_WIDTH=""
export MONITOR_2_HEIGHT=""
export KEEPASS_DATABASE=~/Documents/Confidential/vault.kdbx


session=${1:-xmonad}


case $session in
	sway    ) exec sway;;
	xmonad	) exec xmonad 2> .xsession-errors;;
	xfce    ) exec startxfce4;;
	dwm		) exec dwm;;
	qtile   ) exec qtile;;
	i3      ) exec i3;;
	*		) exec $1 2> .xsession-errors;;
esac
