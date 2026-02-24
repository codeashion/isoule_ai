import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/onboarding/presentation/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  void _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OnboardingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 3),

            /// Logo
            SvgPicture.asset('assets/icons/app_icon.svg'),

            /// App Name
            Text(
              "ISOULE",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 8),

            /// Subtitle
            Text(
              "YOUR SECURE MEMORY VAULT",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontSize: 13,
                letterSpacing: 1.5,
                color: kGraySubTitle,
              ),
            ),

            const Spacer(flex: 4),

            /// Bottom dots indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dot(isActive: false),
                _dot(isActive: true),
                _dot(isActive: false),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _dot({required bool isActive}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: isActive ? kGraySubTitle : kComponentBackground,
        shape: BoxShape.circle,
      ),
    );
  }
}
