#!/bin/bash

# Termux standard network tunneling utility installation script
echo "[+] Updating Termux package repository..."
pkg update -y && pkg upgrade -y

echo "[+] Installing core networking dependencies..."
pkg install openssh proxychains-ng tor -y

echo "[+] Creating configuration directory..."
mkdir -p $HOME/.network_test

# အခြေခံ SSH Tunneling configuration template ထုတ်ပေးခြင်း
cat <<EOF > $HOME/.network_test/tunnel_config.conf
# SSH Tunnel Configuration Template
# ဤနေရာတွင် သင်၏ တရားဝင် VPS server IP နှင့် local port များကို သတ်မှတ်ပါ
LOCAL_PORT=1080
REMOTE_HOST="your_vps_ip"
REMOTE_USER="root"
EOF

echo "[+] Installation complete."
echo "[*] သီအိုရီအရ စမ်းသပ်ရန်အတွက် ssh -D \$LOCAL_PORT -N -f \$REMOTE_USER@\$REMOTE_HOST ကို သုံးနိုင်ပါသည်။"
