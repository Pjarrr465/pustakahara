import 'package:flutter/material.dart';

class Book {
  final String title;
  final String author;
  final Color color; // sementara pengganti gambar sampul
  final String?
  image; // isi path asset jika sudah ada, mis. 'assets/images/bumi.jpg'

  const Book(this.title, this.author, this.color, {this.image});
}

const rekomendasi = [
  Book('Bumi Manusia', 'Pramoedya A. T.', Color(0xFFB8803A)),
  Book('Dilan 1990', 'Pidi Baiq', Color(0xFF3B6EA5)),
  Book('Filosofi Teras', 'Henry Manampiring', Color(0xFF2FB5A5)),
  Book('Laut Bercerita', 'Leila S. Chudori', Color(0xFF5B8DB8)),
];

const populer = [
  Book('Ultraman', 'Pat Cadigan', Color(0xFFC0392B)),
  Book('Laut Bercerita', 'Leila S. Chudori', Color(0xFF5B8DB8)),
  Book('Bumi Manusia', 'Pramoedya A. T.', Color(0xFFB8803A)),
  Book('Dilan 1990', 'Pidi Baiq', Color(0xFF3B6EA5)),
];
