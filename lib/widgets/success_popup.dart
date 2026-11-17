import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Popup sukses (centang hijau). Menutup sendiri setelah ~2 detik,
/// atau saat disentuh di luar kotak.
Future<void> showSuccessPopup(
  BuildContext context, {
  required String title,
  required String subtitle,
}) {
  return showDialog(
    context: context,
    builder: (_) => _AutoCloseDialog(title: title, subtitle: subtitle),
  );
}

class _AutoCloseDialog extends StatefulWidget {
  final String title;
  final String subtitle;
  const _AutoCloseDialog({required this.title, required this.subtitle});

  @override
  State<_AutoCloseDialog> createState() => _AutoCloseDialogState();
}

class _AutoCloseDialogState extends State<_AutoCloseDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_rounded, color: AppColors.green, size: 30),
            const SizedBox(height: 6),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            Text(
              widget.subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: AppColors.hint),
            ),
          ],
        ),
      ),
    );
  }
}
