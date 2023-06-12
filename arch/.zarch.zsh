wifi_on() {
  sudo wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant.conf
  # sudo dhcpcd wlp2s0
}

if [[ "$(tty)" = "/dev/tty1" ]]; then
  wifi_on && \
  pgrep -x dwm > /dev/null || startx
fi

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
