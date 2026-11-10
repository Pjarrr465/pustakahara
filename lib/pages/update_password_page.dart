import 'package:flutter/material.dart';

import '../widgets/password_form_card.dart';
import '../services/auth_service.dart';
import '../widgets/snack.dart';
import '../widgets/success_dialog.dart';

/// "Perbarui Kata Sandi" - dibuka dari "Lupa kata sandi?" di halaman Login
class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final identifier = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: PasswordFormCard(
            title: 'Perbarui Kata Sandi',
            labels: const [
              'Kata Sandi Sebelumnya',
              'Kata Sandi Baru',
              'Konfirmasi Kata Sandi Baru',
            ],
            buttonLabel: 'Ubah Kata Sandi',
            onSubmit: (v) {
              final error = AuthService.changePassword(
                v[0],
                v[1],
                v[2],
                identifier: identifier,
              );
              if (error != null) {
                showMessage(context, error);
                return;
              }
              showPasswordChangedDialog(context);
            },
          ),
        ),
      ),
    );
  }
}
