import 'package:flutter/material.dart';
import '../models/book.dart';

/// Sampul buku dari asset. Jika file belum ada, tampil kotak berwarna + judul.
class BookCover extends StatelessWidget {
  final Book book;
  final double radius;

  const BookCover({super.key, required this.book, this.radius = 4});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: book.image == null
          ? _fallback()
          : Image.asset(
              book.image!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (_, __, ___) => _fallback(),
            ),
    );
  }

  Widget _fallback() {
    return Container(
      color: book.color,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(6),
      child: Text(
        book.title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }
}
