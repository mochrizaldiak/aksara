import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';
import '../models/order_item.dart';

class OrderNotifier extends StateNotifier<List<OrderItem>> {
  OrderNotifier() : super([]);

  void addOrder(Book book, String email) {
    final newOrder = OrderItem(book: book, userEmail: email);
    state = [...state, newOrder];
  }

  void clearOrders() {
    state = [];
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, List<OrderItem>>((
  ref,
) {
  return OrderNotifier();
});
