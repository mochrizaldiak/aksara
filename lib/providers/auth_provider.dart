import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false);

  Future<User?> login(String email, String password) async {
    final data = await rootBundle.loadString('assets/data/users.json');
    final decoded = jsonDecode(data) as Map<String, dynamic>;
    final users = decoded['users'] as List<dynamic>;

    for (var u in users) {
      if (u['email'] == email.trim() && u['password'] == password.trim()) {
        state = true;
        return User(name: u['name'], email: u['email']);
      }
    }

    state = false;
    return null;
  }

  Future<String?> register({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return 'Semua field harus diisi';
    }

    if (password.length < 8) {
      return 'Password minimal 8 karakter';
    }

    if (password != confirmPassword) {
      return 'Konfirmasi password tidak sama';
    }

    final data = await rootBundle.loadString('assets/data/users.json');
    final decoded = jsonDecode(data) as Map<String, dynamic>;
    final users = decoded['users'] as List<dynamic>;

    final alreadyExists = users.any((user) => user['email'] == email.trim());

    if (alreadyExists) {
      return 'Email sudah terdaftar';
    }

    return null;
  }
}
