import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/core/constants/onboarding_data.dart';
import 'package:isoule_ai/features/login/presentation/screens/login_screen.dart';
import 'package:isoule_ai/features/onboarding/presentation/blocs/onboarding_bloc.dart';
import 'package:isoule_ai/features/onboarding/presentation/blocs/onboarding_event.dart';
import 'package:isoule_ai/features/onboarding/presentation/blocs/onboarding_state.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildFeatureRow({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: kComponentBackground,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kButtonColor, size: 20),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: kGraySubTitle),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage(int currentPage) {
    if (currentPage == onboardingList.length - 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void _skip() {
    _controller.jumpToPage(onboardingList.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        backgroundColor: kBackground,
        body: SafeArea(
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              return Column(
                children: [
                  /// Top bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ISOULE",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        TextButton(onPressed: _skip, child: const Text("Skip")),
                      ],
                    ),
                  ),

                  /// Pages
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: onboardingList.length,
                      onPageChanged: (index) {
                        context.read<OnboardingBloc>().add(
                          PageChangedEvent(index),
                        );
                      },
                      itemBuilder: (context, index) {
                        final item = onboardingList[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),

                                SvgPicture.asset(item.image, height: 240),

                                const SizedBox(height: 24),

                                /// Tag
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kComponentBackground,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    item.tag,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                /// Title
                                Text(
                                  item.title,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 12),

                                /// Description
                                Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),

                                const SizedBox(height: 24),

                                /// Features
                                if (index == 2) ...[
                                  // Special layout for the third onboarding screen
                                  _buildFeatureRow(
                                    icon: Icons.shield_outlined,
                                    title: 'Military-Grade Encryption',
                                    subtitle:
                                        'AES-256 bit encryption ensures only you hold the keys to your memories.',
                                  ),
                                  _buildFeatureRow(
                                    icon: Icons.smartphone_outlined,
                                    title: 'On-Device Processing',
                                    subtitle:
                                        'AI reflections are generated locally. Your data never leaves your phone.',
                                  ),
                                  _buildFeatureRow(
                                    icon: Icons.fingerprint,
                                    title: 'Biometric Lock',
                                    subtitle:
                                        'Secure your vault with FaceID or Fingerprint for instant access.',
                                  ),
                                ] else
                                  ...item.features.map(
                                    (feature) => Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: kGraySubTitle.withOpacity(0.4),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            color: kButtonColor,
                                            size: 20,
                                          ),

                                          const SizedBox(width: 12),

                                          Expanded(child: Text(feature)),
                                        ],
                                      ),
                                    ),
                                  ),

                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingList.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: state.currentPage == index ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: state.currentPage == index
                              ? kButtonColor
                              : kComponentBackground,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Bottom Button
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _nextPage(state.currentPage),
                        child: Text(
                          state.currentPage == onboardingList.length - 1
                              ? "Enable Security"
                              : state.currentPage == 1
                              ? "Next"
                              : "Get Started",
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
