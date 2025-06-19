import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/book_card.dart';
import '../components/chip.dart';
import '../providers/book_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final booksAsync = ref.watch(bookListProvider);
    final List<String> categories = ['local', 'international'];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: const Text(
          'Aksara',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2D5A),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: GestureDetector(
                  onTap: () async {
                    final result = await showSearch(
                      context: context,
                      delegate: BookSearchDelegate(),
                    );
                    if (result != null && context.mounted) {
                      Navigator.pushNamed(
                        context,
                        '/list',
                        arguments: {'search': result},
                      );
                    }
                  },
                  child: const Row(
                    children: [
                      Icon(Icons.search, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('Search', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Kategori',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2D5A),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      categories
                          .map(
                            (category) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/list',
                                    arguments: {'filter': category},
                                  );
                                },
                                child: CategoryChip(
                                  label:
                                      category == 'local'
                                          ? 'Lokal'
                                          : 'Internasional',
                                ),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              const SizedBox(height: 24),
              _buildSection('Buku Populer'),
              const SizedBox(height: 16),
              booksAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (err, _) => Center(child: Text('Gagal memuat data: $err')),
                data: (books) {
                  final selected = books.take(5).toList();
                  return _buildBookList(context, selected);
                },
              ),
              const SizedBox(height: 32),
              _buildSection('Menarik untuk dibaca'),
              const SizedBox(height: 16),
              booksAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error:
                    (err, _) => Center(child: Text('Gagal memuat data: $err')),
                data: (books) {
                  final selected = books.reversed.take(5).toList();
                  return _buildBookList(context, selected);
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildSection(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1F2D5A),
      ),
    );
  }

  Widget _buildBookList(BuildContext context, List books) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final book = books[index];
          return BookCard(
            author: book.author,
            title: book.title,
            imagePath: book.imagePath,
            onTap: () {
              Navigator.pushNamed(context, '/book-detail', arguments: book);
            },
          );
        },
      ),
    );
  }
}

class BookSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const SizedBox();
  }
}
