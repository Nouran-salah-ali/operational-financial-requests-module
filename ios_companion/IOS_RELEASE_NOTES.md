# iOS Release Notes — Quick Approval Companion

## 1. Bundle ID & Signing (Provisioning Profiles)
- **Bundle Identifier**: Set a unique reverse-DNS identifier (e.g., `com.example.quickapprovalcompanion`) matching the app record in App Store Connect.
- **Code Signing & Provisioning Profiles**: Enable **Automatically manage signing** in Xcode (`Signing & Capabilities`) with your active Apple Developer Team, or assign a valid **Apple Distribution** certificate and matching **App Store Provisioning Profile** for manual/CI signing.

## 2. Build Configurations (`Debug` vs `Release`)
- **Debug**: Uses debug symbols and faster incremental builds for local Simulator and device testing.
- **Release**: Enables compiler optimizations (`-O`), strips debug-only overhead, and prepares the binary for Archive and distribution.

## 3. Version & Build Numbering
- **Version (`MARKETING_VERSION`)**: Update semantic version numbers (e.g., `1.0.0`, `1.1.0`) for user-facing releases.
- **Build Number (`CURRENT_PROJECT_VERSION`)**: Increment integer build numbers (e.g., `1`, `2`, `3`) on every upload to App Store Connect / TestFlight, even if `MARKETING_VERSION` stays the same.

## 4. Permissions & Privacy Manifests
- **`Info.plist`**: Include `NSFaceIDUsageDescription` explaining why biometric/passcode authentication is requested during approval actions.
- **Privacy Manifest (`PrivacyInfo.xcprivacy`)**: Add and maintain a privacy manifest declaring any `NSPrivacyAccessedAPITypes` (such as `UserDefaults` or file timestamp APIs if used) and `NSPrivacyCollectedDataTypes` accurately before archiving.

## 5. Archiving & TestFlight / App Store Steps
1. Select **Any iOS Device (arm64)** as the target destination in Xcode.
2. Select **Product -> Archive** and wait for the archive build to finish.
3. Open **Window -> Organizer**, select the archive, and click **Distribute App -> App Store Connect -> Upload**.
4. Wait for App Store Connect processing to complete.
5. **TestFlight**:
    - Assign **Internal Testers** for immediate testing access.
    - Assign an **External Testing** group and submit for Beta App Review if external testers are needed.
6. **App Store Release**: Complete required App Store Connect metadata, screenshots, and review details, then submit for App Store review.