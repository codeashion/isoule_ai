import 'package:flutter/material.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';

class ManageStorageScreen extends StatelessWidget {
  const ManageStorageScreen({super.key});

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
          "Storage",
          style: TextStyle(color: kTitleTextColor, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            /// Total Used
            const Center(
              child: Text(
                "45.5 GB",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: kTitleTextColor,
                ),
              ),
            ),

            const SizedBox(height: 4),

            const Center(
              child: Text(
                "Used of 64 GB",
                style: TextStyle(color: kGraySubTitle, fontSize: 14),
              ),
            ),

            const SizedBox(height: 20),

            /// Total Storage Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                minHeight: 10,
                value: 45.5 / 64,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(kButtonColor),
              ),
            ),

            const SizedBox(height: 30),

            /// Storage Items
            _storageItem(
              icon: Icons.image_outlined,
              title: "Photos",
              value: "22.4 GB",
              progress: 0.7,
            ),

            const SizedBox(height: 14),

            _storageItem(
              icon: Icons.videocam_outlined,
              title: "Videos",
              value: "12.1 GB",
              progress: 0.45,
            ),

            const SizedBox(height: 14),

            _storageItem(
              icon: Icons.description_outlined,
              title: "Documents",
              value: "6.2 GB",
              progress: 0.25,
            ),

            const SizedBox(height: 14),

            _storageItem(
              icon: Icons.memory_outlined,
              title: "System",
              value: "4.8 GB",
              progress: 0.15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _storageItem({
    required IconData icon,
    required String title,
    required String value,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: kComponentBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          /// Icon box
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: kTitleTextColor),
          ),

          const SizedBox(width: 14),

          /// Title + Progress
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: kTitleTextColor,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: Colors.grey.shade300,
                    valueColor: const AlwaysStoppedAnimation(kButtonColor),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          /// Value
          Text(
            value,
            style: const TextStyle(
              color: kGraySubTitle,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
