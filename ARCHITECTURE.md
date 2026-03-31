# Sahab Weather App - Clean Architecture

A premium weather application built with Flutter using Clean Architecture principles.

## 🏗️ Project Architecture

This project follows **Clean Architecture** with a modular feature-based structure:

```
lib/
├── core/                          # Shared core components
│   ├── cubit/                     # Global cubits (connection, language)
│   ├── di/                        # Dependency injection
│   ├── functions/                 # App initialization
│   ├── helpers/                   # Utilities and extensions
│   ├── networking/                # API networking layer
│   ├── routes/                    # Navigation/routing
│   ├── services/                  # Shared services
│   ├── theme/                     # App theming
│   └── widgets/                   # Shared widgets
│
├── features/                      # Feature modules
│   ├── alerts/                    # Weather alerts feature
│   │   ├── data/
│   │   │   ├── api/              # API services
│   │   │   ├── datasources/      # Remote data sources
│   │   │   ├── models/           # Data models
│   │   │   └── repositories/   # Repository implementations
│   │   ├── domain/
│   │   │   ├── entities/         # Domain entities
│   │   │   ├── repositories/     # Repository contracts
│   │   │   └── usecases/         # Use cases
│   │   └── presentation/
│   │       ├── cubit/            # State management
│   │       └── screens/          # UI screens
│   │
│   ├── radar/                     # Weather radar feature
│   │   ├── data/
│   │   │   ├── api/
│   │   │   ├── datasource/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repository/
│   │   │   └── usecases/
│   │   ├── cubit/
│   │   ├── presentation/
│   │   └── ui/
│   │
│   ├── search/                    # Location search feature ⭐ NEW
│   │   ├── data/
│   │   │   ├── api/              # SearchApiService
│   │   │   ├── models/           # LocationSuggestionModel
│   │   │   └── repositories/     # SearchRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/         # LocationSuggestion
│   │   │   ├── repositories/     # SearchRepository contract
│   │   │   └── usecases/         # SearchLocationsUseCase, SearchHistoryUseCases
│   │   └── presentation/
│   │       ├── cubit/            # SearchCubit
│   │       └── screens/          # SearchView
│   │
│   ├── settings/                  # App settings feature ⭐ NEW
│   │   ├── data/
│   │   │   └── repositories/     # SettingsRepositoryImpl
│   │   ├── domain/
│   │   │   ├── entities/         # UserSettings
│   │   │   ├── repositories/     # SettingsRepository contract
│   │   │   └── usecases/         # (Can be added as needed)
│   │   └── presentation/
│   │       ├── cubit/            # SettingsCubit
│   │       └── screens/          # SettingsView, LanguageView, PrivacyView
│   │
│   └── weather/                   # Weather data feature
│       ├── cubit/
│       ├── data/
│       │   ├── apis/
│       │   ├── datasources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── screens/
│           └── widgets/
│
├── generated/                     # Generated localization files
│   ├── intl/
│   └── l10n.dart
│
├── l10n/                          # Localization ARB files
│   ├── intl_en.arb
│   └── intl_ar.arb
│
├── main.dart                      # App entry point
└── my_app.dart                    # App configuration
```

## 🧩 Clean Architecture Layers

### 1. **Presentation Layer**
- **Widgets/Screens**: UI components
- **Cubit/Bloc**: State management
- Depends on: Domain layer

### 2. **Domain Layer**
- **Entities**: Core business objects
- **Repository Contracts**: Abstract repository interfaces
- **Use Cases**: Business logic operations
- **Independent of any framework**

### 3. **Data Layer**
- **Repository Implementations**: Concrete repository implementations
- **Data Sources**: API services, local database
- **Models**: DTOs with serialization logic
- Depends on: Domain layer

## 🔧 Dependency Injection

Using **GetIt** for dependency injection:

```dart
// API Services
gitIt.registerLazySingleton<WeatherApiService>(...);
gitIt.registerLazySingleton<SearchApiService>(...);

// Repositories
gitIt.registerLazySingleton<WeatherRepository>(...);
gitIt.registerLazySingleton<SearchRepository>(...);

// Use Cases
gitIt.registerLazySingleton<GetWeatherUseCase>(...);
gitIt.registerLazySingleton<SearchLocationsUseCase>(...);

// Cubits
gitIt.registerFactory<WeatherCubit>(...);
gitIt.registerFactory<SearchCubit>(...);
```

## 🌍 Localization

Using **flutter_intl** for internationalization:
- English (en)
- Arabic (ar) with RTL support

Generate localization files:
```bash
flutter pub run intl_utils:generate
```

## 🧪 Testing

Test files are organized by feature:
```
test/
└── features/
    └── weather/
        ├── data/
        ├── domain/
        └── presentation/
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK ^3.11.1
- Dart SDK

### Installation
```bash
# Clone the repository
git clone https://github.com/mohamedabdelnabii/sahab_app.git

# Navigate to project
cd sahab_app

# Install dependencies
flutter pub get

# Generate code files
flutter pub run build_runner build --delete-conflicting-outputs

# Generate localization
flutter pub run intl_utils:generate

# Run the app
flutter run
```

### Build Commands
```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📝 Commit History

1. **Initial clean architecture refactor**
   - Organized features with proper Clean Architecture structure
   - Separated UI, Cubit/Bloc, and API logic
   - Added domain layer with entities, repositories, and use cases
   - Added data layer with API services, models, and repository implementations
   - Fixed all imports and compilation errors
   - Added proper dependency injection
   - Configured flutter intl for localization

## 📦 Key Dependencies

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management |
| dio | HTTP client |
| retrofit | Type-safe HTTP client |
| get_it | Dependency injection |
| freezed | Immutable classes |
| json_serializable | JSON serialization |
| go_router | Navigation |
| flutter_map | Map visualization |
| intl | Internationalization |
| shared_preferences | Local storage |
| hive_ce | NoSQL database |
| connectivity_plus | Network state |
| geolocator | Location services |

## 📄 License

This project is private and proprietary.

---

## 🎯 Features Implemented

- ✅ Clean Architecture with modular features
- ✅ Dependency Injection with GetIt
- ✅ State Management with Cubit/Bloc
- ✅ Localization (English & Arabic)
- ✅ Weather data with hourly/weekly forecasts
- ✅ Location search with history
- ✅ Weather alerts
- ✅ Weather radar with map visualization
- ✅ Settings management (units, theme, language)
- ✅ Offline support with caching
- ✅ RTL support for Arabic

## 🔮 Future Improvements

- [ ] Add more comprehensive tests
- [ ] Add error boundary widget
- [ ] Implement deep linking
- [ ] Add push notifications
- [ ] Implement weather widgets
