# Home Server Setup

## Installation
```bash
brew tap pavele/home-server
brew install home-server          
home-server-setup                 # or: home-server-setup mybox.lan 10.0.0.50:8123
```

**Default values when omitted:**

domain: Automatically uses your computer's hostname with .home.arpa suffix (e.g., macbook.home.arpa if your hostname is "macbook")
home-assistant-ip:port: Defaults to 192.168.1.196:8123

## Service Management
### Restarting Services


**After initial setup or configuration changes:**
```bash
brew services restart nginx
```

**Quick config reload (without downtime):**
```bash
nginx -s reload -c ~/home-server/nginx/nginx.conf
```

### Verifying Setup
**Check nginx status:**
```bash
brew services info nginx
```

**View access logs:**
```bash
tail -f ~/home-server/nginx/logs/access.log
```

## Technical Details
### Network Architecture

```
                       ┌────────────────┐
                       │                │
    Browser ──────────►│  Nginx Reverse │◄─────────┐
                       │    Proxy       │          │
                       │                │          │
                       └───────┬────────┘          │
                               │                   │
           ┌───────────────────┼───────────────────┐
           │                   │                   │
           ▼                   ▼                   ▼
┌───────────────────┐ ┌────────────────────┐ ┌───────────────────┐
│ UniFi Controller  │ │ Plex Media Server  │ │ Home Assistant    │
│ (localhost:8443)  │ │ (localhost:32400)  │ │ ({{HA_BACKEND}})  │
└───────────────────┘ └────────────────────┘ └───────────────────┘
```

### Why .home.arpa?
- Standard Compliance: .home.arpa is an IANA-reserved domain for home networks (RFC 8375)
- No DNS Conflicts: Guaranteed to never conflict with public domains
- Automatic Resolution: Works without manual DNS configuration on most routers
### Security Model
No HTTPS Configuration By Design:

1. Local network traffic doesn't typically require encryption
2. Certificate management would add significant complexity
3. Most browsers allow mixed content on .home.arpa domains
### Risk Mitigation:

- Use VPN for remote access instead of port forwarding
- Enable individual service encryption where sensitive data exists
- Segment your network (IoT devices on separate VLAN)

### Supported Services
| Service             | URL Pattern               | Backend Port | Notes                          |
|---------------------|---------------------------|--------------|--------------------------------|
| Dashboard           | http://{{DOMAIN}}         | -            | Shows all available services   |
| UniFi Controller    | http://unifi.{{DOMAIN}}   | 8443         | Requires UniFi OS              |
| Plex Media Server   | http://pms.{{DOMAIN}}     | 32400        | Auto-discovered                |
| Home Assistant      | http://ha.{{DOMAIN}}      | 8123         | Configurable IP/port           |
| qBittorrent         | http://qbittorrent.{{DOMAIN}} | 8081      | Web UI access only             |

### Troubleshooting

#### Verify nginx configuration:
```console
nginx -t -c ~/home-server/nginx/nginx.conf
```

#### Reset all configurations:
```console
rm -rf ~/home-server && home-server-setup
```