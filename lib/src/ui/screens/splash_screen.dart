import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Rounded square icon background with SVG inside
                    Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: kButtonColor,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: SvgPicture.asset('assets/icons/app_icon.svg'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'ISOULE',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'YOUR SECURE MEMORY VAULT',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            // Bottom page dots
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _dot(active: false),
                  const SizedBox(width: 8),
                  _dot(active: false),
                  const SizedBox(width: 8),
                  _dot(active: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot({required bool active}) {
    return Container(
      width: active ? 8 : 6,
      height: active ? 8 : 6,
      decoration: BoxDecoration(
        color: active
            ? kButtonColor.withOpacity(0.9)
            : kGraySubTitle.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
