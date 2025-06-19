import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserData {
  final String name;
  final String email;

  UserData({required this.name, required this.email});
}

class UserNotifier extends StateNotifier<UserData?> {
  UserNotifier() : super(null);

  void setUser(String name, String email) {
    state = UserData(name: name, email: email);
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserData?>(
  (ref) => UserNotifier(),
);
