# Avengers Doomsday Countdown — GitHub Actions starter

This repository starter adds an XcodeGen `project.yml` and a GitHub Actions workflow to the supplied SwiftUI/WidgetKit source.

## Build on GitHub
1. Create a **Public** GitHub repository.
2. Upload the *contents* of this folder (including the hidden `.github` folder and `project.yml`) to the repository root.
3. Open **Actions** and run `Build Avengers Widget`, or push a commit to `main`/`master`.
4. Download the `Avengers-Widget-Simulator-Build` artifact after a successful run.

## Important
- This workflow builds for the **iOS Simulator only**. The resulting `.app` cannot be installed on a physical iPhone.
- Installing on an iPhone requires a correctly signed device build and provisioning profile. Do not put Apple passwords, certificates, or private keys in a public repository.
- Replace `com.example.AvengersDoomsdayWidget` and `com.example.AvengersDoomsdayWidget.widget` with unique bundle identifiers before attempting device signing. The widget bundle ID must be prefixed by the containing app's bundle ID.
- XcodeGen creates `AvengersDoomsdayWidget.xcodeproj` on the macOS runner. You do not need to create that file on Windows.
- The release date in `CountdownDate.swift` is currently set to 18 December 2026; verify the official date before relying on it.
