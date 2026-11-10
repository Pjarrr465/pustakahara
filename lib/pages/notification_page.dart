import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static const tabs = ['Berhasil', 'Tenggat Waktu', 'Info Buku'];
  int _tab = 0;

  // data contoh, nanti ganti dengan data asli
  static const data = {
    'Berhasil': [
      ['Peminjaman berhasil', 'Buku "Bumi Manusia" berhasil dipinjam.'],
      ['Kata sandi diubah', 'Kata sandi kamu berhasil diperbarui.'],
    ],
    'Tenggat Waktu': [
      ['Segera dikembalikan', 'Buku "Dilan 1990" jatuh tempo besok.'],
    ],
    'Info Buku': [
      ['Buku baru tersedia', '"Laut Bercerita" kini tersedia di perpustakaan.'],
    ],
  };

  @override
  Widget build(BuildContext context) {
    final items = data[tabs[_tab]]!;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 48, 20, 16),
            decoration: const BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Pusat Notifikasi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(tabs.length, (i) {
                    final selected = i == _tab;
                    return GestureDetector(
                      onTap: () => setState(() => _tab = i),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: selected ? Colors.white : AppColors.green,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white),
                        ),
                        child: Text(
                          tabs[i],
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: selected ? AppColors.green : Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, i) => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.field,
                      child: Icon(
                        Icons.notifications_rounded,
                        size: 16,
                        color: AppColors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[i][0],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            items[i][1],
                            style: const TextStyle(
                              fontSize: 10,
                              color: AppColors.hint,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
