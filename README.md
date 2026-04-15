# 🧺 Laundry Pro

[![Flutter](https://flutter.dev/images/brand.svg)](https://flutter.dev) [![Dart](https://www.dartlang.org/web/icons/logo/logo.svg)](https://dart.dev) [![Provider](https://img.shields.io/badge/State%20Management-Provider-orange)](https://pub.dev/packages/provider)

**Laundry Pro** is a modern, feature-rich laundry service mobile application built with Flutter. It provides a seamless user experience for booking laundry services, tracking orders, chatting with support, and managing profiles. Features clean architecture, responsive design with light/dark theme support, and mock data for rapid development.

## ✨ Features

- **🔐 Authentication**: Email/password login & register, Google Sign-In, secure session management
- **📊 Dashboard**: Services grid, promo carousel (30% off first order, free pickup), category list
- **🛒 Orders**: Category selection (Regular Wash, Dry Cleaning, Ironing, Express, etc.), weight calculator, checkout, payment methods
- **💬 Real-time Chat**: Live support messaging with laundry team
- **📈 Order Tracking**: Status updates, history with details
- **👤 Profile**: User info, order history, settings, notifications, payment preferences
- **🎨 UI/UX**: Custom widgets, animations (shimmer, staggered), Inter font, responsive layout
- **🌙 Themes**: Light/Dark mode toggle
- **🔔 Notifications**: Push notifications support

## 📱 Screenshots

| Dashboard | Services | Checkout |
|-----------|----------|----------|
| ![Dashboard](./assets/images/dashboard.png) | ![Services](./assets/images/services.png) | ![Checkout](./assets/images/checkout.png) |

| Chat | Profile | Orders History |
|------|---------|----------------|
| ![Chat](./assets/images/chat.png) | ![Profile](./assets/images/profile.png) | ![Orders](./assets/images/orders.png) |

*(Add your screenshots to `assets/images/` and update paths)*

## 🛠️ Tech Stack

| Category | Technologies |
|----------|--------------|
| **Framework** | Flutter 3.x |
| **State Mgmt** | Provider 6.x |
| **Persistence** | SharedPreferences |
| **Auth** | Google Sign-In |
| **UI** | Flutter SVG, Shimmer, CachedNetworkImage, SmoothPageIndicator, Badges |
| **Utils** | Intl, UUID, Equatable, Validators |
| **Other** | Flutter Local Notifications, URL Launcher |
| **Architecture** | Clean Architecture (data/domain/presentation) |

## 🏗️ Project Structure

```
lib/
├── app.dart                 # Root app widget
├── main.dart               # Entry point
├── routes.dart             # App navigation
├── core/                   # Shared utilities
│   ├── constants/          # Colors, strings
│   ├── providers/          # State providers (auth, order, chat, etc.)
│   ├── services/           # API/Auth services
│   ├── utils/              # Validators
│   └── widgets/            # Reusable widgets
└── features/               # Feature modules
    ├── auth/              # Login/Register
    ├── dashboard/         # Home screen
    ├── orders/            # Order flow
    ├── chat/              # Support chat
    ├── profile/           # User profile
    └── navigation/        # Bottom nav
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.0.0
- Dart SDK >= 2.17.0
- Android Studio / VS Code / Xcode (for iOS)
- Git

### Installation

1. **Clone the repo**
   ```bash
   git clone https://github.com/yourusername/laundry_pro.git
   cd laundry_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Platforms

- Android: `flutter run`
- iOS: `open ios/Runner.xcworkspace` (Xcode)
- Web: `flutter run -d chrome`
- Desktop: `flutter run -d windows` / `macos` / `linux`

## 🧪 Testing

```bash
flutter test
```

Includes widget tests and integration tests.

## 🔧 Customization

- **Add Services**: Update `order_repository_impl.dart` mock categories
- **Real Backend**: Replace mock repos with HTTP calls in `api_services.dart`
- **Themes**: Modify `app_colors.dart` and `theme_provider.dart`
- **Payments**: Integrate Stripe/Razorpay in `payment_method_screen.dart`

## 🏗️ Architecture

Follows **Clean Architecture**:
- **Presentation**: Screens, widgets, providers
- **Domain**: Models, use cases, repositories (abstract)
- **Data**: Repositories impl, services, mock data

State flows via Providers. Currently uses mock data; easy to swap with Firebase/Supabase/Dio.

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

Built with ❤️ using Flutter by [Your Name](https://github.com/yourusername)

---

⭐ **Star the repo if you like it!** ⭐

