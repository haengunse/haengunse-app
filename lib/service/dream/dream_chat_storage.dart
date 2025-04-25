import 'dart:convert';
import 'package:haengunse/service/dream/dream_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DreamChatStorage {
  static const _messagesKey = 'dream_messages';
  static const _chatCountKey = 'dream_chat_count';
  static const _savedDateKey = 'dream_saved_date';

  /// 채팅 메시지 저장
  static Future<void> saveChat(
      List<DreamMessage> messages, int chatCount) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedMessages =
        messages.map((m) => json.encode(m.toJson())).toList();

    await prefs.setStringList(_messagesKey, encodedMessages);
    await prefs.setInt(_chatCountKey, chatCount);
    await prefs.setString(_savedDateKey,
        DateTime.now().toIso8601String().substring(0, 10)); // yyyy-MM-dd
  }

  /// 채팅 메시지 로드
  static Future<(List<DreamMessage>, int)> loadChat() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final savedDate = prefs.getString(_savedDateKey);

    // 저장된 날짜가 오늘이 아니면 초기화
    if (savedDate != today) {
      await clearChat();
      return (<DreamMessage>[], 0);
    }

    final encodedMessages = prefs.getStringList(_messagesKey) ?? [];
    final messages = encodedMessages
        .map((e) => DreamMessage.fromJson(json.decode(e)))
        .toList();
    final chatCount = prefs.getInt(_chatCountKey) ?? 0;

    return (messages, chatCount);
  }

  /// 전체 초기화
  static Future<void> clearChat() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_messagesKey);
    await prefs.remove(_chatCountKey);
    await prefs.remove(_savedDateKey);
  }
}
