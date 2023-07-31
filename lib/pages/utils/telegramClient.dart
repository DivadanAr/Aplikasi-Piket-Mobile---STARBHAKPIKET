import 'dart:math';
import 'package:http/http.dart' as http;

class TelegramClient {
  final String chatId;
  final String botToken;
  TelegramClient({
    required this.chatId,
    required this.botToken,
  });

  String _limitMessage(final String message) =>
      message.substring(0, min(4096, message.length));

  Future<http.Response> sendMessage(final String message) {
    final Uri uri = Uri.https(
      "api.telegram.org",
      "/bot${this.botToken}/sendMessage",
      {
        "chat_id": this.chatId,
        "text": _limitMessage(message),
        "parse_mode": "html",
      },
    );
    print(uri.toString());
    return http.get(uri);
  }
}
