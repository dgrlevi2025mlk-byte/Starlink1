import os
import socket
import time

# စမ်းသပ်မည့် Public DNS နှင့် Website များ စာရင်း
TARGETS = {
    "Google DNS": "8.8.8.8",
    "Cloudflare DNS": "1.1.1.1",
    "GitHub": "github.com",
    "Wikipedia": "wikipedia.org"
}

def check_ping(host):
    """ Server ဆီသို့ Network Latency (Ping) စမ်းသပ်ခြင်း """
    # Platform အလိုက် ping parameter ပြောင်းလဲခြင်း
    param = "-c 1" if os.name != "nt" else "-n 1"
    start_time = time.time()
    
    response = os.system(f"ping {param} -W 2 {host} > /dev/null 2>&1")
    end_time = time.time()
    
    if response == 0:
        latency = round((end_time - start_time) * 1000, 2)
        return f"ချိတ်ဆက်မှု အောင်မြင်သည် (Latency: {latency} ms)"
    else:
        return "ချိတ်ဆက်မှု မအောင်မြင်ပါ (Blocked သို့မဟုတ် Timeout)"

def check_dns_resolve(hostname):
    """ DNS Resolution အလုပ်လုပ်ပုံကို စစ်ဆေးခြင်း """
    try:
        ip = socket.gethostbyname(hostname)
        return f"အောင်မြင်သည် (Resolved IP: {ip})"
    except socket.gaierror:
        return "မအောင်မြင်ပါ (DNS Filtering သို့မဟုတ် ကွန်ရက်ပြတ်တောက်နေသည်)"

def main():
    print("==================================================")
    print("      Network Latency & Connectivity Analyzer     ")
    print("==================================================")
    
    print("\n[၁] ICMP Ping Test စမ်းသပ်ခြင်း:")
    for name, host in TARGETS.items():
        print(f" -> {name} ({host}): {check_ping(host)}")
        
    print("\n[၂] DNS Resolution (Domain အလုပ်လုပ်ပုံ) စစ်ဆေးခြင်း:")
    domains = ["github.com", "google.com", "cloudflare.com"]
    for domain in domains:
        print(f" -> {domain}: {check_dns_resolve(domain)}")

    print("\n==================================================")

if __name__ == "__main__":
    main()
