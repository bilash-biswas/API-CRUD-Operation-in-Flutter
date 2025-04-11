import 'dart:convert';

import 'package:flutter_api_crud_mvvm/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseURL = "https://yourcodingmentor.com/api/api.php";

  // Get All Users
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseURL));
    if (response.statusCode == 200) {
      final List body = jsonDecode(response.body);
      return body.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // Add New User
  Future<bool> addUser(String name, String email) async {
    final response = await http.post(Uri.parse(baseURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
        }));
    return jsonDecode(response.body)['success'] == true;
  }

  // Update User
  Future<bool> updateUser(String id, String name, String email) async {
    final response = await http.put(Uri.parse(baseURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": id,
          "name": name,
          "email": email,
        }));
    return jsonDecode(response.body)['success'] == true;
  }

  // Delete User
  Future<bool> deleteUser(String id) async {
    final response = await http.delete(Uri.parse(baseURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": id,
        }));
    return jsonDecode(response.body)['success'] == true;
  }
}
