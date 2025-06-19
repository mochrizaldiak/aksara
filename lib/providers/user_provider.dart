import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user.dart';

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  void setUser(String name, String email) {
    state = User(name: name, email: email);
  }

  void clearUser() {
    state = null;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});
