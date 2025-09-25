import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheger_ride/views/login_view.dart';
import 'package:sheger_ride/views/dashboard_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _scale = 0.6;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 0.8;
        _scale = 1.4;
      });

      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          _scale = 1.0;
        });
      });
    });

    Future.delayed(const Duration(milliseconds: 3500), () async {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
      if (isLoggedIn) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001922),
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: AnimatedScale(
            scale: _scale,
            duration: const Duration(seconds: 2),
            curve: Curves.easeOutBack,
            child: Image.asset('assets/images/sheger_logo.png', width: 220),
          ),
        ),
      ),
    );
  }
}
