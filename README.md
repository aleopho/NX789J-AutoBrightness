# NX789J Auto Brightness

Magisk module that enables automatic screen brightness on the **RedMagic 10 Pro (NX789J)** running an **Android 16 GSI** with the original Nubia vendor partition.

## Status

Confirmed working by one user on Infinity-X 3.12 (Android 16), Nubia Android 15 vendor, Magisk 31. Other ROMs, firmware versions and devices have not been tested.

## What it does

Installs a static resource overlay targeting Android framework resources to enable automatic brightness and provide a basic ambient-light (lux) to screen-brightness (nits) mapping. It does not replace the vendor panel display configuration or modify the boot partition.

## Installation

1. Keep a backup and ensure you have a way to disable Magisk modules if Android fails to boot.
2. Install the ZIP from **Releases** in Magisk > Modules > Install from storage.
3. Reboot and test automatic brightness under changing ambient lighting.

**If updating from the original preview ZIP:** The internal Magisk module ID intentionally remains `nx789j_autobrightness_test` so the release replaces the previously installed module instead of creating a duplicate. The displayed module name is now release-ready.

## Removal

Disable or uninstall the module in Magisk and reboot. If the system cannot boot but ADB root access is available, remove `/data/adb/modules/nx789j_autobrightness_test` and reboot. Do not rely on ADB being available during a bootloop.

## Build on Windows

Requirements: Android SDK Build-Tools 36.0.0, Android SDK Platform 36, and Java `keytool` (bundled with Android Studio JBR). Run `build.cmd` from a Command Prompt. The script creates a signed overlay APK and a Magisk-installable ZIP.

The included release ZIP contains the exact overlay APK that was reported working. The APK is signed with a development key; it is not a production signing identity. If you rebuild, your APK signature may differ.

## Limitations

The brightness curve is a generic starting point, not a factory-calibrated Nubia curve. Brightness behavior may differ by panel and firmware. Install at your own risk.

## License

MIT; see [LICENSE](LICENSE).
