import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ai_chat_event.dart';
import 'ai_chat_state.dart';

class AiChatBloc extends Bloc<AiChatEvent, AiChatState> {
  AiChatBloc() : super(const AiChatState()) {
    on<SendMessageEvent>(_onSendMessage);
  }

  Future<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<AiChatState> emit,
  ) async {
    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(message: event.message, isUser: true));

    emit(state.copyWith(messages: updatedMessages, isTyping: true));

    /// Simulate AI delay
    await Future.delayed(const Duration(seconds: 1));

    /// Dummy AI response (replace with API)
    final aiResponse =
        "That's interesting. Tell me more about how you're feeling.";

    updatedMessages.add(ChatMessage(message: aiResponse, isUser: false));

    emit(state.copyWith(messages: updatedMessages, isTyping: false));
  }
}
