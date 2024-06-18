#!/usr/bin/bash
if [[ $1 == toggle ]]; then
	if [[ $2 == mpv ]]; then
		echo '{ "command": ["cycle", "mute"] }' | socat - /tmp/mpvsocket;
	else
		source_sink="@DEFAULT_$2@";
		pactl set-$3-mute ${source_sink} toggle;
	fi
fi

if [[ $1 == mpv ]]; then
	if [[ $2 != volume ]]; then
		if [ -e "/tmp/mpvsocket" ]; then
			echo '{ "command": ["cycle", "mute"] }' | socat - /tmp/mpvsocket;
		fi
	else
		if [[ $3 == 1 ]]; then
			echo '{ "command": ["add", "volume", 1] }' | socat - /tmp/mpvsocket;
		else
			echo '{ "command": ["add", "volume", -1] }' | socat - /tmp/mpvsocket;
		fi
	fi
fi

if [[ $1 == volume ]]; then
	pactl set-$2-volume @DEFAULT_$3@ $41%;
	echo "#24" `#24 pactl get-source-volume @DEFAULT_SOURCE@ | grep "Volume" | cut -d"/" -f2 | polybar screen0`;
fi

if [[ $1 == sink ]]; then
	if [[ $2 == speakers ]]; then
		sink=$(pactl list sinks | grep -i "name:" | grep -i "media_electronics" | cut -d" " -f2);
		#port="analog-output-lineout";
	elif [[ $2 == headset ]]; then
		sink=$(pactl list sinks | grep -i "name:" | grep -i "behringer" | cut -d" " -f2);
#		port="analog-output-headphones";
	else
		bluetooth=$(pactl list sinks | grep "Name: bluez_*")
		sink=$(cut -d':' -f2 <<< ${bluetooth});
	fi
	
        pactl set-default-sink $sink;

	[ ! -z $port ] && pactl set-sink-port $sink $port
	#xmonad --restart;
#	pkill -USR1 polybar
fi

if [[ $1 == source ]]; then
	if [[ $2 == headset ]]; then
		source="alsa_input.usb-Logitech_PRO_X_000000000000-00.mono-fallback";
	elif [[ $2 == record ]]; then
		source="alsa_input.usb-OmniVision_Technologies__Inc._USB_Camera-B4.09.24.1-01.3.analog-surround-40";
	fi

	
	pactl set-default-source $source;
	#xmonad --restart;
#	pkill -USR1 polybar
fi
