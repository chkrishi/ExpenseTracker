import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kcolorscheme1 =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 1, 221, 255));

var kdarktheme1 = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 5, 99, 125));

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); //This is to ensure locking the orientation
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown
    ],
  ).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(colorScheme: kdarktheme1),
        theme: ThemeData().copyWith(
          colorScheme: kcolorscheme1,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheme1.onPrimaryContainer,
            foregroundColor: kcolorscheme1.primaryContainer,
          ),
          cardTheme: const CardTheme().copyWith(
            color: kcolorscheme1.secondaryContainer,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kcolorscheme1.primaryContainer,
              foregroundColor: kcolorscheme1.primaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.blueGrey,
                  fontSize: 15,
                ),
              ),
        ),
        themeMode: ThemeMode.dark,
        home: const Expenses(),
      ),
    );
  });
}
