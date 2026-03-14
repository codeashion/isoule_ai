import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:isoule_ai/features/reflection/presentation/blocs/reflection_bloc.dart';
import 'package:isoule_ai/features/reflection/presentation/blocs/reflection_event.dart';
import 'package:isoule_ai/features/reflection/presentation/blocs/reflection_state.dart';

class TodayReflectionScreen extends StatefulWidget {
  const TodayReflectionScreen({super.key});

  @override
  State<TodayReflectionScreen> createState() => _TodayReflectionScreenState();
}

class _TodayReflectionScreenState extends State<TodayReflectionScreen> {
  final _controller = TextEditingController();

  String get _todayLabel => DateFormat('EEEE, MMM d').format(DateTime.now());

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _saveEntry(BuildContext context, ReflectionState state) {
    if (state.reflectionText.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can save your reflection anytime.')),
      );
      return;
    }

    context.read<ReflectionBloc>().add(const ReflectionSaveRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => ReflectionBloc(),
      child: BlocConsumer<ReflectionBloc, ReflectionState>(
        listener: (context, state) {
          if (state.isSaved) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Reflection saved (demo)')),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          // Keep controller in sync with the state
          if (_controller.text != state.reflectionText) {
            _controller.text = state.reflectionText;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          }

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              leading: BackButton(color: theme.colorScheme.onBackground),
              titleSpacing: 0,
              title: Text(
                'dailyReaction',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onBackground.withOpacity(0.75),
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: theme.colorScheme.onBackground,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _todayLabel,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'What is one small win you celebrated today?',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'How are you feeling?',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.6),
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
                          onTap: () {
                            context.read<ReflectionBloc>().add(
                              ReflectionMoodSelected(index),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: state.selectedMood == index
                                  ? theme.colorScheme.primary
                                  : theme.cardColor,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              icons[index],
                              color: state.selectedMood == index
                                  ? Colors.white
                                  : theme.colorScheme.onBackground.withOpacity(
                                      0.6,
                                    ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        expands: true,
                        onChanged: (value) {
                          context.read<ReflectionBloc>().add(
                            ReflectionTextChanged(value),
                          );
                        },
                        decoration: InputDecoration(
                          hintText:
                              'Start writing your reflection here... (optional)',
                          filled: true,
                          fillColor: theme.cardColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: state.isSaving
                            ? null
                            : () => _saveEntry(context, state),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: state.isSaving
                            ? const SizedBox(
                                height: 18,
                                width: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text('Save Entry'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
