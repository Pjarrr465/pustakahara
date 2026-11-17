import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/library_service.dart';
import '../theme/app_colors.dart';
import '../widgets/book_cover.dart';
import '../widgets/book_detail_dialog.dart';
import '../widgets/primary_button.dart';
import '../widgets/segmented_tabs.dart';
import '../widgets/snack.dart';

/// Buku: Pinjaman Aktif dan Buku Tersimpan
class BukuPage extends StatefulWidget {
  final VoidCallback onOpenRak; // dipanggil tombol "Buka Rak"
  const BukuPage({super.key, required this.onOpenRak});

  @override
  State<BukuPage> createState() => _BukuPageState();
}

class _BukuPageState extends State<BukuPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 84, 16, 16),
            decoration: const BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: SegmentedTabs(
              labels: const ['Pinjaman Aktif', 'Buku Tersimpan'],
              selected: _tab,
              onChanged: (i) => setState(() => _tab = i),
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: LibraryService.instance,
              builder: (context, _) =>
                  _tab == 0 ? _activeTab(context) : _savedTab(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activeTab(BuildContext context) {
    final loans = LibraryService.instance.loans;

    if (loans.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _EmptyCard(
            icon: Icons.menu_book_outlined,
            title: 'Belum Ada Buku Dipinjam',
            subtitle: 'Pilih buku halaman Rak atau untuk meminjam.',
            buttonLabel: 'Buka Rak',
            onPressed: widget.onOpenRak,
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Slot pinjam terpakai: ${loans.length}/${LibraryService.maxSlots}',
          style: const TextStyle(fontSize: 10, color: AppColors.hint),
        ),
        const SizedBox(height: 10),
        for (final loan in loans) _LoanCard(loan: loan),
      ],
    );
  }

  Widget _savedTab(BuildContext context) {
    final saved = LibraryService.instance.saved;

    if (saved.isEmpty) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _EmptyCard(
            icon: Icons.bookmark_border_rounded,
            title: 'Belum Ada Buku Tersimpan',
            subtitle: 'Buku yang disimpan saat slot pinjam penuh akan muncul di sini.',
          ),
        ],
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [for (final book in saved) _SavedCard(book: book)],
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  const _EmptyCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.buttonLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.field,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.green, size: 26),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: AppColors.hint),
          ),
          if (buttonLabel != null && onPressed != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: 140,
              child: PrimaryButton(label: buttonLabel!, onPressed: onPressed!),
            ),
          ],
        ],
      ),
    );
  }
}

class _LoanCard extends StatelessWidget {
  final Loan loan;
  const _LoanCard({required this.loan});

  @override
  Widget build(BuildContext context) {
    final remaining = loan.remainingDays;
    final late = remaining < 0;
    final statusText = late
        ? 'Terlambat ${-remaining} hari'
        : remaining == 0
            ? 'Jatuh tempo hari ini'
            : 'Sisa $remaining hari';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 56, height: 80, child: BookCover(book: loan.book)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  loan.book.title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text(
                  loan.book.author,
                  style: const TextStyle(fontSize: 10, color: AppColors.hint),
                ),
                const SizedBox(height: 6),
                Text(
                  'Jatuh tempo: ${formatTanggal(loan.dueDate)}',
                  style: const TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: late ? const Color(0xFFFCE4EA) : AppColors.field,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: late ? const Color(0xFFDC2F55) : AppColors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 28,
                  child: OutlinedButton(
                    onPressed: () {
                      LibraryService.instance.returnBook(loan);
                      showMessage(context, 'Buku "${loan.book.title}" dikembalikan');
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.green),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Kembalikan',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SavedCard extends StatelessWidget {
  final Book book;
  const _SavedCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 56, height: 80, child: BookCover(book: book)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text(
                  book.author,
                  style: const TextStyle(fontSize: 10, color: AppColors.hint),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    SizedBox(
                      height: 28,
                      child: ElevatedButton(
                        onPressed: () => showBookDetail(context, book),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          'Pinjam',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: 'Hapus dari tersimpan',
                      onPressed: () => LibraryService.instance.toggleSaved(book),
                      icon: const Icon(
                        Icons.bookmark_rounded,
                        color: AppColors.green,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
