import 'package:flutter/material.dart';
import 'package:flutter_api_crud_mvvm/models/user_model.dart';
import 'package:flutter_api_crud_mvvm/services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  List<UserModel> users = [];
  bool isLoading = false;
  final ApiService _apiService = ApiService();

  Future<void> getUsers() async {
    isLoading = true;
    notifyListeners();

    users = await _apiService.fetchUsers();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addUser(String name, String email) async {
    await _apiService.addUser(name, email);
    await getUsers();
  }

  Future<void> updateUser(String id, String name, String email) async {
    await _apiService.updateUser(id, name, email);
    await getUsers();
  }

  Future<void> deleteUser(String id) async {
    await _apiService.deleteUser(id);
    await getUsers();
  }

  Future<void> filterUsers(String query) async {
    isLoading = true;
    notifyListeners();
    users = await _apiService.fetchUsers();
    users = users.where((user) => user.name.toLowerCase().contains(query.toLowerCase())).toList();
    isLoading = false;
    notifyListeners();
  }
}