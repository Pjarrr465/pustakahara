import 'package:flutter/material.dart';

import '../widgets/password_form_card.dart';
import '../services/auth_service.dart';
import '../widgets/snack.dart';
import '../widgets/success_dialog.dart';

/// "Ubah Kata Sandi" (Group 64) - untuk user yang sudah login
class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ubah Kata Sandi',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: PasswordFormCard(
          labels: const [
            'Kata Sandi Sekarang',
            'Kata Sandi Baru',
            'Konfirmasi Kata Sandi Baru',
          ],
          buttonLabel: 'Ubah Kata Sandi',
          onSubmit: (v) {
            final error = AuthService.changePassword(v[0], v[1], v[2]);
            if (error != null) {
              showMessage(context, error);
              return;
            }
            showPasswordChangedDialog(context);
          },
        ),
      ),
    );
  }
}
