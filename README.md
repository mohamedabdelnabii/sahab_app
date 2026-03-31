# Sahab - Premium Weather Experience

**Sahab** is a feature-rich, premium weather application built with Flutter. It combines real-time weather analytics with advanced interactive satellite radar, all wrapped in a modern Glassmorphic UI.

---

## 🌟 Key Features

### 📡 Advanced Satellite Radar
- **Multi-Layer Support**: Switch between **Rain** (Radar) and **Clouds** (Infrared Satellite) views.
- **Interactive Map**: High-resolution satellite imagery with detailed geographic boundaries and labels.
- **Dynamic Playback**: Smooth animation of weather patterns through past data and future predictions (nowcast).
- **City Identification**: Automatically centers on your selected location with a dynamic pulsing marker showing city name and temperature.
- **Full Control**: Timeline slider to scrub through weather frames and manual zoom controls.

### 🌤️ Comprehensive Weather Data
- **Real-time Updates**: Current conditions including temperature, humidity, wind speed, UV index, and pressure.
- **7-Day Forecast**: Detailed daily projections.
- **Hourly Breakdowns**: Precision tracking of temperature and conditions throughout the day.
- **Smart Analytics**: Summaries like "Humidity making it feel warmer" or "Wind making it feel colder."

### 🎨 Premium UI/UX
- **Glassmorphism Design**: Elegant, translucent interfaces that adapt to the weather background.
- **Dark Mode Optimized**: High-contrast dark themes for better visibility of radar and satellite layers.
- **Smooth Animations**: Integrated Lottie animations and custom-painted radar effects.
- **Localized**: Full support for **English** and **Arabic** languages.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [Cubit (Flutter BLoC)](https://pub.dev/packages/flutter_bloc)
- **Networking**: [Dio](https://pub.dev/packages/dio)
- **Dependency Injection**: [GetIt](https://pub.dev/packages/get_it)
- **Mapping**: [Flutter Map](https://pub.dev/packages/flutter_map)
- **APIs**:
  - [WeatherAPI](https://www.weatherapi.com/) for meteorological data.
  - [RainViewer](https://www.rainviewer.com/api.html) for radar/satellite imagery.
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Storage**: [Hive CE](https://pub.dev/packages/hive_ce) & [Shared Preferences](https://pub.dev/packages/shared_preferences)

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (Latest stable version)
- A WeatherAPI key (stored in `ApiConstants`)

### Installation
1. **Clone the repository**:
   ```bash
   git clone https://github.com/https://github.com/mohamedabdelnabii/sahab_app.git
   ```
2. **Fetch dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run build runner** (for Freezed/JSON models):
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
4. **Launch the app**:
   ```bash
   flutter run
   ```

---

## 📜 License
© 2026 Sahab Weather Team. All rights reserved.
