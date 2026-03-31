import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:sahab/core/helpers/app_constants.dart';
import 'package:sahab/core/helpers/shared_pref_helper.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial()) {
    loadSavedLanguage();
  }

  bool? isArabic;

  Future<void> loadSavedLanguage() async {
    // Check if this is the first time the app is launched
    bool hasLanguagePreference = await SharedPrefHelper.containsKey(
      AppConstants.isArabic,
    );

    if (hasLanguagePreference) {
      // User has previously set a language preference
      isArabic = await SharedPrefHelper.getBool(AppConstants.isArabic);
    } else {
      // First launch - default to Arabic and save this preference
      isArabic = true;
      await SharedPrefHelper.setData(AppConstants.isArabic, true);
    }

    emit(LanguageChanged(isArabic!));
  }

  String get locale => (isArabic ?? true) ? "ar" : "en";

  void toggleLanguage() async {
    isArabic = !isArabic!;
    await SharedPrefHelper.setData(AppConstants.isArabic, isArabic);
    emit(LanguageChanged(isArabic!));
  }
}
