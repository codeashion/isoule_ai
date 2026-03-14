import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';

class AiChatScreen extends StatelessWidget {
  const AiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _AiChatBloc(),
      child: const _AiChatView(),
    );
  }
}

class _AiChatView extends StatelessWidget {
  const _AiChatView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'AI Chat',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            'Ask the assistant anything about your memories.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: BlocBuilder<_AiChatBloc, _AiChatState>(
              builder: (context, state) {
                if (state.messages.isEmpty) {
                  return Center(
                    child: Text(
                      'Start the conversation by sending a message.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: kGraySubTitle),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: state.messages.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final message = state.messages[index];
                    return Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: message.isUser
                              ? kButtonColor
                              : kComponentBackground,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          message.text,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: message.isUser
                                    ? Colors.white
                                    : kTitleTextColor,
                              ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const _AiChatInput(),
        ],
      ),
    );
  }
}

class _AiChatInput extends StatefulWidget {
  const _AiChatInput();

  @override
  State<_AiChatInput> createState() => _AiChatInputState();
}

class _AiChatInputState extends State<_AiChatInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<_AiChatBloc>().add(_AiChatMessageSent(text));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: kComponentBackground,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask something...',
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _send(),
            ),
          ),
          IconButton(
            onPressed: _send,
            icon: const Icon(Icons.send),
            color: kButtonColor,
          ),
        ],
      ),
    );
  }
}

class _AiChatMessage {
  final String text;
  final bool isUser;

  _AiChatMessage({required this.text, required this.isUser});
}

class _AiChatState {
  final List<_AiChatMessage> messages;

  const _AiChatState({required this.messages});

  _AiChatState copyWith({List<_AiChatMessage>? messages}) {
    return _AiChatState(messages: messages ?? this.messages);
  }
}

abstract class _AiChatEvent {}

class _AiChatMessageSent extends _AiChatEvent {
  final String text;

  _AiChatMessageSent(this.text);
}

class _AiChatBloc extends Bloc<_AiChatEvent, _AiChatState> {
  _AiChatBloc() : super(const _AiChatState(messages: [])) {
    on<_AiChatMessageSent>((event, emit) {
      final updated = List<_AiChatMessage>.from(state.messages)
        ..add(_AiChatMessage(text: event.text, isUser: true))
        ..add(
          _AiChatMessage(
            text: 'This is a placeholder response.',
            isUser: false,
          ),
        );
      emit(state.copyWith(messages: updated));
    });
  }
}
