import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isoule_ai/core/constants/app_colors.dart';
import 'package:isoule_ai/features/ai_chat/presentation/blocs/ai_chat_bloc.dart';
import 'package:isoule_ai/features/ai_chat/presentation/blocs/ai_chat_event.dart';
import 'package:isoule_ai/features/ai_chat/presentation/blocs/ai_chat_state.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiChatBloc(),
      child: Scaffold(
        backgroundColor: kBackground,
        appBar: AppBar(
          backgroundColor: kBackground,
          centerTitle: true,
          title: const Text(
            "AI Companion",
            style: TextStyle(color: kTitleTextColor),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),

            /// Context Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: kComponentBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline, size: 16, color: kGraySubTitle),
                  SizedBox(width: 6),
                  Text(
                    "Context aware: Accessing recent memories",
                    style: TextStyle(fontSize: 12, color: kGraySubTitle),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// Chat List
            Expanded(
              child: BlocBuilder<AiChatBloc, AiChatState>(
                builder: (context, state) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < state.messages.length) {
                        final msg = state.messages[index];
                        return ChatBubble(
                          message: msg.message,
                          isUser: msg.isUser,
                        );
                      } else {
                        /// Typing Indicator
                        return const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Typing...",
                            style: TextStyle(color: kGraySubTitle),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),

            /// Input
            _buildInputField(context),
          ],
        ),

        /// Bottom Navigation
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          selectedItemColor: kButtonColor,
          unselectedItemColor: kGraySubTitle,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              label: "Timeline",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: "AI Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: kComponentBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (_controller.text.trim().isEmpty) return;

              context.read<AiChatBloc>().add(
                SendMessageEvent(_controller.text.trim()),
              );

              _controller.clear();
            },
            child: Container(
              height: 48,
              width: 48,
              decoration: const BoxDecoration(
                color: kButtonColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_upward, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

/// Chat Bubble
class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const ChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: isUser ? kButtonColor : kComponentBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(color: isUser ? Colors.white : kTitleTextColor),
        ),
      ),
    );
  }
}
