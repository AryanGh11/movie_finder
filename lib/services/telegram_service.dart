import 'package:url_launcher/url_launcher.dart';

class TelegramService {
  static Future<void> sendMessage({
    required String message,
    required String username,
  }) async {
    final String uriMessage = Uri.encodeComponent(message);
    final Uri url = Uri.parse('https://t.me/$username?text=$uriMessage');

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch Telegram';
    }
  }
}
