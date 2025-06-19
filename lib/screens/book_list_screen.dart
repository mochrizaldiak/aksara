import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/book_card.dart';
import '../providers/book_provider.dart';

class BookListScreen extends ConsumerStatefulWidget {
  final String? initialSearch;
  final String? initialFilter;

  const BookListScreen({super.key, this.initialSearch, this.initialFilter});

  @override
  ConsumerState<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends ConsumerState<BookListScreen> {
  late String searchQuery;
  String? sortOption;
  late String? filterOption;

  @override
  void initState() {
    super.initState();
    searchQuery = widget.initialSearch ?? '';
    filterOption = widget.initialFilter ?? 'all';
  }

  @override
  Widget build(BuildContext context) {
    final booksAsync = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Pencarian',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2D5A),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF5F7FA),
      body: booksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Gagal memuat data: $err')),
        data: (books) {
          var filteredBooks =
              books.where((book) {
                final matchesQuery =
                    book.title.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    ) ||
                    book.author.toLowerCase().contains(
                      searchQuery.toLowerCase(),
                    );

                final matchesFilter =
                    filterOption == 'all' || book.origin == filterOption;
                return matchesQuery && matchesFilter;
              }).toList();

          if (sortOption == 'title_asc') {
            filteredBooks.sort((a, b) => a.title.compareTo(b.title));
          } else if (sortOption == 'title_desc') {
            filteredBooks.sort((a, b) => b.title.compareTo(a.title));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: TextEditingController(text: searchQuery),
                  onChanged: (value) {
                    setState(() => searchQuery = value);
                  },
                ),
                const SizedBox(height: 12),

                // Sort & Filter dropdown
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: sortOption,
                        decoration: InputDecoration(
                          hintText: 'Sort',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: null, child: Text('Default')),
                          DropdownMenuItem(
                            value: 'title_asc',
                            child: Text('Judul A-Z'),
                          ),
                          DropdownMenuItem(
                            value: 'title_desc',
                            child: Text('Judul Z-A'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => sortOption = value);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: filterOption,
                        decoration: InputDecoration(
                          hintText: 'Filter',
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 16,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'all', child: Text('Semua')),
                          DropdownMenuItem(
                            value: 'local',
                            child: Text('Penulis Lokal'),
                          ),
                          DropdownMenuItem(
                            value: 'international',
                            child: Text('Internasional'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => filterOption = value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Book Grid
                Expanded(
                  child: GridView.builder(
                    itemCount: filteredBooks.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                        ),
                    itemBuilder: (context, index) {
                      final book = filteredBooks[index];
                      return BookCard(
                        author: book.author,
                        title: book.title,
                        imagePath: book.imagePath,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/book-detail',
                            arguments: book,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
