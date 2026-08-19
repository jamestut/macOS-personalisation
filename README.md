# macOS Personalisation

A collection of scripts to automate macOS system and user preference customisation on a fresh installation.

## Quick Start

Run on a fresh macOS installation:

```sh
./first-setup.sh
```

`first-setup.sh` runs `personalise.sh` and `reset-dock.sh` as the current user, then `system-wide-personalise.sh` with sudo. Log off afterwards for all changes to take effect.

## Scripts

| Script | Role |
| --- | --- |
| `personalise.sh` | User-level preference customisation |
| `reset-dock.sh` | Clears all Dock items |
| `system-wide-personalise.sh` | System-level preference customisation (requires root) |
| `sudo/sudotouchid.py` | Enables Touch ID for sudo |
| `sudo/disablesudopasswd.py` | Disables sudo password requirement |

Read the scripts themselves for details on what each one does.

## Files

- **`prefs/`** — preference plasts imported via `defaults import`
- **`payloads/`** — plists deployed to system locations (e.g. LaunchDaemons)
- **`sudo/`** — helper scripts for sudo configuration

## Recommended Apps

It is recommended to install all of these apps, as the preference bundles in `prefs/` are configured for them and may disable default macOS functionalities in their place.

- [InstantSpaceSwitcher](https://github.com/jurplel/InstantSpaceSwitcher) — Space switching without animations and without disabling SIP (`com.interversehq.InstantSpaceSwitcher.plist`)

## Post-Install Notes

- Log off and back in for all changes to take effect.
- Text replacement entries under **Settings → Keyboard → Text Input → Edit** are cleared programmatically but default entries may need to be removed manually.
