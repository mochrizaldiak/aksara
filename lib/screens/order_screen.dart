import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../components/order_card.dart';
import '../providers/order_provider.dart';
import '../providers/user_provider.dart';
import '../models/order_item.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    final allOrders = ref.watch(orderProvider);

    final now = DateTime.now();
    final pickupTime = DateFormat(
      'dd/MM/yyyy – HH:mm',
    ).format(now.add(const Duration(hours: 3)));
    final returnTime = DateFormat(
      'dd/MM/yyyy – HH:mm',
    ).format(now.add(const Duration(days: 5)));

    final userOrders =
        allOrders
            .where((order) => order.userEmail == currentUser?.email)
            .toList()
            .reversed
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Pesanan',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2D5A),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                "Buku",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2D5A),
                ),
              ),
              const SizedBox(height: 12),
              if (userOrders.isEmpty)
                const Center(
                  child: Text(
                    "Belum ada pesanan",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: userOrders.length,
                    itemBuilder: (context, index) {
                      final order = userOrders[index];
                      return OrderCard(
                        imagePath: order.book.imagePath,
                        author: order.book.author,
                        title: order.book.title,
                        status: 'Sedang Berlangsung',
                        pickupTime: pickupTime,
                        returnTime: returnTime,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
