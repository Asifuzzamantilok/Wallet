import 'dart:convert';
import 'package:http/http.dart' as http;
import '../storage/secure_storage.dart';

class ApiService {
  final String baseUrl = "https://your-api-url";

  Future login(String phone, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "phone": phone,
        "password": password
      }),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      await SecureStorage.setToken(data['token']);
    }

    return data;
  }
}