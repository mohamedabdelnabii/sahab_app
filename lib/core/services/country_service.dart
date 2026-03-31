import 'dart:async';

import 'package:sahab/core/helpers/app_constants.dart';
import 'package:sahab/core/helpers/shared_pref_helper.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:flutter/foundation.dart';

/// Provides a single source of truth for the current country selection/detection.
///
/// Resolution order:
/// 1) Return saved country if exists (SharedPreferences)
/// 2) Try detect by device radar (geolocator + geocoding)
/// 3) Fallback to "SA" (Saudi Arabia)
///
/// Detection result is persisted immediately so other widgets can reuse it.
class CountryService {
  // In-memory cache for quick access within app session
  String? _memoryCountryCode;

  // Deduplicate concurrent detection calls
  Future<String>? _inFlight;

  /// Returns the two-letter ISO country code (e.g., "SA").
  Future<String> getCountry() async {
    // 1) Memory cache
    final mem = _memoryCountryCode;
    if (mem != null && mem.isNotEmpty) return mem;

    // 2) SharedPreferences
    final saved = await SharedPrefHelper.getString(
      AppConstants.prefsCountryCode,
    );
    if (saved.isNotEmpty) {
      _memoryCountryCode = saved.toUpperCase();
      return _memoryCountryCode!;
    }

    // 3) Detect once per concurrent callers
    _inFlight ??= _detectAndPersist();
    final detected = await _inFlight!;
    _inFlight = null; // allow future re-detection if cleared
    return detected;
  }

  /// Persists the given country code immediately and updates memory cache.
  Future<void> setCountry(String countryCode) async {
    final code = countryCode.toUpperCase();
    _memoryCountryCode = code;
    // cancel any ongoing detection result propagation
    _inFlight = null;
    await SharedPrefHelper.setData(AppConstants.prefsCountryCode, code);
  }

  /// Clears any stored country so a fresh detection will happen next time.
  Future<void> clearCountry() async {
    _memoryCountryCode = null;
    _inFlight = null;
    await SharedPrefHelper.removeData(AppConstants.prefsCountryCode);
  }

  Future<String> _detectAndPersist() async {
    final code = await _detectCountryByLocation() ?? _defaultCountryCode;
    await setCountry(code);
    return code;
  }

  static const String _defaultCountryCode = 'SA';

  Future<String?> _detectCountryByLocation() async {
    try {
      // Ensure services are enabled
      final serviceEnabled =
          await geolocator.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (kDebugMode) {
          print('[CountryService] Location services disabled');
        }
        return null;
      }

      // Permissions
      var permission = await geolocator.Geolocator.checkPermission();
      if (permission == geolocator.LocationPermission.denied) {
        permission = await geolocator.Geolocator.requestPermission();
      }
      if (permission == geolocator.LocationPermission.denied ||
          permission == geolocator.LocationPermission.deniedForever) {
        if (kDebugMode) {
          print('[CountryService] Location permission denied');
        }
        return null;
      }

      // Position with low accuracy is enough for country resolution
      final position = await geolocator.Geolocator.getCurrentPosition(
        locationSettings: const geolocator.LocationSettings(
          accuracy: geolocator.LocationAccuracy.low,
        ),
      ).timeout(const Duration(seconds: 10));

      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final iso = placemarks.first.isoCountryCode;
        if (iso != null && iso.isNotEmpty) {
          return iso.toUpperCase();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('[CountryService] Detection error: $e');
      }
    }
    return null;
  }
}
