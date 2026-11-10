import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Dialog "Kata Sandi Berhasil Diubah". Setelah 2 detik otomatis ke halaman Login.
void showPasswordChangedDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, color: AppColors.green, size: 28),
            SizedBox(height: 6),
            Text(
              'Kata Sandi Berhasil Diubah',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 4),
            Text(
              'Buka halaman login untuk melanjutkan',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: AppColors.hint),
            ),
          ],
        ),
      ),
    ),
  );

  Future.delayed(const Duration(seconds: 2), () {
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  });
}
