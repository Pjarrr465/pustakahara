import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'app_text_field.dart';
import 'primary_button.dart';

/// Kartu form 3 kolom kata sandi + tombol (dipakai halaman Ubah & Perbarui).
/// onSubmit menerima isi ketiga field sesuai urutan labels.
class PasswordFormCard extends StatefulWidget {
  final String? title;
  final List<String> labels;
  final String buttonLabel;
  final void Function(List<String> values) onSubmit;

  const PasswordFormCard({
    super.key,
    this.title,
    required this.labels,
    required this.buttonLabel,
    required this.onSubmit,
  });

  @override
  State<PasswordFormCard> createState() => _PasswordFormCardState();
}

class _PasswordFormCardState extends State<PasswordFormCard> {
  late final List<TextEditingController> _controllers = List.generate(
    widget.labels.length,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 14),
          ],
          for (var i = 0; i < widget.labels.length; i++) ...[
            AppTextField(
              hint: widget.labels[i],
              obscure: true,
              controller: _controllers[i],
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 6),
          SizedBox(
            width: 130,
            child: PrimaryButton(
              label: widget.buttonLabel,
              onPressed: () =>
                  widget.onSubmit(_controllers.map((c) => c.text).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
