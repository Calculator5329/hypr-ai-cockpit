# AI desktop tools and remote access

This cockpit does not bundle proprietary applications. Install each tool from
its publisher, sign in through its own window, and let it update through the
same channel. The availability notes below were checked in July 2026.

## Claude Desktop

Anthropic's official Claude Desktop downloads currently target macOS and
Windows, not Linux. On Arch/CachyOS, use Claude in a browser or wait for an
official Linux release; do not treat an unverified community wrapper as an
official desktop build.

1. Visit [Claude's official desktop-install page](https://support.anthropic.com/en/articles/10065433-installing-claude-for-desktop) to confirm current platform support.
2. For the browser workflow, sign in at [Claude](https://claude.ai/) and keep
   the site pinned as a browser app if desired.
3. When an official Linux download appears, download it only from Anthropic,
   verify the publisher's integrity instructions, install it, then sign in
   from the application.

`Super+C` is reserved for Claude Desktop. Bind it only after the installed
application has a stable launch command.

## Codex Desktop

OpenAI's Codex desktop app is currently available for macOS and Windows; the
official Linux availability page offers notification sign-up rather than a
Linux installer. Do not use a third-party desktop package under the name
"Codex Desktop" on this cockpit.

For a supported Arch/CachyOS alternative today, install the official Codex
CLI package, then authenticate interactively:

```sh
npm install -g @openai/codex
codex
```

Alternatively, register for the official Linux release notification through
the [Codex Linux availability form](https://openai.com/da-DK/form/codex-app/).
When the Linux app is released, obtain it from the [official Codex getting
started page](https://openai.com/codex/get-started/) and sign in with the
account that has Codex access.

## Cursor

Cursor publishes Linux builds directly. Use the current x64 or ARM64 AppImage
from the [official Cursor download page](https://cursor.com/download), not a
copy hosted elsewhere.

1. Download the AppImage that matches `uname -m`.
2. Make the downloaded file executable and place it in a user-controlled
   applications directory.

   ```sh
   mkdir -p "$HOME/Applications"
   chmod +x /path/to/Cursor.AppImage
   mv /path/to/Cursor.AppImage "$HOME/Applications/Cursor.AppImage"
   ```

3. Start it once from that location and complete Cursor's own sign-in flow.
4. Choose **Open Folder** and select a project directory. Review workspace
   trust and privacy settings before allowing an agent to run commands.

The publisher also provides native Linux packages where available on that
same download page. If you prefer the AUR, inspect the PKGBUILD and verify it
retrieves the publisher's artifact before building; AUR maintainers are not
the software publisher.

## Reach the cockpit from another machine

Remote desktop exposes your live session. Prefer a private network or VPN,
use a strong unique credential, and never forward a remote-desktop port from
your router to the public internet.

### Option A: Sunshine host + Moonlight client

Sunshine is a full remote-desktop host; Moonlight is the client on the other
machine.

1. Install Sunshine from the Arch repositories or a reviewed AUR package, and
   install Moonlight on the client device from its official distribution.
2. Start Sunshine in the graphical user session. Its setup page generates a
   pairing PIN when a new Moonlight client connects.
3. In Moonlight, add the cockpit by its private-network address, enter the
   pairing PIN, and start a desktop session.
4. Restrict access to your local network or VPN. Remove old paired clients
   from Sunshine when a device is no longer trusted.

### Option B: WayVNC for a lightweight Hyprland session

WayVNC shares a Wayland session and is useful on a trusted LAN or VPN.

1. Install `wayvnc` from the Arch repositories.
2. Launch it from inside the logged-in Hyprland session, with authentication
   and encryption enabled according to the versioned `wayvnc --help` output.
3. Connect from a VNC client over the same private network or VPN.
4. Stop the service when it is not needed.

Do not run an unauthenticated WayVNC server or expose it directly to the
internet. Remote access carries the same authority as sitting at the cockpit.
