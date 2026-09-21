# Peer-Link — Campus Barter Marketplace

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Riverpod-2.x-5C6BC0?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" />
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white" />
</p>

<p align="center">
  <strong>A Flutter-based peer-to-peer marketplace designed for campus communities.</strong>
</p>

<p align="center">
  Students can discover, list, search, and exchange items with other students through a mobile-first marketplace with real-time chat and Firebase-powered services.
</p>

---

## 📱 Overview

**Peer-Link** is a peer-to-peer campus marketplace built with **Flutter, Dart, Firebase, and Riverpod**.

The project was designed around a simple problem:

> Students often have books, electronics, dorm essentials, clothing, and other items that they no longer need, while other students may be looking for those same items.

Peer-Link provides a centralized platform where students can:

- Create marketplace listings
- Upload item images
- Browse available products
- Search and filter listings
- Communicate with other users
- Negotiate exchanges through real-time chat
- Receive notifications about relevant activity

The project also serves as a practical implementation of modular Flutter architecture, Firebase integration, state management, and CI/CD automation.

---

## ✨ Key Features

### 🔐 Authentication

- Email/password authentication
- Firebase Authentication
- User profile synchronization with Cloud Firestore

### 🛍️ Marketplace

- Create product listings
- Upload product images
- Browse marketplace items
- Category-based organization
- Product detail screens
- Search and filtering

### 📷 Image Handling

- Native camera/gallery integration using `image_picker`
- Image upload through Firebase Cloud Storage
- Image display using `cached_network_image`

### 💬 Real-Time Chat

- Peer-to-peer messaging
- Real-time Firestore streams
- Conversation-based communication
- Exchange and negotiation discussions

### 🔔 Notifications

- Firebase Cloud Messaging
- Foreground notification handling
- Background notification support
- Trade/activity notifications

### 🎨 Modern UI

- Material 3 design
- Custom typography
- Hero transitions
- Ripple interactions
- Skeleton/shimmer loading states
- Responsive Flutter layouts

### ⚙️ Development Workflow

- Feature-first project organization
- Layered architecture
- Riverpod state management
- Git version control
- GitHub Actions CI/CD
- Automated static analysis
- Automated unit testing

---

# 🏗️ Architecture

Peer-Link follows a **Feature-First Layered Architecture** designed to separate responsibilities between the different parts of the application.

```text
lib/
│
├── core/
│   ├── router/
│   ├── services/
│   ├── theme/
│   └── widgets/
│
└── features/
    │
    ├── auth/
    │   ├── domain/
    │   ├── data/
    │   ├── application/
    │   └── presentation/
    │
    ├── products/
    │   ├── domain/
    │   ├── data/
    │   ├── application/
    │   └── presentation/
    │
    └── chat/
        ├── domain/
        ├── data/
        ├── application/
        └── presentation/
