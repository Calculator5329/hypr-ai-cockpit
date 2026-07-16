# Optional finance bar module

The public cockpit ships with finance disabled. No balances, holdings, account
identifiers, provider tokens, or finance scripts are included. Enable it only
after you decide what data you are comfortable showing in the top bar.

## Choose a data source

Start with the least sensitive option that answers your question:

1. **Manual or delayed data:** a local CSV/JSON file you update yourself.
2. **Public prices:** a script that fetches public symbols with no account
   connection.
3. **Account-aware data:** a provider integration using a read-only credential
   you create and can revoke.

Do not use trading-enabled credentials for a display widget. A bar module
should report information, not place orders.

## Keep data and keys outside this repository

Create a private directory for the script's configuration and restrict it to
your user account:

```sh
mkdir -p "$HOME/.config/cockpit-finance"
chmod 700 "$HOME/.config/cockpit-finance"
touch "$HOME/.config/cockpit-finance/finance.env"
chmod 600 "$HOME/.config/cockpit-finance/finance.env"
```

Store provider credentials only in that private file, your operating system's
keyring, or the provider's supported credential store. Never put a real value
in a Waybar JSON file, shell history, a screenshot, Git commit, issue, or
support request. Add any private data files to your personal global Git ignore
file if the containing directory is ever inside a Git checkout.

## Provide a small, safe Waybar contract

Write a local script that prints one JSON object for Waybar. Keep the output
informational and avoid full account values where a change or status is
sufficient.

```json
{"text":"Market: updated","tooltip":"Last refresh: just now","class":"flat"}
```

The usual classes are `up`, `down`, `flat`, and `stale`. Test the script
directly before wiring it into the bar:

```sh
"$HOME/.local/bin/cockpit-finance" --field summary
```

It should always produce valid JSON quickly. On an API failure, return a
neutral `stale` result instead of exposing an error that includes a URL,
account number, token, or raw provider response.

## Enable the module in Waybar

In your local Waybar configuration, add the custom module to `modules-left`
only after the script works. The exact name is your choice; this example uses
`custom/finance`:

```json
"modules-left": ["custom/finance"],
"custom/finance": {
  "return-type": "json",
  "interval": 600,
  "exec": "~/.local/bin/cockpit-finance --field summary"
}
```

Restart or reload Waybar after editing. Use a conservative refresh interval;
rate limits and accidental repeated API calls are easy to overlook in a bar.

If you enable the optional privacy helper, reserve `Super+Shift+P` for a mode
that replaces all finance text with obvious sample or hidden values during a
screen share. `Super+M` may be assigned to a fuller market view only if you
build and secure one yourself. Both chords are optional and are unbound in the
default public setup.

## Before sharing your desktop

- Turn on the privacy mode or disable the module.
- Check tooltips as well as the visible bar text.
- Remove old screenshots and recordings that show real values.
- Revoke a provider credential immediately if it appears anywhere public.

This module is a convenience display, not financial advice or a replacement
for the provider's own account controls.
