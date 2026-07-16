# Devices that reconnect at login

This walkthrough makes the common desktop hardware feel persistent: trusted
Bluetooth audio reconnects, PipeWire selects the intended output, displays
return to their arrangement, and a phone can be paired without tying the
configuration to a particular model or network.

## 1. Install the plumbing

On Arch or CachyOS, install the components you plan to use:

```sh
sudo pacman -S bluez bluez-utils pipewire wireplumber kdeconnect
```

Enable Bluetooth once, then reboot or start it immediately:

```sh
sudo systemctl enable --now bluetooth.service
```

PipeWire and WirePlumber are normally started with the graphical session. If
audio does not appear after logging in, check their user services before
changing any device settings:

```sh
systemctl --user status pipewire wireplumber
```

## 2. Pair and trust Bluetooth audio

Pairing is a one-time operation; trusting the device lets BlueZ reconnect it
after a logout, reboot, or short radio interruption.

```text
bluetoothctl
power on
agent on
default-agent
scan on
# Select the address displayed for your headset, then:
pair AA:BB:CC:DD:EE:FF
trust AA:BB:CC:DD:EE:FF
connect AA:BB:CC:DD:EE:FF
quit
```

Use the address shown on *your* machine; do not copy the example address.
Confirm the profile and output appear with `wpctl status`.

For Bluetooth adapters that are sometimes powered off at boot, set the
following in `/etc/bluetooth/main.conf` and restart Bluetooth. On recent
BlueZ versions, the reconnect lines make BlueZ retry trusted devices that
advertise reconnect support; leave them out if your installed `main.conf`
does not document them.

```ini
[Policy]
AutoEnable=true
ReconnectAttempts=7
ReconnectIntervals=1,2,4,8,16,32,64
```

Some headsets reconnect only after their case is opened or a button is
pressed. That is a device-side behavior, not a Hyprland failure. Remove an
old pairing with `bluetoothctl remove <address>` and pair again if the device
is trusted but repeatedly refuses to connect.

## 3. Keep the preferred audio output

WirePlumber remembers the default PipeWire node. After the headset, speakers,
or dock is connected, inspect the numbered outputs:

```sh
wpctl status
```

Set the chosen sink as the default using its current numeric ID:

```sh
wpctl set-default <sink-id>
```

Test it with `wpctl get-volume @DEFAULT_AUDIO_SINK@`. The cockpit volume keys
operate on that default sink. If an application keeps an old output open,
restart that application; do not hard-code a transient PipeWire ID in a
Hyprland bind.

For a setup that needs a fixed policy (for example, prefer a USB dock whenever
it is present), use a WirePlumber rule matching a stable device property.
Start from the current WirePlumber configuration documentation for your
installed version, and match only identifiers from your own `wpctl status`.

## 4. Restore monitors with Hyprland rules

First identify the output names, available modes, and physical layout:

```sh
hyprctl monitors all
```

Then add rules to your Hyprland monitor configuration. This generic example
puts a high-refresh DisplayPort panel on the left and an HDMI panel on its
right; replace every output name, mode, position, and scale with your own.

```ini
monitor = DP-1,2560x1440@144,0x0,1
monitor = HDMI-A-1,1920x1080@60,2560x0,1
monitor = ,preferred,auto,1

workspace = 1,monitor:DP-1,default:true
workspace = 2,monitor:DP-1
workspace = 6,monitor:HDMI-A-1,default:true
```

The final fallback rule handles an unfamiliar or newly connected display.
Reload after editing:

```sh
hyprctl reload
```

Display connectors are machine-specific. Never paste someone else's output
names into your config; a rule for a nonexistent connector is ignored.

## 5. Pair a phone with KDE Connect

1. Install KDE Connect on the phone from its normal app store and open it on
   both devices.
2. Put the phone and cockpit on the same local network.
3. Open the desktop app (or run `kdeconnect-cli --list-available`) so its
   D-Bus-activated daemon can discover nearby devices.
4. In the desktop app or phone app, send a pairing request and approve the
   matching request on the other device.
5. Grant only the phone permissions you want to use (notifications, files,
   clipboard, or remote input).

If discovery fails, first confirm both devices are on the same network and
that local firewall rules permit KDE Connect. Pairing does not require
publishing the cockpit to the internet.

## Login checklist

- Bluetooth service is enabled and the audio device is trusted.
- `wpctl status` shows the expected default sink after reconnecting it.
- `hyprctl monitors all` matches the connector names used by monitor rules.
- KDE Connect is paired over a local network and only necessary permissions
  are granted.
