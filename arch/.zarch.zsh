# automate this
wifi_on() {
    sudo wpa_supplicant -B -i wlp2s0 -c /etc/wpa_supplicant/wpa_supplicant.conf;
    sleep 10;
    sudo dhcpcd wlp2s0;
}

if [[ "$(tty)" = "/dev/tty1" ]]; then
  pgrep dwm  || startx
fi
