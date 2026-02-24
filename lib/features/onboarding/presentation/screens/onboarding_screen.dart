// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:isoule_ai/core/constants/app_colors.dart';
// import 'package:isoule_ai/core/constants/onboarding_data.dart';
// import 'package:isoule_ai/features/onboarding/presentation/blocs/onboarding_bloc.dart';
// import 'package:isoule_ai/features/onboarding/presentation/blocs/onboarding_event.dart';
// import 'package:isoule_ai/features/onboarding/presentation/blocs/onboarding_state.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final PageController controller = PageController();

//     return BlocProvider(
//       create: (_) => OnboardingBloc(),
//       child: Scaffold(
//         backgroundColor: kBackground,
//         body: SafeArea(
//           child: BlocBuilder<OnboardingBloc, OnboardingState>(
//             builder: (context, state) {
//               return Column(
//                 children: [
//                   /// Top bar
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 16,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "ISOULE",
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),

//                         TextButton(
//                           onPressed: () {
//                             controller.jumpToPage(2);
//                           },
//                           child: const Text("Skip"),
//                         ),
//                       ],
//                     ),
//                   ),

//                   /// Pages
//                   Expanded(
//                     child: PageView.builder(
//                       controller: controller,
//                       itemCount: onboardingList.length,
//                       onPageChanged: (index) {
//                         context.read<OnboardingBloc>().add(
//                           PageChangedEvent(index),
//                         );
//                       },
//                       itemBuilder: (context, index) {
//                         final item = onboardingList[index];

//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 24),
//                           child: Column(
//                             children: [
//                               const SizedBox(height: 20),

//                               SvgPicture.asset(
//                                 item.image,
//                                 height: 240,
//                                 width: double.infinity,
//                                 fit: BoxFit.contain,
//                               ),

//                               const SizedBox(height: 24),

//                               Container(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 14,
//                                   vertical: 6,
//                                 ),
//                                 decoration: BoxDecoration(
//                                   color: kComponentBackground,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: Text(item.tag),
//                               ),

//                               const SizedBox(height: 16),

//                               Text(
//                                 item.title,
//                                 style: Theme.of(
//                                   context,
//                                 ).textTheme.headlineMedium,
//                                 textAlign: TextAlign.center,
//                               ),

//                               const SizedBox(height: 12),

//                               Text(
//                                 item.description,
//                                 textAlign: TextAlign.center,
//                               ),

//                               const SizedBox(height: 24),

//                               ...item.features.map(
//                                 (e) => Container(
//                                   margin: const EdgeInsets.only(bottom: 12),
//                                   padding: const EdgeInsets.all(14),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: kGraySubTitle),
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       const Icon(Icons.check),
//                                       const SizedBox(width: 10),
//                                       Expanded(child: Text(e)),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),

//                   /// Indicator
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       onboardingList.length,
//                       (index) => Container(
//                         margin: const EdgeInsets.symmetric(horizontal: 4),
//                         width: state.currentPage == index ? 20 : 6,
//                         height: 6,
//                         decoration: BoxDecoration(
//                           color: state.currentPage == index
//                               ? kButtonColor
//                               : kComponentBackground,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   /// Button
//                   Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           if (state.currentPage == 2) {
//                             /// Navigate to next screen
//                             /// Navigator.pushReplacement(...)
//                           } else {
//                             controller.nextPage(
//                               duration: const Duration(milliseconds: 300),
//                               curve: Curves.ease,
//                             );
//                           }
//                         },
//                         child: Text(
//                           state.currentPage == 2
//                               ? "Enable Security"
//                               : state.currentPage == 1
//                               ? "Next"
//                               : "Get Started",
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// new code

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/core/constants/onboarding_data.dart';
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

  void _nextPage(int currentPage) {
    if (currentPage == onboardingList.length - 1) {
      /// TODO: Navigate to Login / Enable Security
      /// Example:
      /// Navigator.pushReplacementNamed(context, '/login');
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
                          child: Column(
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
                            ],
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
