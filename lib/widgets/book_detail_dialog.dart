import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/library_service.dart';
import '../theme/app_colors.dart';
import 'book_cover.dart';
import 'primary_button.dart';
import 'success_popup.dart';

/// Pop up detail buku: sampul, deskripsi, pilihan lama pinjam, tombol Pinjam
/// dan bookmark. Panggil dari mana saja: showBookDetail(context, book);
void showBookDetail(BuildContext context, Book book) {
  showDialog(
    context: context,
    builder: (_) => _BookDetailDialog(book: book, parentContext: context),
  );
}

class _BookDetailDialog extends StatefulWidget {
  final Book book;
  final BuildContext parentContext; // dipakai untuk menampilkan popup sukses
  const _BookDetailDialog({required this.book, required this.parentContext});

  @override
  State<_BookDetailDialog> createState() => _BookDetailDialogState();
}

class _BookDetailDialogState extends State<_BookDetailDialog> {
  int? _days;
  String? _message;
  bool _isError = false;

  void _setMessage(String text, {bool error = false}) {
    setState(() {
      _message = text;
      _isError = error;
    });
  }

  void _borrow() {
    if (_days == null) {
      _setMessage('Pilih lama peminjaman terlebih dahulu', error: true);
      return;
    }
    final error = LibraryService.instance.borrow(widget.book, _days!);
    if (error != null) {
      _setMessage(error, error: true);
      return;
    }
    Navigator.pop(context);
    if (widget.parentContext.mounted) {
      showSuccessPopup(
        widget.parentContext,
        title: 'Buku Berhasil Dipinjam!',
        subtitle: 'Buka halaman Buku untuk melihat.',
      );
    }
  }

  void _toggleSave() {
    final nowSaved = LibraryService.instance.toggleSaved(widget.book);
    _setMessage(
      nowSaved
          ? 'Disimpan ke Buku Tersimpan'
          : 'Dihapus dari Buku Tersimpan',
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    final dueText = _days == null
        ? ''
        : formatTanggal(DateTime.now().add(Duration(days: _days!)));

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
        side: const BorderSide(color: AppColors.border),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100,
              height: 146,
              child: BookCover(book: book, radius: 6),
            ),
            const SizedBox(height: 12),
            Text(
              book.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              book.author,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.text),
            ),
            const SizedBox(height: 14),
            Text(
              book.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 12, height: 1.5),
            ),
            const SizedBox(height: 16),
            _borrowPanel(dueText),
          ],
        ),
      ),
    );
  }

  Widget _borrowPanel(String dueText) {
    final saved = LibraryService.instance.isSaved(widget.book);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Lama Peminjaman :', style: TextStyle(fontSize: 10)),
          const SizedBox(height: 6),
          Row(
            children: [
              for (var i = 0; i < LibraryService.durations.length; i++) ...[
                if (i > 0) const SizedBox(width: 6),
                Expanded(child: _durationChip(LibraryService.durations[i])),
              ],
            ],
          ),
          const Divider(height: 16, thickness: 1, color: Color(0xFF6B7280)),
          Row(
            children: [
              const Text('Jatuh Tempo :', style: TextStyle(fontSize: 10)),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 28,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(dueText, style: const TextStyle(fontSize: 11)),
                ),
              ),
            ],
          ),
          if (_message != null) ...[
            const SizedBox(height: 8),
            Text(
              _message!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: _isError ? const Color(0xFFDC2F55) : AppColors.green,
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: PrimaryButton(label: 'Pinjam', onPressed: _borrow)),
              const SizedBox(width: 8),
              Material(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: _toggleSave,
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      saved
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _durationChip(int days) {
    final selected = _days == days;
    return GestureDetector(
      onTap: () => setState(() {
        _days = days;
        _message = null;
      }),
      child: Container(
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.green : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '$days Hari',
          style: TextStyle(
            fontSize: 11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
