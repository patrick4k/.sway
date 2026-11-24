# Sway config

All application configs (`fuzzel`, `waybar`, `mako`, `swaylock`) live in this repository and are loaded via config-path flags from `config` and `scripts/`.

## Dependencies

### Ubuntu (`apt`)

```bash
sudo apt install \
  sway fuzzel kanshi waybar \
  mako-notifier libnotify-bin \
  swaylock swayidle \
  grim slurp wl-clipboard cliphist \
  network-manager network-manager-gnome \
  bluez power-profiles-daemon \
  pulseaudio-utils pavucontrol playerctl brightnessctl \
  polkit-kde-agent-1 xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
  fonts-jetbrains-mono fonts-font-awesome \
  jq perl
```

Also requires `ghostty` (`$term`).

### Arch Linux (`pacman`)

```bash
sudo pacman -S --needed \
  sway ghostty fuzzel kanshi waybar \
  mako libnotify \
  swaylock swayidle \
  grim slurp wl-clipboard cliphist \
  networkmanager nm-connection-editor \
  bluez bluez-utils power-profiles-daemon \
  pipewire-pulse libpulse pavucontrol playerctl brightnessctl \
  polkit-kde-agent xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
  ttf-jetbrains-mono ttf-font-awesome \
  jq perl
```

On a fresh Arch install, ensure the system services are enabled:

```bash
sudo systemctl enable --now NetworkManager bluetooth power-profiles-daemon
```

## Keybindings (Desktop)

- `$mod+X` — App launcher (`fuzzel`)
- `$mod+Shift+s` — Settings hub (Wi-Fi, Bluetooth, Audio, Power Profile, Clipboard, Screenshot, Power)
- `$mod+c` — Clipboard history (`cliphist` + `fuzzel`)
- `$mod+Shift+p` — Power / Session menu (Lock, Suspend, Power Profile, Logout, Reboot, Shutdown)
- `Print` / `Shift+Print` — Region / Full-screen screenshot (saved to `~/Pictures/Screenshots/` & copied to clipboard)
