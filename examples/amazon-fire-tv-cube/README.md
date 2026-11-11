# Amazon Fire TV Cube, 3rd gen (Fire OS 7)

Amazon Fire TV Cube 3rd gen, model `AFTGAZL`, codename `gazelle`, Fire OS 7 on Android 9 (SDK 28), build
`PS7717.5746N`. Done over Wi-Fi with `tools/tv.py` in batches with a screenshot after each and a reboot
at the end.

| File | What it is |
|---|---|
| `debloat.txt` | The 20 ads and tracking packages that stayed disabled, grouped and commented |
| `undo.sh` | One-line script to re-enable all packages and put DNS back (Windows only; delete before any PR) |

All commands run from the repo root with the TV's IP in `TV_HOST`.

## What worked and what did not

**Debloat: ads and tracking only.** Amazon ACR (which also reads HDMI input), the metrics, perf and log
uploads, the Wi-Fi password sync, the advertising ID, sponsored banner and row sync, upgrade promotions and
Amazon's promo notices are off. All 20 accepted `pm disable-user` and were still disabled after a reboot.
The stock Home screen loaded after every batch and after the reboot.

**Screensaver: keep Amazon's.** Disabling `com.amazon.ftv.screensaver` and switching to Android's
`com.android.dreams.basic/.Colors` left no working screensaver: in an idle test the colour screensaver never
started, and Settings > Display & Sounds > Screensaver did nothing. It stays enabled. Choose the photos under
Current Screensaver in its own settings.

**Home banner ads: not removable here.** The rotating banner at the top of Home is drawn by
`com.amazon.tv.launcher`, which is protected (it cannot be disabled or force-stopped). It mixes sponsored slides
with show promos from a single feed. Disabling `com.amazon.kso.blackbird` did not remove them, and neither did
Private DNS set to `dns.adguard-dns.com`, even after a reboot: `amazon-adsystem.com` is blocked, but the banner
comes from Amazon's main content servers. `com.amazon.ftvads.deeplinking` is protected as well. The only ways to
get rid of the banner are a different Home screen (SHOWCASE.md) or the off switches in Settings.

**Private DNS (optional, left on):** `settings put global private_dns_specifier dns.adguard-dns.com` then
`settings put global private_dns_mode hostname`. This blocks ad domains inside apps. It does not block YouTube
ads or the Home banner. Undo: `settings put global private_dns_mode opportunistic`.

**Kept on purpose:** the stock launcher and Home screen, Alexa, Prime Video, Shopping, the Appstore, Game Hub,
miniTV, Fire TV Channels, Kids, Silk, casting, firmware updates, Live TV and the input stack.

## Undo

**Recommended (uses the recovery records and restores Home):**
```bash
TV_HOST=<tv ip> tools/restore.sh examples/amazon-fire-tv-cube/debloat.txt com.amazon.tv.launcher
tools/tv.py settings delete global private_dns_mode
tools/tv.py settings delete global private_dns_specifier
```

**Quick one-line (Windows only, does all of the above apart from the recovery-record check):**
```bash
bash examples/amazon-fire-tv-cube/undo.sh
```
Set `TV_HOST` if your TV's IP is not 192.168.0.5. This script is for local use only; delete it before opening a pull request with this folder.
