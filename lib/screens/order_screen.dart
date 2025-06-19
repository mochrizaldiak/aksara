import 'package:flutter/material.dart';
import '../components/order_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Contoh OrderCard
              const OrderCard(
                imagePath: 'assets/book_cover.jpg',
                author: 'Marchella FP',
                title: 'Nanti Kita Cerita Tentang Hari Ini',
                status: 'Sedang Berlangsung',
                pickupTime: '12/05/2025 – 15:00 WIB',
                returnTime: '19/05/2025 – 15:00 WIB',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
