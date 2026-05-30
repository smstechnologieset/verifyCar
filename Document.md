# EthioDrive History — Developer Handoff Document

**Read this file only** to understand the product, codebase, backend, gaps, and how to ship an Android APK.

| Item | Value |
|------|--------|
| **Product name** | EthioDrive History (SafeRegistry-style vehicle verification) |
| **Dart package** | `ethiodrive_history` |
| **Android application ID** | `com.vehicleverify.vehicle_history_app` |
| **Firebase project** | `vehicleverify-f6ca8` |
| **Primary audience** | Ethiopian users (default UI language: **Amharic**) |
| **Current version** | `1.0.0+1` (`pubspec.yaml`) |

---

## Table of contents

1. [What this app does](#1-what-this-app-does)
2. [What is implemented](#2-what-is-implemented)
3. [What is missing (roadmap)](#3-what-is-missing-roadmap)
4. [Tech stack](#4-tech-stack)
5. [Architecture](#5-architecture)
6. [Folder and file structure](#6-folder-and-file-structure)
7. [Navigation and screens](#7-navigation-and-screens)
8. [Firebase backend](#8-firebase-backend)
9. [Localization](#9-localization)
10. [Key user flows](#10-key-user-flows)
11. [State management and dependency injection](#11-state-management-and-dependency-injection)
12. [Theming and UI](#12-theming-and-ui)
13. [Security model (current vs intended)](#13-security-model-current-vs-intended)
14. [Known limitations and gotchas](#14-known-limitations-and-gotchas)
15. [Onboarding checklist for a new developer](#15-onboarding-checklist-for-a-new-developer)
16. [Building and installing an APK on your phone](#16-building-and-installing-an-apk-on-your-phone)

---

## 1. What this app does

EthioDrive History is a **Flutter mobile app** styled like an official Ethiopian Ministry of Transport vehicle registry tool. It lets:

### Customers (no login)

1. Enter a **chassis number / VIN** on the home screen.
2. Search the **Firestore `vehicles`** collection.
3. See a **preview** (model, color) if the vehicle exists.
4. Pay a configurable fee (currently **simulated** — not real Chapa yet).
5. View a **full vehicle history report**, including owner/location/license/technical fields and a **bank sale block** banner (`blockedByBankForSale`).

Searches and payments are **logged** to Firestore; aggregate counters update the admin dashboard.

### Admins (Firebase Auth + Firestore role)

1. Sign in with **email/password** (Firebase Authentication).
2. App verifies `users/{uid}` has `role: "admin"` and `isActive: true`.
3. **Dashboard**: live stats (vehicles count, searches, paid reports, revenue).
4. **Vehicles tab**: list, add, edit, delete registry records.
5. **Settings tab**: edit `settings/app` (payment amount, company name, support contacts, PDF footer text) and switch language.

### Localization

- **English** and **Amharic**; default locale is `am`.
- Language switcher on home header and admin settings.

---

## 2. What is implemented

| Area | Status |
|------|--------|
| Customer chassis search | Done (Firestore) |
| Vehicle preview screen | Done |
| Simulated payment + Firestore `payments` + `stats` update | Done |
| Full report screen + bank sale banner | Done |
| Admin login (role check) | Done |
| Admin dashboard stats | Done (streams vehicles + stats) |
| Admin vehicle CRUD | Done |
| Admin settings editor | Done |
| Firebase Auth + Firestore data layer | Done |
| Firestore security rules (in repo) | Done — **must be deployed** |
| English + Amharic l10n | Done |
| Light government-themed UI | Done |
| Mock data layer | **Removed** — app requires Firebase |
| GoRouter navigation | Done |
| Riverpod providers | Done |
| Clean architecture (domain / data / presentation) | Done |

---

## 3. What is missing (roadmap)

These were planned in the original spec but **not built yet**. Implement in roughly this order unless product says otherwise:

| Priority | Feature | Notes |
|----------|---------|--------|
| High | **Real Chapa payment** | Replace `_simulatePayment` in `payment_screen.dart`; verify webhook/callback; store real `reference` |
| High | **PDF report** | Generate/download/share official PDF; use `settings` footer and optional logo |
| Medium | **Firebase Storage** | Company logo upload (`companyLogoUrl` in settings) |
| Medium | **Persist locale** | `shared_preferences` so language survives app restart |
| Medium | **Tighter Firestore rules** | Full report only after verified payment (today anyone with chassis can read `vehicles`) |
| Low | **Firebase Analytics / Crashlytics** | Production monitoring |
| Low | **iOS build** | `firebase_options.dart` throws for iOS — Android only today |
| Low | **Play Store signing** | Release builds currently use **debug signing** (see §16) |

---

## 4. Tech stack

| Layer | Technology |
|-------|------------|
| Framework | **Flutter** (Dart SDK `^3.9.2`) |
| State | **flutter_riverpod** `^2.6.1` |
| Routing | **go_router** `^14.8.1` |
| Backend | **Firebase** — `firebase_core`, `firebase_auth`, `cloud_firestore` |
| Fonts | **google_fonts** (Inter + Noto Sans Ethiopic for Amharic) |
| Dates/numbers | **intl** |
| L10n | Flutter **gen-l10n** (`flutter: generate: true`, `l10n.yaml`) |
| Android | Kotlin Gradle, `google-services` plugin, min/target SDK from Flutter template |
| CI/deploy (manual) | Firebase CLI for Firestore rules (`firebase deploy --only firestore:rules`) |

**Not in dependencies yet:** `shared_preferences`, Chapa SDK, PDF package, `firebase_storage`, Analytics, Crashlytics.

---

## 5. Architecture

The project follows **layered clean architecture**: UI depends on domain abstractions; Firebase lives only in `data/`.

```
┌─────────────────────────────────────────────────────────────┐
│  presentation/  screens, widgets, Riverpod providers      │
└───────────────────────────┬─────────────────────────────────┘
                            │ uses
┌───────────────────────────▼─────────────────────────────────┐
│  domain/  models + repository interfaces (abstract)         │
└───────────────────────────┬─────────────────────────────────┘
                            │ implemented by
┌───────────────────────────▼─────────────────────────────────┐
│  data/firebase/  FirebaseAuth, Firestore repos + DTOs       │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│  core/  theme, router, extensions, utils, report l10n      │
└─────────────────────────────────────────────────────────────┘
```

### Design rules used in this codebase

- **Repository pattern**: `domain/repositories/*.dart` interfaces; `data/firebase/*_repository.dart` implementations.
- **DTO mapping**: Firestore documents ↔ domain models in `data/firebase/dto/`.
- **No Firebase in widgets**: screens call `ref.read(xxxRepositoryProvider)` or watch stream providers.
- **Single Firestore path constants**: `data/firebase/firestore_paths.dart`.
- **User-facing errors**: `core/utils/user_messages.dart` maps exceptions to localized strings via `AppLocalizations`.

### App entry

1. `main.dart` — `WidgetsFlutterBinding`, `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`, `ProviderScope`, `EthioDriveApp`.
2. `app.dart` — `MaterialApp.router` with theme, locale, l10n delegates, `GoRouter`.

---

## 6. Folder and file structure

```
Vehicle/                          # Project root
├── Document.md                   # ← This file (handoff + APK guide)
├── README.md                     # Short setup summary (Firebase seed data)
├── pubspec.yaml                  # Dependencies, version, flutter generate: true
├── l10n.yaml                     # gen-l10n config (arb-dir: lib/l10n)
├── firestore.rules               # Firestore security rules (deploy required)
├── firebase.json                 # Points deploy to firestore.rules
│
├── android/                      # Android native project
│   └── app/
│       ├── google-services.json  # Firebase Android config (required)
│       └── build.gradle.kts      # applicationId, release uses debug signing
│
└── lib/
    ├── main.dart                 # Entry + Firebase init
    ├── app.dart                  # MaterialApp.router + l10n
    ├── firebase_options.dart     # Generated/manual Firebase options (Android)
    │
    ├── l10n/                     # Localization
    │   ├── app_en.arb            # English strings (template)
    │   ├── app_am.arb            # Amharic strings
    │   └── app_localizations*.dart  # Generated — do not edit by hand
    │
    ├── core/
    │   ├── router/app_router.dart       # GoRouter routes + admin redirects
    │   ├── theme/app_colors.dart
    │   ├── theme/app_theme.dart         # lightForLocale() — Ethiopic font for am
    │   ├── extensions/l10n_extension.dart   # context.l10n
    │   ├── utils/user_messages.dart
    │   └── l10n/vehicle_report_l10n.dart  # Dynamic report field labels
    │
    ├── domain/
    │   ├── models/               # Vehicle, AppUser, AppSettings, DashboardStats
    │   └── repositories/         # Abstract Auth, Vehicle, Settings, Registry
    │
    ├── data/firebase/
    │   ├── firestore_paths.dart
    │   ├── firebase_auth_repository.dart
    │   ├── firebase_vehicle_repository.dart
    │   ├── firebase_settings_repository.dart
    │   ├── firebase_registry_repository.dart  # search logs, payments, stats
    │   └── dto/                  # vehicle_dto, settings_dto, app_user_dto
    │
    └── presentation/
        ├── providers/
        │   ├── repository_providers.dart   # Wire Firebase repos
        │   ├── app_providers.dart          # Streams: vehicles, settings, stats
        │   └── locale_provider.dart        # Default Locale('am')
        ├── shell/main_shell.dart           # Bottom nav: Home / Admin
        ├── customer/                 # home, preview, payment, report
        ├── admin/                    # login, dashboard, tabs, vehicle form
        └── shared/widgets/         # cards, buttons, language switcher, banners
```

---

## 7. Navigation and screens

| Route | Screen | Auth |
|-------|--------|------|
| `/` | `HomeScreen` | Public |
| `/preview/:chassis` | `VehiclePreviewScreen` | Public |
| `/payment/:chassis` | `PaymentScreen` | Public |
| `/report/:chassis?ref=...` | `VehicleReportScreen` | Public |
| `/admin` | `AdminLoginScreen` | Redirects to dashboard if already admin |
| `/admin/dashboard` | `AdminDashboardScreen` | Requires admin `AppUser` |

`MainShell` wraps `/` and `/admin` with bottom navigation (Verification / Admin).

**Router file:** `lib/core/router/app_router.dart`  
**Provider:** `routerProvider` (Riverpod).

---

## 8. Firebase backend

### Project

- **Console:** [Firebase Console](https://console.firebase.google.com/) → project **`vehicleverify-f6ca8`**
- **Android package:** `com.vehicleverify.vehicle_history_app`
- **Config files:** `android/app/google-services.json`, `lib/firebase_options.dart`

### Authentication

- **Email/Password** enabled in Firebase Console.
- Admin must exist in **Authentication** and in **`users/{uid}`** with admin role.

### Firestore collections

| Collection | Document ID | Purpose |
|------------|---------------|---------|
| `users` | Firebase Auth UID | Admin profile: `email`, `displayName`, `role`, `isActive`, `createdAt` |
| `vehicles` | Auto ID | Full vehicle registry record; query by `chassisNumber` (stored uppercase) |
| `settings` | `app` | `paymentAmountEtb`, `companyName`, `pdfFooterText`, `supportEmail`, `supportPhone`, optional `companyLogoUrl` |
| `search_logs` | Auto ID | Customer search audit: chassis, found flag, timestamp |
| `payments` | Auto ID | Payment audit: chassis, amount, reference, timestamp |
| `stats` | `summary` | `totalSearches`, `totalPaidReports`, `totalRevenueEtb` |

### Seed data (minimum to run)

**`settings/app`** example:

```json
{
  "paymentAmountEtb": 250,
  "companyName": "Ministry of Transport",
  "pdfFooterText": "Official vehicle history report...",
  "supportEmail": "support@mot.gov.et",
  "supportPhone": "+251 11 000 0000"
}
```

**`users/{admin-uid}`** (UID must match Auth user):

```json
{
  "email": "admin@vehicle.com",
  "displayName": "Admin User",
  "role": "admin",
  "isActive": true,
  "createdAt": "<Firestore Timestamp>"
}
```

Add **`vehicles`** via admin UI after login.

### Deploy rules (required)

Without deployed rules, anonymous users get **permission-denied** on payment/stats:

```bash
firebase login
firebase use vehicleverify-f6ca8
firebase deploy --only firestore:rules
```

Rules summary (`firestore.rules`):

- `vehicles`, `settings`: public read; admin write
- `search_logs`, `payments`: anyone can create; admin read/update/delete
- `stats`: public read/create/update (customer counters); admin delete
- `users`: user can read own doc only; no client writes

---

## 9. Localization

| File | Role |
|------|------|
| `lib/l10n/app_en.arb` | English source strings |
| `lib/l10n/app_am.arb` | Amharic translations |
| `l10n.yaml` | `arb-dir: lib/l10n`, template `app_en.arb` |

- **Default locale:** `Locale('am')` in `locale_provider.dart`
- **Usage in UI:** `context.l10n.someKey` via `l10n_extension.dart`
- **After editing ARB:** `flutter pub get` or `flutter gen-l10n`
- **Report-specific strings:** `vehicle_report_l10n.dart` (enum-like field labels)

---

## 10. Key user flows

### Customer search → report

```
Home → enter chassis → VehicleRepository.findByChassis
  → RegistryRepository.logSearch
  → /preview/:chassis
  → confirm → /payment/:chassis
  → simulate pay (2s delay) → RegistryRepository.recordPayment
  → /report/:chassis?ref=CHP-...
```

### Admin

```
/admin → signInAdmin → check users/{uid}
  → /admin/dashboard
  → Vehicles CRUD (VehicleRepository)
  → Settings (SettingsRepository → settings/app)
```

### Payment simulation (replace for Chapa)

See `lib/presentation/customer/payment/payment_screen.dart` → `_simulatePayment`.  
It generates `CHP-YYYYMMDD-xxxxx` and calls `recordPayment` on `FirebaseRegistryRepository`.

---

## 11. State management and dependency injection

**Riverpod** only (no GetIt).

| Provider | Purpose |
|----------|---------|
| `authRepositoryProvider` | `FirebaseAuthRepository` |
| `vehicleRepositoryProvider` | `FirebaseVehicleRepository` |
| `settingsRepositoryProvider` | `FirebaseSettingsRepository` |
| `registryRepositoryProvider` | `FirebaseRegistryRepository` |
| `vehicleByChassisProvider` | `FutureProvider.family` for lookup |
| `vehiclesStreamProvider` | Admin vehicle list |
| `settingsStreamProvider` | Payment amount, company info |
| `dashboardStatsProvider` | Admin stats (waits for auth) |
| `localeProvider` | `StateProvider<Locale>` |
| `routerProvider` | `GoRouter` instance |

---

## 12. Theming and UI

- **Style:** Light government theme — navy/gold accents (`app_colors.dart`).
- **Fonts:** Inter (Latin); **Noto Sans Ethiopic** when locale is `am` (`app_theme.dart`).
- **Reusable widgets:** `AppCard`, `GradientButton`, `SectionHeader`, `InfoRow`, `StatCard`, `BankSaleStatusBanner`, `LanguageSwitcher`.

---

## 13. Security model (current vs intended)

**Current (MVP):**

- Vehicle documents are **world-readable** — knowing a chassis number allows reading full data from Firestore directly, not only through the app.
- Payment does **not** gate Firestore access; the app only gates the **UI flow**.
- Admin writes require Firebase Auth + `users` admin document.

**Intended (future):**

- Store only preview fields on public docs, or enforce paid access via Cloud Functions / custom claims.
- Verify Chapa payment server-side before unlocking full report.

---

## 14. Known limitations and gotchas

1. **Firestore rules must be deployed** after any change to `firestore.rules`.
2. **`stats/summary`** is auto-created on first search/payment via `_ensureStatsDoc()` (no read-before-write for guests).
3. **iOS** is not configured in `firebase_options.dart`.
4. **Locale** resets on app kill (not persisted).
5. **`flutter analyze`**: one info-level `use_build_context_synchronously` in `vehicles_tab.dart` (non-blocking).
6. **Release APK** uses debug signing in `android/app/build.gradle.kts` — fine for personal testing, not for Play Store.
7. **Internet required** on device for Firebase (merged manifest from Firebase plugins adds `INTERNET`).

---

## 15. Onboarding checklist for a new developer

1. Install **Flutter SDK** (3.9+), **Android Studio** (SDK + platform tools), **Git**.
2. Clone/open this repo: `c:\Users\imkin\Desktop\Vehicle` (or your path).
3. Run `flutter doctor` and fix any **Android toolchain** issues.
4. Ensure `android/app/google-services.json` exists (ask team or Firebase Console).
5. `flutter pub get`
6. Deploy Firestore rules (§8).
7. Seed `settings/app` and admin `users/{uid}` in Firebase Console.
8. Create admin in Firebase Authentication; match UID in `users` collection.
9. `flutter run` on emulator or device.
10. Add test vehicles in admin dashboard.
11. Read §3 for what to build next.

**Useful commands:**

```bash
flutter pub get
flutter run
flutter analyze
flutter gen-l10n
firebase deploy --only firestore:rules
```

---

## 16. Building and installing an APK on your phone

Step-by-step guide to produce an APK you can sideload on a physical Android device for testing. Follow in order.

### 16.1 Prerequisites (one-time)

1. **Install Flutter**  
   - Download: https://docs.flutter.dev/get-started/install/windows  
   - Add Flutter `bin` to your PATH.

2. **Install Android Studio**  
   - Install **Android SDK**, **SDK Platform** (API 34+ recommended), and **Android SDK Build-Tools**.  
   - Accept licenses: open a terminal and run:
     ```bash
     flutter doctor --android-licenses
     ```
     Accept all prompts with `y`.

3. **Verify setup**
   ```bash
   cd c:\Users\imkin\Desktop\Vehicle
   flutter doctor -v
   ```
   Fix anything marked with ✗ (especially **Android toolchain** and **Android Studio**).

4. **JDK**  
   Flutter 3.x typically uses the JDK bundled with Android Studio. If `flutter doctor` reports Java issues, install JDK 17 and set `JAVA_HOME`.

### 16.2 Project checks before building

1. **Firebase config present**
   - File must exist: `android/app/google-services.json`
   - Package name inside must be: `com.vehicleverify.vehicle_history_app`

2. **Dependencies**
   ```bash
   cd c:\Users\imkin\Desktop\Vehicle
   flutter clean
   flutter pub get
   ```

3. **Analyze (optional but recommended)**
   ```bash
   flutter analyze lib
   ```
   Errors must be fixed; infos/warnings are usually OK.

4. **Firestore rules deployed** (app will fail on payment/search stats otherwise)
   ```bash
   firebase login
   firebase use vehicleverify-f6ca8
   firebase deploy --only firestore:rules
   ```

5. **Phone / backend**
   - Phone needs **Wi‑Fi or mobile data** (Firebase).
   - Firebase project must have test **vehicles** and **settings/app** (§8).

### 16.3 Build a debug APK (easiest for testing)

Debug APKs are larger but simplest for sideloading during development.

```bash
cd c:\Users\imkin\Desktop\Vehicle
flutter build apk --debug
```

**Output file:**

```
build\app\outputs\flutter-apk\app-debug.apk
```

Full path example:

```
c:\Users\imkin\Desktop\Vehicle\build\app\outputs\flutter-apk\app-debug.apk
```

### 16.4 Build a release APK (smaller, closer to production)

The project is configured to sign release builds with the **debug keystore** so you can install without creating a release keystore yet (`android/app/build.gradle.kts` → `signingConfig = debug`).

```bash
cd c:\Users\imkin\Desktop\Vehicle
flutter build apk --release
```

**Output file:**

```
build\app\outputs\flutter-apk\app-release.apk
```

For a single APK that runs on all common phones (recommended for sideloading):

```bash
flutter build apk --release
```

(Optional) Split per CPU architecture (smaller per file, pick the right one for your phone):

```bash
flutter build apk --release --split-per-abi
```

Outputs under `build\app\outputs\flutter-apk\` e.g. `app-arm64-v8a-release.apk` — use **arm64-v8a** for most modern phones.

### 16.5 Transfer APK to your phone

**Option A — USB cable (ADB)**

1. On the phone: **Settings → About phone** → tap **Build number** 7 times → enable **Developer options**.
2. **Settings → Developer options** → enable **USB debugging**.
3. Connect phone via USB; allow debugging when prompted.
4. On PC:
   ```bash
   adb devices
   ```
   Your device should appear as `device` (not `unauthorized`).
5. Install:
   ```bash
   adb install -r build\app\outputs\flutter-apk\app-release.apk
   ```
   Use `app-debug.apk` if you built debug. `-r` replaces an existing install.

**Option B — Copy file manually**

1. Copy `app-release.apk` to the phone (USB file transfer, Google Drive, Telegram, etc.).
2. Open the APK with a file manager on the phone.
3. If prompted, allow **Install unknown apps** for that app (Files, Chrome, etc.).

### 16.6 First launch on the device

1. Open **ethiodrive_history** (launcher name may show package label until you change `android:label` in `AndroidManifest.xml`).
2. Confirm **internet** works (try a search).
3. Default language is **Amharic**; switch to English from the home header if needed.
4. Test customer flow with a chassis number that exists in Firestore.
5. Test admin: **Admin** tab → sign in with your Firebase admin account.

### 16.7 Troubleshooting APK install / runtime

| Problem | Solution |
|---------|----------|
| `adb: command not found` | Add Android SDK `platform-tools` to PATH (via Android Studio SDK Manager). |
| `INSTALL_FAILED_UPDATE_INCOMPATIBLE` | Uninstall old APK first: `adb uninstall com.vehicleverify.vehicle_history_app` |
| App opens then crashes immediately | Run `adb logcat` while launching; often missing `google-services.json` or wrong package name. |
| `permission-denied` on payment | Deploy `firestore.rules` (§8). |
| Vehicle not found | Add vehicle in admin dashboard; chassis stored **uppercase**. |
| Firebase / network errors | Check phone internet; confirm Firebase project is active. |
| Build fails on Gradle | Run `flutter clean`, delete `android/.gradle` if needed, `flutter pub get`, retry. |
| White screen / Firebase init error | Ensure `lib/firebase_options.dart` matches `google-services.json` project. |

### 16.8 Play Store / production signing (later)

For Google Play you must **not** use debug signing:

1. Create a upload keystore: https://docs.flutter.dev/deployment/android#signing-the-app  
2. Configure `signingConfigs` in `android/app/build.gradle.kts`.  
3. Register **SHA-1/SHA-256** in Firebase Console for release builds if using App Check or some Auth features.  
4. Build **App Bundle** for Play: `flutter build appbundle --release`

---

## Quick reference card

| Task | Command |
|------|---------|
| Run on connected device | `flutter run` |
| Debug APK | `flutter build apk --debug` |
| Release APK (test signing) | `flutter build apk --release` |
| Install via USB | `adb install -r build\app\outputs\flutter-apk\app-release.apk` |
| Deploy rules | `firebase deploy --only firestore:rules` |
| Regenerate translations | `flutter gen-l10n` |

---

## Document maintenance

When you ship a major feature, update:

- §2 (implemented) and §3 (roadmap)
- §8 if collections or rules change
- §6 if folder structure changes
- §16 if Android signing or build steps change

**Last updated:** May 2026 — matches app version `1.0.0+1` with Firebase backend, simulated payments, and EN/AM localization.
