import 'package:flutter/material.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';

class TimelineDetailScreen extends StatelessWidget {
  const TimelineDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: kTitleTextColor),
        ),
        title: const Text(
          "Memory",
          style: TextStyle(color: kTitleTextColor, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_horiz, color: kTitleTextColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// Date
            const Center(
              child: Text(
                "WEDNESDAY, OCT 18 • 4:32 PM",
                style: TextStyle(
                  color: kGraySubTitle,
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// Image Card
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                "assets/images/memory_sample.jpg",
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            /// Audio Player
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: kComponentBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  /// Play Button
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: kButtonColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white),
                  ),

                  const SizedBox(width: 12),

                  /// Fake waveform
                  Expanded(
                    child: Row(
                      children: List.generate(
                        18,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          width: 3,
                          height: (index % 5 + 6) * 2,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Text(
                    "0:42",
                    style: TextStyle(
                      color: kGraySubTitle,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Memory Text
            const Text(
              "Found this quiet spot in the old district today. "
              "The rain started just as I sat down, blurring the city lights "
              "into soft amber streaks against the glass. It felt like time "
              "stopped for a moment.",
              style: TextStyle(
                color: kTitleTextColor,
                height: 1.6,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              "I was thinking about our conversation last week—how memory "
              "isn't just about preserving the past, but about understanding "
              "who we are right now. The smell of roasted beans and old books "
              "is something I want to keep forever.",
              style: TextStyle(
                color: kTitleTextColor,
                height: 1.6,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 32),

            /// Buttons Row
            Row(
              children: [
                /// Edit Button
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: kComponentBackground,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, color: kTitleTextColor),
                      label: const Text(
                        "Edit",
                        style: TextStyle(
                          color: kTitleTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                /// Delete Button
                Expanded(
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.delete, color: Colors.red),
                      label: const Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
