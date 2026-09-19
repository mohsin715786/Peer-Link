# Campus Barter — Peer-to-Peer Exchange Marketplace

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/State_Management-Riverpod_2.x-00599C?style=for-the-badge&logo=dart&logoColor=white)](https://riverpod.dev)
[![Firebase](https://img.shields.io/badge/Backend-Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)
[![CI/CD Pipeline](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)

**Campus Barter** is a production-ready, peer-to-peer exchange marketplace mobile application engineered specifically for localized campus communities. It enables students to safely list, search, negotiate, and trade textbooks, electronics, dorm essentials, and games with peers on their university campus.

---

## 🌟 Key Features

- **📱 Native Camera Integration:** Capture high-resolution item photos directly using native device hardware (`image_picker`) with instant image optimization and Cloud Storage upload.
- **💬 Real-Time Barter Chat:** Negotiate trades, propose meeting points, and finalize exchange details with real-time Firestore message streams.
- **🔔 Push Notifications:** Integrated Firebase Cloud Messaging (FCM) background and in-app foreground banner notifications for trade offers.
- **🎨 Material 3 Design System:** Modern UI featuring custom typography (`Poppins`), dynamic color scheme, Hero image transitions, ripple effects, and skeleton shimmer loading screens (`shimmer`).
- **🔍 Advanced Search & Filter:** Filter items by campus categories (*Textbooks, Electronics, Clothing, Dorm Essentials, Games*) with real-time text query matching.
- **🔒 Secure Authentication:** Email/Password authentication with synchronized student user profiles stored in Cloud Firestore.
- **⚡ CI/CD Automation:** Automated GitHub Actions pipeline ensuring code quality via linter analysis (`flutter analyze`) and unit test execution (`flutter test`).

---

## 🏗️ Architecture & Tech Stack

The codebase strictly adheres to **Feature-First Layered Architecture**, enforcing clean separation of concerns across Domain, Data, Application, and Presentation layers:

```
lib/
├── core/                       # Shared utilities, theme & routing
│   ├── router/                 # GoRouter configuration
│   ├── services/               # FCM Notification Service
│   ├── theme/                  # Material 3 Design System Theme
│   └── widgets/                # Reusable Shimmer & Loading widgets
└── features/                   # Feature-first modular layers
    ├── auth/                   # Authentication Feature
    │   ├── domain/             # User Data Models
    │   ├── data/               # Auth & Firestore Repositories
    │   ├── application/        # Riverpod Auth Providers & Controllers
    │   └── presentation/       # Login & Sign-Up Screens
    ├── products/               # Marketplace Products Feature
    │   ├── domain/             # Product Listing Models
    │   ├── data/               # Product & Storage Repositories
    │   ├── application/        # Feed & Product Controllers
    │   └── presentation/       # Feed, Detail & Native Camera Add-Product Screens
    └── chat/                   # Peer Messaging Feature
        ├── domain/             # Message Models
        ├── data/               # Firestore Chat Repository
        ├── application/        # Chat Stream Providers
        └── presentation/       # Real-Time Barter Chat Screen
```

### Technology Stack
- **Framework:** Flutter (latest stable)
- **State Management:** Riverpod (`flutter_riverpod`, `riverpod_annotation`)
- **Backend Services:** Firebase (Auth, Firestore, Storage, Cloud Messaging)
- **Navigation:** `go_router`
- **Networking & Cache:** `cached_network_image`
- **Native Interop:** `image_picker`
- **CI/CD:** GitHub Actions

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (3.x or higher)
- [Dart SDK](https://dart.dev/get-started) (3.2.0 or higher)
- Android Studio / VS Code with Flutter extension
- An active [Firebase Account](https://console.firebase.google.com/)

### Installation & Setup

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/your-username/campus-barter.git
   cd campus-barter
   ```

2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase (Optional for Live Backend):**
   ```bash
   # Install FlutterFire CLI if not already installed
   dart pub global activate flutterfire_cli

   # Configure project platforms
   flutterfire configure
   ```

4. **Run Code Generation (if using generators):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

5. **Analyze & Test:**
   ```bash
   flutter analyze
   flutter test
   ```

6. **Launch the Application:**
   ```bash
   flutter run
   ```

---

## 🧪 CI/CD Pipeline

This project includes a fully configured **GitHub Actions Workflow** located at [`.github/workflows/flutter_ci.yml`](.github/workflows/flutter_ci.yml) that executes on every pull request and push to `main`:

1. Checks out repository code.
2. Sets up JDK 17 & Flutter SDK environment.
3. Resolves project dependencies (`flutter pub get`).
4. Performs strict code quality analysis (`flutter analyze`).
5. Executes automated unit tests (`flutter test`).

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.
