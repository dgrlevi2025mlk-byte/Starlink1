#!/bin/bash

# Network Tunneling Manager Script
# လုံခြုံရေး သုတေသန ပြုလုပ်ရန်အတွက်သာ

show_menu() {
    echo "====================================="
    echo "   Termux Network Tunnel Manager"
    echo "====================================="
    echo "1) Start SSH Dynamic Tunnel (SOCKS5)"
    echo "2) Check Active Connections"
    echo "3) Stop All Tunnels"
    echo "4) Exit"
    echo "====================================="
}

start_ssh() {
    read -p "[?] Enter Remote VPS IP: " VPS_IP
    read -p "[?] Enter SSH User (e.g., root): " SSH_USER
    read -p "[?] Enter Local Port to Bind (e.g., 1080): " L_PORT

    echo "[+] Starting SSH Tunnel on port $L_PORT..."
    # Background တွင် Run စေခြင်း
    ssh -D $L_PORT -N -f $SSH_USER@$VPS_IP
    
    if [ $? -eq 0 ]; then
        echo "[✔] Tunnel started successfully in background."
    else
        echo "[✘] Failed to connect. Check your SSH credentials."
    fi
}

check_status() {
    echo "[*] Active network listeners on Local ports:"
    ss -tlnp | grep -E "127.0.0.1|::1"
}

stop_tunnels() {
    echo "[-] Stopping all background ssh tunnel processes..."
    pkill -f "ssh -D"
    echo "[✔] All managed tunnels stopped."
}

while true; do
    show_menu
    read -p "[?] Choose an option [1-4]: " choice
    case $choice in
        1) start_ssh ;;
        2) check_status ;;
        3) stop_tunnels ;;
        4) echo "Goodbye!"; exit 0 ;;
        *) echo "[!] Invalid option. Try again." ;;
    esac
    echo ""
done
