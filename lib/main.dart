import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sports_news_app/data/notifiers.dart';
import 'package:sports_news_app/modules/pages/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadAppSettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color _brandSeedColor = Color(0xFF43A047);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDarkMode, child) {
        final lightScheme = ColorScheme.fromSeed(
          seedColor: _brandSeedColor,
          brightness: Brightness.light,
        );
        final darkScheme = ColorScheme.fromSeed(
          seedColor: _brandSeedColor,
          brightness: Brightness.dark,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale('en', 'US'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('en', 'GB'),
          ],
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            fontFamily: 'Roboto',
            iconTheme: const IconThemeData(
              size: 24,
              fill: 0.0,
              weight: 400,
              grade: 0,
              opticalSize: 24,
            ),
            scaffoldBackgroundColor: lightScheme.surface,
            appBarTheme: AppBarTheme(
              backgroundColor: lightScheme.surface,
              foregroundColor: lightScheme.onSurface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
            ),
            cardColor: lightScheme.surface,
            dividerTheme: DividerThemeData(color: lightScheme.outlineVariant),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: lightScheme.inverseSurface,
              contentTextStyle: TextStyle(color: lightScheme.onInverseSurface),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkScheme,
            fontFamily: 'Roboto',
            iconTheme: const IconThemeData(
              size: 24,
              fill: 0.0,
              weight: 400,
              grade: 0,
              opticalSize: 24,
            ),
            scaffoldBackgroundColor: darkScheme.surface,
            appBarTheme: AppBarTheme(
              backgroundColor: darkScheme.surface,
              foregroundColor: darkScheme.onSurface,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
            ),
            cardColor: darkScheme.surface,
            dividerTheme: DividerThemeData(color: darkScheme.outlineVariant),
            snackBarTheme: SnackBarThemeData(
              backgroundColor: darkScheme.inverseSurface,
              contentTextStyle: TextStyle(color: darkScheme.onInverseSurface),
            ),
          ),
          home: const WelcomePage(),
        );
      },
    );
  }
}
