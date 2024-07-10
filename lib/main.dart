import 'package:comms_hub_app/app_routes.dart';
import 'package:comms_hub_app/feature/presentation/pages/home_screen/home_screen.dart';
import 'package:comms_hub_app/feature/presentation/pages/media_screen/media_screen.dart';
import 'package:flutter/material.dart';

import 'feature/presentation/pages/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Communication Hub',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: _registerRoutes(),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    AppRoutes.splash: (context) => const SplashScreen(),
    AppRoutes.homeScreen: (context) => const HomeScreen(),
    AppRoutes.mediaScreen: (context) => const MediaScreen()
  };
}
