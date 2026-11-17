import 'package:flutter/material.dart';

class Book {
  final String id; // unik, dipakai untuk melacak pinjaman & simpanan
  final String title;
  final String author;
  final String category; // 'Fiksi' atau 'Non Fiksi'
  final String description;
  final Color color; // warna cadangan jika gambar sampul belum ada
  final String? image; // path asset sampul, mis. 'assets/images/bumi_manusia.png'

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.color,
    this.image,
  });
}

const bumiManusia = Book(
  id: 'bumi-manusia',
  title: 'Bumi Manusia',
  author: 'Pramoedya A. T.',
  category: 'Fiksi',
  description:
      'Novel sejarah tentang Minke, pribumi terpelajar di masa Hindia Belanda. '
      'Kisah cintanya dengan Annelies membawanya berhadapan dengan ketidakadilan '
      'hukum dan sistem kolonial pada masanya.',
  color: Color(0xFFB8803A),
  image: 'assets/images/bumi_manusia.png',
);

const dilan1990 = Book(
  id: 'dilan-1990',
  title: 'Dilan 1990',
  author: 'Pidi Baiq',
  category: 'Fiksi',
  description:
      'Kisah Milea, siswi pindahan di Bandung tahun 1990, yang bertemu Dilan, '
      'teman sekolah dengan cara pendekatan yang tidak biasa. Cerita remaja yang '
      'hangat, lucu, dan penuh kenangan.',
  color: Color(0xFF3B6EA5),
  image: 'assets/images/dilan_1990.png',
);

const filosofiTeras = Book(
  id: 'filosofi-teras',
  title: 'Filosofi Teras',
  author: 'Henry Manampiring',
  category: 'Non Fiksi',
  description:
      'Filosofi Teras pada awalnya menceritakan survei kekhawatiran nasional '
      'yang semakin masif dan menyajikan sekilas kehidupan penulis yang penuh '
      'emosi negatif. Lebih dari 2000 tahun lalu, ada sebuah mazhab filsafat '
      'yang menemukan akar masalah dan solusi dari banyaknya emosi negatif.',
  color: Color(0xFF2FB5A5),
  image: 'assets/images/filosofi_teras.png',
);

const lautBercerita = Book(
  id: 'laut-bercerita',
  title: 'Laut Bercerita',
  author: 'Leila S. Chudori',
  category: 'Fiksi',
  description:
      'Novel Laut Bercerita menceritakan tentang tragedi tersebut dari berbagai '
      'sudut pandang. Mulai dari keluarga dan sahabat yang kehilangan, hingga '
      'sekelompok orang yang gemar menyiksa dan lancar berkhianat.',
  color: Color(0xFF5B8DB8),
  image: 'assets/images/laut_bercerita.png',
);

const ultraman = Book(
  id: 'ultraman',
  title: 'Ultraman',
  author: 'Pat Cadigan',
  category: 'Fiksi',
  description:
      'Pembela Bumi yang ikonik ini! Mengejar monster luar angkasa buronan, '
      'Makhluk Cahaya memasuki atmosfer Bumi. Secara tidak sengaja bertabrakan '
      'dengan jet patroli yang dikemudikan oleh Agen Patroli Sains Shin Hayata, '
      'Makhluk tersebut menyatu dengan pilot untuk menyelamatkan nyawanya dan '
      'bersumpah untuk membela Bumi.',
  color: Color(0xFFC0392B),
  image: 'assets/images/ultraman.png',
);

const laskarPelangi = Book(
  id: 'laskar-pelangi',
  title: 'Laskar Pelangi',
  author: 'Andrea Hirata',
  category: 'Non Fiksi',
  description:
      'Cerita sepuluh anak di Belitung yang bersekolah di SD Muhammadiyah yang '
      'serba kekurangan. Dengan bimbingan guru-guru yang tulus, mereka tetap '
      'semangat belajar dan menjaga mimpi mereka.',
  color: Color(0xFFD94F3A),
  image: 'assets/images/laskar_pelangi.png',
);

/// Semua buku untuk halaman Rak
const semuaBuku = [
  bumiManusia,
  dilan1990,
  filosofiTeras,
  lautBercerita,
  laskarPelangi,
  ultraman,
];

const rekomendasi = [bumiManusia, dilan1990, filosofiTeras, lautBercerita];

const populer = [ultraman, lautBercerita, bumiManusia, dilan1990];
