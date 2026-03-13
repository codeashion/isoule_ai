import 'package:flutter/material.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/dashboard/presentation/models/memory_item.dart';

class AddMemoryScreen extends StatefulWidget {
  const AddMemoryScreen({super.key});

  @override
  State<AddMemoryScreen> createState() => _AddMemoryScreenState();
}

class _AddMemoryScreenState extends State<AddMemoryScreen> {
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _titleController.text.trim();
    final details = _detailsController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title for the memory.')),
      );
      return;
    }

    Navigator.of(context).pop(
      MemoryItem(
        title: title,
        subtitle: details.isEmpty ? 'Just now' : details,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kBackground,
        foregroundColor: kTitleTextColor,
        elevation: 0,
        title: const Text('New Memory'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What’s on your mind today?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter a title',
                  filled: true,
                  fillColor: kComponentBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: _detailsController,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: 'Add details...',
                    filled: true,
                    fillColor: kComponentBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _save,
                  child: const Text('Save Memory'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
