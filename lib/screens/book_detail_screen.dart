import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/book.dart';
import '../providers/order_provider.dart';
import '../components/custom_modal.dart';
import '../providers/user_provider.dart';

class BookDetailScreen extends ConsumerWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showBookingModal() {
      showDialog(
        context: context,
        builder:
            (_) => CustomModal(
              title: 'Booking',
              description: 'Apakah Anda yakin ingin meminjam buku ini?',
              onCancel: () => Navigator.pop(context),
              onConfirm: () {
                Navigator.pop(context);

                final user = ref.read(userProvider);
                if (user != null) {
                  ref.read(orderProvider.notifier).addOrder(book, user.email);
                }

                showDialog(
                  context: context,
                  builder:
                      (_) => CustomModal(
                        title: 'Booked',
                        description:
                            'Setelah melakukan pemesanan, Anda dapat mengambil buku di perpustakaan fisik dalam waktu 1 jam sesuai jam operasional perpustakaan. Pemberitahuan akan dikirimkan jika buku tidak diambil dalam batas waktu tersebut.',
                        onCancel: () => Navigator.pop(context),
                        onConfirm: () {
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/order');
                        },
                        confirmText: 'Tutup',
                        singleButton: true,
                      ),
                );
              },
            ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  height: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(book.imagePath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 24,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: ListView(
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2D5A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      book.author,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Deskripsi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2D5A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.description,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Informasi Buku",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2D5A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Bahasa",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                book.language,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Tanggal Rilis",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                book.releaseDate,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Penerbit",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                book.publisher,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Penulis",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                book.author,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF5F7FA),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Available book in Offline Library: ${book.stock}",
                    style: const TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8FAEE0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: showBookingModal,
                      child: const Text(
                        'Booking',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
