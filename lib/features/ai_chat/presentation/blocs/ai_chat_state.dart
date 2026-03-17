import 'package:equatable/equatable.dart';

class ChatMessage {
  final String message;
  final bool isUser;

  ChatMessage({required this.message, required this.isUser});
}

class AiChatState extends Equatable {
  final List<ChatMessage> messages;
  final bool isTyping;

  const AiChatState({this.messages = const [], this.isTyping = false});

  AiChatState copyWith({List<ChatMessage>? messages, bool? isTyping}) {
    return AiChatState(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [messages, isTyping];
}
