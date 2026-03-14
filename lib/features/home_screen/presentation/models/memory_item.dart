enum MemoryType { text, voice, image }

class MemoryItem {
  final String title;
  final String subtitle;
  final MemoryType type;

  const MemoryItem({
    required this.title,
    required this.subtitle,
    this.type = MemoryType.text,
  });
}
