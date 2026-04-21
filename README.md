# DeskRun

An open-source macOS app that controls DeerRun walking treadmills via Bluetooth Low Energy and syncs workout data to Apple Health.

## Features

- **BLE Treadmill Control** — Start, stop, pause, and adjust speed directly from your Mac
- **Live Dashboard** — Real-time speed, distance, steps, time, and calories
- **Menu Bar Widget** — Quick-access stats and controls while you work
- **HealthKit Sync** — Workout data syncs to Apple Health (coming soon)

## Supported Treadmills

- DeerRun Urban Pro Plus (PitPat-T01)
- Other PitPat-compatible treadmills (untested)

## Requirements

- macOS 14.0 (Sonoma) or later
- Bluetooth Low Energy
- Xcode 15+ (to build from source)

## Building

1. Clone the repository
2. Open `DeskRun.xcodeproj` in Xcode
3. Set your Development Team under Signing & Capabilities
4. Build and run (⌘R)

## BLE Protocol

DeskRun communicates with PitPat-compatible treadmills using a proprietary BLE protocol. Protocol details were reverse-engineered from the [pitpat-treadmill-control](https://github.com/azmke/pitpat-treadmill-control) and [pacekeeper](https://github.com/peteh/pacekeeper) projects.

## Contributing

Contributions welcome\! If you have a different treadmill model and can capture BLE traffic, we'd love help expanding device support.

## License

MIT License — see [LICENSE](LICENSE) for details.
