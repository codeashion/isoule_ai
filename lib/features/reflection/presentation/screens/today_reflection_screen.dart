import 'package:flutter/material.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';

class TodayReflectionScreen extends StatefulWidget {
  const TodayReflectionScreen({super.key});

  @override
  State<TodayReflectionScreen> createState() => _TodayReflectionScreenState();
}

class _TodayReflectionScreenState extends State<TodayReflectionScreen> {
  final _controller = TextEditingController();
  int _selectedMood = 2;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveEntry() {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Reflection saved (demo)')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        foregroundColor: kTitleTextColor,
        elevation: 0,
        leading: BackButton(color: kTitleTextColor),
        title: Text(
          'What is one small win you celebrated today?',
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How are you feeling?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: kGraySubTitle,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  final icons = [
                    Icons.sentiment_very_dissatisfied,
                    Icons.sentiment_dissatisfied,
                    Icons.sentiment_satisfied,
                    Icons.sentiment_satisfied_alt,
                    Icons.favorite,
                  ];
                  return GestureDetector(
                    onTap: () => setState(() {
                      _selectedMood = index;
                    }),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _selectedMood == index
                            ? kButtonColor
                            : kComponentBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icons[index],
                        color: _selectedMood == index
                            ? Colors.white
                            : kGraySubTitle,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText:
                        'Start writing your reflection here...'
                        ' (optional)',
                    filled: true,
                    fillColor: kComponentBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _saveEntry,
                  child: const Text('Save Entry'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
