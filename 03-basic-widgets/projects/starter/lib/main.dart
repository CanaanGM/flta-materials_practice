import 'package:flutter/material.dart';
import 'home.dart';
import 'constants.dart';

void main() {
  // 1
  runApp(const Yummy());
}

class Yummy extends StatefulWidget {
  // 2
  const Yummy({super.key});

  @override
  State<Yummy> createState() => _YummyState();
}

class _YummyState extends State<Yummy> {
  ThemeMode themeMode = ThemeMode.light;
  ColorSelection colorSelected = ColorSelection.pink;
  //3
  void changeThemeMode(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void changeColor(int value) {
    setState(() {
      colorSelected = ColorSelection.values[value];
    });
  }

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Yummy';

    return MaterialApp(
        title: appTitle,
        debugShowCheckedModeBanner: false, // Uncomment to remove Debug banner

        themeMode: themeMode,
        theme: ThemeData(
          colorSchemeSeed: colorSelected.color,
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          colorSchemeSeed: colorSelected.color,
          useMaterial3: true,
          brightness: Brightness.dark,
        ),

        // 4
        home: Home(
          changeColor: changeColor,
          changeTheme: changeThemeMode,
          colorSelected: colorSelected,
        ));
  }
}
