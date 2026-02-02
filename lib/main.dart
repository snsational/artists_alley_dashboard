import 'package:artists_alley_dashboard/firebase_options.dart';
import 'package:artists_alley_dashboard/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  WidgetsFlutterBinding.ensureInitialized();

  final delegate = await LocalizationDelegate.create(
    fallbackLocale: 'en',
    supportedLocales: const ['en', 'pt'],
    basePath: 'i18n',
  );

  runApp(OverlaySupport.global(child: LocalizedApp(delegate, const App())));
}
