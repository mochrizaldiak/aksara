import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/custom_modal.dart';
import '../providers/user_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (_) => CustomModal(
            title: 'Keluar',
            description: 'Apakah Anda yakin ingin keluar?',
            onConfirm: () {
              ref.read(userProvider.notifier).clearUser();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
            onCancel: () {
              Navigator.of(context).pop();
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Padding(
          padding: EdgeInsets.only(top: 16),
          child: Text(
            'Profil',
            style: TextStyle(
              color: Color(0xFF1F2D5A),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 24),
          const Icon(Icons.account_circle, size: 100, color: Colors.grey),
          const SizedBox(height: 16),
          Text(
            user?.name ?? 'Nama tidak tersedia',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2D5A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user?.email ?? 'Email tidak tersedia',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE9ECF0),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text(
                      'Pesanan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/order');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text(
                      'Keluar',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    onTap: () => _showLogoutDialog(context, ref),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
