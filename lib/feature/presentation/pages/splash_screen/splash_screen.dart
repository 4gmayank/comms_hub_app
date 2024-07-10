import 'dart:async';
import 'dart:developer';

import 'package:comms_hub_app/core/conifg/navigation.dart';
import 'package:flutter/material.dart';

import '../../../../app_routes.dart';
import '../../../../core/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    log("Timer Called", name: "splash");
    _handleNavigation(AppRoutes.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 26),
        color: AppColors.white,
        child: const Center(
          child: Text("Careator"),
        ),
      ),
    );
  }

  _handleNavigation(final String route) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigation.intentWithClearAllRoutes(context, route);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
