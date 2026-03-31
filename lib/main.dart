import 'package:flutter/material.dart';
import 'core/functions/app_initializer.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.initCore();
  await AppInitializer.initRouter();
  runApp(const MyApp());
}