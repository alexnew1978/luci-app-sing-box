# luci-app-sing-box

LuCI web interface for [sing-box](https://sing-box.sagernet.org/) - The universal proxy platform.

## Features
- Basic configuration management
- Service status monitoring
- JSON configuration editor

## Installation
1. Download the IPK file from the latest release
2. Upload it to your OpenWrt device
3. Install using `opkg install luci-app-sing-box_*.ipk`
4. Configure through LuCI web interface: Services -> sing-box

## Building from source
```bash
# Add this repository to your OpenWrt SDK
git clone https://github.com/srk24/luci-app-sing-box.git package/luci-app-sing-box

# Build the package
make package/luci-app-sing-box/compile V=s
```

## License
This project is licensed under MIT license.