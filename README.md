# Homebrew tap for auto-wallpaper

This repository contains the Homebrew formula for [auto-wallpaper](https://github.com/tomaskub/auto-wallpaper), a macOS command-line tool that switches wallpapers when the system appearance changes.

## Requirements

- Apple Silicon Mac
- macOS 15 or later
- [Homebrew](https://brew.sh/)

The formula builds from the tagged source archive and the dependency versions locked in the upstream `Package.resolved` file.

## Installation

Add the tap and trust the formula:

```bash
brew tap tomaskub/tap
brew trust --formula tomaskub/tap/auto-wallpaper
```

Install `auto-wallpaper`:

```bash
brew install tomaskub/tap/auto-wallpaper
```

## Configuration

Configure the light and dark wallpapers:

```bash
auto-wallpaper configure \
  --light "$HOME/Pictures/light.jpg" \
  --dark "$HOME/Pictures/dark.jpg"
```

Check the current configuration:

```bash
auto-wallpaper status
```

The configuration is stored at:

```text
~/.config/auto-wallpaper/config
```

## Background service

Start the wallpaper watcher:

```bash
brew services start auto-wallpaper
```

Inspect or restart the service:

```bash
brew services list
brew services restart auto-wallpaper
```

Stop the service:

```bash
brew services stop auto-wallpaper
```

Run the watcher directly for troubleshooting:

```bash
auto-wallpaper watch
```

Service logs are available at:

```bash
tail -f "$(brew --prefix)/var/log/auto-wallpaper.log"
```

## Updating

```bash
brew update
brew upgrade auto-wallpaper
brew services restart auto-wallpaper
```

## Publishing a release

1. Merge and test the upstream release commit on `main`.
2. Create and push the upstream version tag.
3. Download the tagged archive and calculate its SHA-256 checksum.
4. Update the formula URL and checksum. Confirm that its macOS floor still matches Homebrew's current Tier 1 matrix.
5. Run `brew style`, `brew audit --new --formula`, a clean-cache source fetch, a network-isolated source install, and `brew test`.
6. Test `brew services` start, list, restart, and stop without `sudo`.

## Uninstalling

```bash
brew services stop auto-wallpaper
brew uninstall auto-wallpaper
brew untap tomaskub/tap
```

Uninstalling the formula does not remove the configuration file or wallpaper images. Delete `~/.config/auto-wallpaper` manually if you no longer need the saved configuration.

## Issues

Report application bugs in the
[auto-wallpaper repository](https://github.com/tomaskub/auto-wallpaper/issues).

Report installation or formula problems in the
[homebrew-tap repository](https://github.com/tomaskub/homebrew-tap/issues).

## License

`auto-wallpaper` is licensed under GPL-3.0-or-later.
