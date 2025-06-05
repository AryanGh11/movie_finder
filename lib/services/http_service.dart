import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPService {
  static Future<dynamic> get(Uri url) async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Failed to fetch request!");
    }
  }

  static Future<dynamic> post(Uri url, Object? body) async {
    final response = await http.post(url, body: body);

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Failed to fetch request!");
    }
  }
}
