import 'package:flutter/material.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/login/presentation/screens/login_screen.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: kTitleTextColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            /// Warning Icon
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 36,
              ),
            ),

            const SizedBox(height: 24),

            /// Title
            const Text(
              "Delete your account?",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: kTitleTextColor,
              ),
            ),

            const SizedBox(height: 10),

            /// Description
            const Text(
              "This action cannot be undone. All your data will be permanently removed from our servers.",
              textAlign: TextAlign.center,
              style: TextStyle(color: kGraySubTitle, fontSize: 14, height: 1.5),
            ),

            const SizedBox(height: 30),

            /// Lose Access Container
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kComponentBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "YOU WILL LOSE ACCESS TO",
                    style: TextStyle(
                      color: kGraySubTitle,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                    ),
                  ),

                  SizedBox(height: 14),

                  _LoseItem(
                    icon: Icons.person_outline,
                    text: "Profile details and preferences",
                  ),

                  SizedBox(height: 10),

                  _LoseItem(
                    icon: Icons.history,
                    text: "Past reflection history",
                  ),

                  SizedBox(height: 10),

                  _LoseItem(
                    icon: Icons.bar_chart_outlined,
                    text: "Usage statistics and streaks",
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// Delete Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(.12),
                  foregroundColor: Colors.red,
                  elevation: 0,
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text(
                  "Delete Account",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// Cancel Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kButtonColor),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _LoseItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _LoseItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: kGraySubTitle),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: kTitleTextColor, fontSize: 14),
          ),
        ),
      ],
    );
  }
}
