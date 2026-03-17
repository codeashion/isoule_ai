class OnboardingData {
  final String image;
  final String tag;
  final String title;
  final String description;
  final List<String> features;

  OnboardingData({
    required this.image,
    required this.tag,
    required this.title,
    required this.description,
    required this.features,
  });
}

final onboardingList = [
  OnboardingData(
    image: "assets/images/onboarding1.svg",
    tag: "END-TO-END ENCRYPTED",
    title: "Secure Memory Vault",
    description:
        "Your digital life, protected. Store moments and thoughts in a private space that only you can access.",
    features: [
      "Military-grade encryption for all data",
      "AI reflection without compromising privacy",
    ],
  ),
  OnboardingData(
    image: "assets/images/onboarding2.svg",
    tag: "PERSONAL AI INSIGHTS",
    title: "Deep Reflection",
    description:
        "Let AI help you connect the dots. Discover patterns in your thoughts and revisit moments with clarity.",
    features: [
      "Daily prompts to spark mindfulness",
      "Contextual memory retrieval",
    ],
  ),
  OnboardingData(
    image: "assets/images/onboarding3.svg",
    tag: "SECURE BY DESIGN",
    title: "Secure by Design",
    description: "Your digital sanctuary is built on three pillars of privacy.",
    features: [
      "Military-Grade Encryption",
      "On-Device Processing",
      "Biometric Lock",
    ],
  ),
];
