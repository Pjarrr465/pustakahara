import 'package:flutter/material.dart';
import '../models/book.dart';
import '../theme/app_colors.dart';
import '../widgets/book_card.dart';
import '../widgets/book_detail_dialog.dart';
import '../widgets/segmented_tabs.dart';

/// Rak: semua buku + pencarian + filter Semua / Fiksi / Non Fiksi
class RakPage extends StatefulWidget {
  const RakPage({super.key});

  @override
  State<RakPage> createState() => _RakPageState();
}

class _RakPageState extends State<RakPage> {
  static const _tabs = ['Semua', 'Fiksi', 'Non Fiksi'];
  int _tab = 0;
  String _query = '';

  List<Book> get _filtered {
    final q = _query.trim().toLowerCase();
    return semuaBuku.where((b) {
      final matchTab = _tab == 0 || b.category == _tabs[_tab];
      final matchQuery = q.isEmpty ||
          b.title.toLowerCase().contains(q) ||
          b.author.toLowerCase().contains(q);
      return matchTab && matchQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final books = _filtered;

    return Scaffold(
      body: Column(
        children: [
          _header(),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SegmentedTabs(
              labels: _tabs,
              selected: _tab,
              onChanged: (i) => setState(() => _tab = i),
            ),
          ),
          Expanded(
            child: books.isEmpty
                ? const Center(
                    child: Text(
                      'Buku tidak ditemukan',
                      style: TextStyle(fontSize: 12, color: AppColors.hint),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: books.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.72,
                    ),
                    itemBuilder: (_, i) => BookCard(
                      book: books[i],
                      onTap: () => showBookDetail(context, books[i]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 52, 16, 20),
      decoration: const BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          onChanged: (v) => setState(() => _query = v),
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(fontSize: 13, color: AppColors.hint),
            prefixIcon: Icon(Icons.search_rounded, color: AppColors.text),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
