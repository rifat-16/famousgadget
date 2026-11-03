# Famous Gadget BD ⚡📱

[![Flutter](https://img.shields.io/badge/Flutter-v3.29+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/State%20Management-GetX-8A2BE2)](https://pub.dev/packages/get)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-4CAF50)](https://flutter.dev/multi-platform)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

> **"Gadgets you love. Cash on Delivery BD."**  
> A premium, high-performance cross-platform e-commerce mobile application tailored for electronic gadgets, accessories, and tech gears in Bangladesh.

---

## 🌟 Overview

**Famous Gadget BD** is a modern e-commerce mobile application built with **Flutter** and powered by **GetX** for reactive state management, dependency injection, and declarative routing. Designed with an ultra-sleek UI featuring modern gradients, soft curved containers, and a custom floating dock, it delivers an intuitive shopping experience with full support for local currency (BDT ৳) and Cash on Delivery (COD).

---

## ✨ Key Features

### 🛍️ Product Catalog & Discovery
- **Hero Promotional Banners**: Dynamic carousel featuring hot campaign discounts and sales.
- **Category Browsing**: Dedicated category hubs for Smart Watches, Cameras, Gimbals, Audio & Accessories, Projectors, Microphones, Routers, and Tablets.
- **Curated Sections**: Instant filtering for *Featured Products*, *Best Sellers*, *Hot Deals*, and *Recommended Products*.
- **Live Search**: Instant keyword search and category-wise filtering for rapid product discovery.

### 📱 Detailed Product Views
- High-resolution product images and galleries.
- Instant stock status indicators and discount percentage badges.
- Dynamic color variant pickers.
- Detailed technical specification grids and customer review ratings.
- One-tap Add-to-Cart and Wishlist bookmarking.

### 🛒 Cart & Multi-Step Checkout Pipeline
- **Reactive Shopping Cart**: Real-time quantity adjustments, price calculations, and subtotal updates.
- **Promo Code Engine**: Discount vouchers with instant validation (e.g. `DEVNIQ`, `FAMOUS`).
- **3-Step Streamlined Checkout**:
  1. **Delivery Address**: Multiple address support (Home, Office) with quick-selection and address creation.
  2. **Order Confirmation**: Order breakdown, delivery charges, COD payment method, and summary review.
  3. **Order Placed**: Confirmation receipt displaying the unique order ID (`FG-XXXXXX`) and next steps.

### 👤 Profile, Orders & Wishlist
- **Order Tracking**: Comprehensive order history tracking with visual lifecycle statuses (*Pending*, *Processing*, *Shipped*, *Delivered*, *Cancelled*).
- **Wishlist**: Quick-access collection of saved products.
- **Address Book**: Manage multiple delivery locations.
- **Authentication**: User session management and login state handled reactively.

### 🎨 Visual & UI Highlights
- **Floating Navigation Dock**: Custom floating bottom bar with smooth animations and reactive badge counters.
- **Custom Brand Identity**: Electric Orange accents (`#FF6A00`), Deep Navy surfaces (`#0B1220`), and Geist typography.
- **Dynamic Splash Screen**: Animated progress loader with brand identity.

---

## 🏗️ Architecture & Tech Stack

The project follows a clean **MVC (Model - View - Controller)** architectural pattern using **GetX**:

- **Framework**: [Flutter](https://flutter.dev) (Dart SDK `^3.9.2`)
- **State Management & DI**: [GetX](https://pub.dev/packages/get)
- **Routing**: GetX Declarative Named Routes (`AppPages` & `AppRoutes`)
- **Typography**: [Geist Font Family](assets/fonts/) & [Google Fonts](https://pub.dev/packages/google_fonts)
- **Vector Icons**: [flutter_svg](https://pub.dev/packages/flutter_svg) & [cupertino_icons](https://pub.dev/packages/cupertino_icons)

---

## 📂 Project Structure

```text
famousgadget/
├── assets/
│   ├── fonts/               # Geist font weights (Regular, SemiBold)
│   └── images/              # Logo and graphical brand assets
├── lib/
│   ├── controllers/         # GetX controllers (Auth, Cart, Checkout, Home, Nav, Product)
│   ├── core/
│   │   ├── constants/       # App assets, spacing, layout constants
│   │   ├── theme/           # Color palettes, typography (Geist), ThemeData
│   │   └── widgets/         # Reusable widgets (CustomButton, ProductCard, Badges)
│   ├── models/              # Immutable data models (Product, Cart, Order, Address, User)
│   ├── routes/              # Declarative AppRoutes & GetPage route definitions
│   ├── views/
│   │   ├── account/         # Profile, Orders, Wishlist, Addresses views
│   │   ├── auth/            # Login view
│   │   ├── cart/            # Cart management view
│   │   ├── categories/      # Category exploration view
│   │   ├── checkout/        # Step-by-step checkout & success views
│   │   ├── home/            # Home dashboard with banners & product grids
│   │   ├── nav/             # Main navigation wrapper with floating dock
│   │   ├── product/         # Product listing & detailed product view
│   │   ├── search/          # Live search view
│   │   └── splash/          # Animated splash screen
│   └── main.dart            # Application entrypoint & dependency initialization
├── pubspec.yaml             # Dependencies and asset declarations
└── README.md                # Project documentation
```

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>= 3.29.0`)
- [Dart SDK](https://dart.dev/get-dart) (`>= 3.9.2`)
- Android Studio / Xcode / VS Code with Flutter extension

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/rifat-16/famousgadget.git
   cd famousgadget
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**

   - **Android:**
     ```bash
     flutter run -d android
     ```

   - **iOS:**
     ```bash
     flutter run -d ios
     ```

   - **Web / Desktop:**
     ```bash
     flutter run -d chrome
     # or for macOS
     flutter run -d macos
     ```

---

## 🎨 Theme & Design System

| Element | Specification |
| :--- | :--- |
| **Primary Orange** | `#FF6A00` |
| **Dark Orange** | `#E05A00` |
| **Navy Dark** | `#0B1220` |
| **Page Background** | `#F3F5FA` |
| **Card White** | `#FFFFFF` |
| **Typography** | `Geist` (Custom) & `Outfit` / `Inter` |

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
