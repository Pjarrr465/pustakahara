import 'package:flutter/foundation.dart';
import '../models/book.dart';
import 'auth_service.dart';

const _bulan = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
];

/// Contoh: 24 Nov 2026
String formatTanggal(DateTime d) => '${d.day} ${_bulan[d.month - 1]} ${d.year}';

class Loan {
  final Book book;
  final int days;
  final DateTime borrowedAt;

  const Loan({required this.book, required this.days, required this.borrowedAt});

  DateTime get dueDate => borrowedAt.add(Duration(days: days));

  /// Sisa hari sampai jatuh tempo (negatif jika terlambat)
  int get remainingDays {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);
    return due.difference(today).inDays;
  }
}

/// Pinjaman & buku tersimpan, dipisah per akun. Data hanya di memori.
class LibraryService extends ChangeNotifier {
  LibraryService._();
  static final LibraryService instance = LibraryService._();

  static const int maxSlots = 3;
  static const List<int> durations = [7, 14, 21];

  final Map<String, List<Loan>> _loans = {};
  final Map<String, List<Book>> _saved = {};

  String get _key => AuthService.currentUser?.email ?? '_guest';

  List<Loan> get loans => List.unmodifiable(_loans[_key] ?? const <Loan>[]);
  List<Book> get saved => List.unmodifiable(_saved[_key] ?? const <Book>[]);

  bool get slotFull => loans.length >= maxSlots;
  bool isBorrowed(Book book) => loans.any((l) => l.book.id == book.id);
  bool isSaved(Book book) => saved.any((b) => b.id == book.id);

  /// Mengembalikan pesan error, atau null jika berhasil
  String? borrow(Book book, int days) {
    if (isBorrowed(book)) return 'Buku ini sedang kamu pinjam';
    if (slotFull) {
      return 'Slot pinjam penuh (maks. $maxSlots buku). '
          'Simpan buku ini dengan ikon bookmark.';
    }
    _loans.putIfAbsent(_key, () => <Loan>[]).add(
          Loan(book: book, days: days, borrowedAt: DateTime.now()),
        );
    _saved[_key]?.removeWhere((b) => b.id == book.id);
    notifyListeners();
    return null;
  }

  void returnBook(Loan loan) {
    _loans[_key]?.removeWhere((l) => l.book.id == loan.book.id);
    notifyListeners();
  }

  /// Mengembalikan true jika sekarang tersimpan, false jika dihapus
  bool toggleSaved(Book book) {
    final list = _saved.putIfAbsent(_key, () => <Book>[]);
    final index = list.indexWhere((b) => b.id == book.id);
    final nowSaved = index == -1;
    if (nowSaved) {
      list.add(book);
    } else {
      list.removeAt(index);
    }
    notifyListeners();
    return nowSaved;
  }
}
