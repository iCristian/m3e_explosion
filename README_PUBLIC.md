# 🎨 Material 3 Expressive Explosion

**A Comprehensive Material Design 3 Showcase App** featuring animations, shapes, interactive components, and an advanced architectural pattern.

![Flutter](https://img.shields.io/badge/Flutter-3.11.3-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.11-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-blue.svg)

---

## ✨ Features

### 🎯 Material 3 Components
- ✅ Advanced Button Styles & Animations
- ✅ Custom Navigation Patterns
- ✅ Progress & Motion Indicators
- ✅ Refresh & AppBar Designs
- ✅ M3 Core Components Showcase

### 🎬 Video Integration
- ✅ YouTube Player (iframe)
- ✅ Custom Controls & Animations
- ✅ Responsive Design

### 🎨 Visual Effects
- ✅ Custom M3 Shapes (Gem, SoftBurst, Pill)
- ✅ Smooth Animations (flutter_animate)
- ✅ Gradient Effects
- ✅ Animated Transitions

### 📱 Modules
- **Routines**: Habit tracking & streaks
- **Focus**: Pomodoro & distraction blocking
- **Finance**: Spending tracking & budget alerts
- **Health**: Hydration, sleep & movement monitoring
- **Agenda**: Events, reminders & priorities
- **Automation**: Context-aware rules

### 🏗️ Architecture
- **MVVM Pattern** with ChangeNotifier
- **Service Locator** (GetIt) for dependency injection
- **Layered Architecture**: Models → Services → ViewModels → UI
- **Reusable Components**: Widgets, ViewModels, Services
- **100% Documented** with Dartdoc

---

## 📋 Prerequisites

- Flutter: ^3.11.3
- Dart: ^3.11.3
- Android: API 21+ (minSdk)
- iOS: 12.0+

---

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/m3e_explosion.git
cd m3e_explosion
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Local Configuration (IMPORTANT)
```bash
# Copy the example env file
cp .env.example .env.local

# Edit with your configuration
nano .env.local
```

### 4. Run the App
```bash
flutter run
```

### 5. Build for Production
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

---

## 🔐 Local Configuration

### Setup Local Bundle ID

**IMPORTANT:** The repository uses generic bundle IDs for public sharing. You must configure your own for builds.

#### Android
1. Edit `android/app/build.gradle.kts`
2. Update `applicationId` to your bundle ID (e.g., `com.yourcompany.m3eexplosion`)
3. Save and run `flutter pub get`

#### iOS
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select "Runner" project
3. In Build Settings, search for "Bundle Identifier"
4. Update to your bundle ID
5. Configure signing team & certificate

#### Or use the setup script:
```bash
chmod +x setup_local.sh
./setup_local.sh
```

---

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── service_locator.dart              # Dependency injection
├── models/
│   └── app_models.dart               # Enums, constants, extensions
├── services/
│   └── preferences_service.dart      # Persistent storage
├── viewmodels/
│   └── video_player_viewmodel.dart   # Video logic
├── widgets/
│   └── reusable_widgets.dart         # Reusable components
├── screens/                          # Feature screens
└── utils/                            # Utilities
```

---

## 🏗️ Architecture Pattern

### MVVM + Service Locator

```
UI Layer (Widgets)
    ↓
ChangeNotifier.addListener()
    ↓
ViewModel (Business Logic)
    ↓ notifyListeners()
setState() → Rebuild UI
    ↑
    └─ Service Locator (GetIt)
         ↓
    Services (AppPreferencesService, etc)
         ↓
    Data Layer (SharedPreferences, API, etc)
```

---

## 📚 Documentation

- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Complete architecture guide
- **[lib/README.md](lib/README.md)** - Code structure & navigation
- **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** - What was implemented
- **Dartdoc** - 100% commented code (run `dart doc`)

---

## 🔄 How to Add a New Feature

### 1. Create a ViewModel
Copy `lib/viewmodels/ejemplo_viewmodel.dart.template` and implement your logic.

### 2. Register in Service Locator
Add to `lib/service_locator.dart`:
```dart
getIt.registerSingleton<MyViewModel>(MyViewModel());
```

### 3. Use in Your Screen
```dart
final myVM = getIt<MyViewModel>();
```

### 4. Create Reusable Widgets
Add to `lib/widgets/reusable_widgets.dart` for UI components.

For detailed instructions, see [ARCHITECTURE.md](ARCHITECTURE.md).

---

## 🎨 Custom Widgets & Components

### Pre-built Reusable Widgets

- **ModuleCard** - Module showcase card with animations
- **CounterWidget** - Interactive counter with increment/decrement
- **ControlButton** - Control button with icon animations
- **ValueDisplay** - Value with description display

Usage:
```dart
import 'widgets/reusable_widgets.dart';

ModuleCard(
  title: 'My Feature',
  icon: Icons.star,
  backgroundColor: Colors.blue,
  child: Text('Content here'),
)
```

---

## 📦 Dependencies

Key packages used:
- **flutter_animate**: Smooth animations
- **flutter_m3shapes_extended**: Custom M3 shapes
- **m3e_collection**: Material 3 components
- **youtube_player_iframe**: YouTube integration
- **get_it**: Dependency injection
- **shared_preferences**: Local storage
- **google_fonts**: Typography

See [pubspec.yaml](pubspec.yaml) for complete list.

---

## 🔒 Privacy & Security

### Local Configuration

Sensitive data should NEVER be committed:

1. **.env.local** - Personal configurations (in `.gitignore`)
2. **Certificates** - Signing keys (in `.gitignore`)
3. **API Keys** - Backend credentials (in `.gitignore`)
4. **Developer Info** - Personal data (in `.gitignore`)

See [.env.example](.env.example) for reference.

---

## ✅ Code Quality

### Analysis
```bash
flutter analyze
```

### Testing
```bash
flutter test
```

### Formatting
```bash
dart format .
```

---

## 🐛 Troubleshooting

### Build Issues

**Android build fails:**
```bash
cd android && ./gradlew clean && cd ..
flutter clean
flutter pub get
flutter run
```

**iOS build fails:**
```bash
cd ios && rm -rf Pods Podfile.lock && cd ..
flutter clean
flutter pub get
flutter run
```

### YouTube Player Not Loading

Check:
1. Internet connectivity
2. Video ID is valid
3. YouTube allows embedding in your region

---

## 📄 License

This project is licensed under the **MIT License** - see [LICENSE](LICENSE) file for details.

You are free to use this code for:
- ✅ Commercial projects
- ✅ Derivative works
- ✅ Private use
- ✅ Educational purposes

---

## 👥 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📞 Support & Issues

Found a bug? Have a suggestion?

- Open an [Issue](https://github.com/yourusername/m3e_explosion/issues)
- Check existing documentation
- Review [ARCHITECTURE.md](ARCHITECTURE.md) for implementation details

---

## 🎓 Learning Resources

This project demonstrates:
- Modern Flutter architecture patterns
- Material Design 3 best practices
- Dependency injection with GetIt
- MVVM pattern implementation
- Reusable component design
- Professional code organization

Perfect for learning Flutter architecture!

---

## 🚀 Next Steps

- [x] Architecture implemented
- [x] Reusable components created
- [ ] Add unit tests
- [ ] Add integration tests
- [ ] Add more modules
- [ ] Deploy to stores

---

## 📱 Screenshots

*Add screenshots of your app here*

---

## 🙏 Acknowledgments

- Material Design 3 Documentation
- Flutter Community
- Package contributors (flutter_animate, M3E components, etc.)

---

**Happy coding! 🎉**

Made with ❤️ using Flutter & Material Design 3
