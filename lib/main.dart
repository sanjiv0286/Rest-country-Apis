import 'package:countries/View/country_list.dart';
import 'package:countries/ViewModel/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ThemeMode currentThemeMode = ThemeMode.light;

    return ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: GetMaterialApp(
        themeMode: currentThemeMode,
        theme: ThemeData.light(), // Define your light theme
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Countries App',
        home: const CountryListScreen(),
      ),
    );
  }
}
