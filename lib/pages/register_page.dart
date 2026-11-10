import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/primary_button.dart';
import '../widgets/snack.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullName = TextEditingController();
  final _nickname = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    for (final c in [
      _fullName,
      _nickname,
      _phone,
      _email,
      _password,
      _confirm,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _register() {
    final error = AuthService.register(
      fullName: _fullName.text,
      nickname: _nickname.text,
      phone: _phone.text,
      email: _email.text,
      password: _password.text,
      confirm: _confirm.text,
    );
    if (error != null) {
      showMessage(context, error);
      return;
    }
    showMessage(context, 'Akun berhasil dibuat, silakan masuk');
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 10);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AuthHeader(),
            Transform.translate(
              offset: const Offset(0, -40),
              child: Column(
                children: [
                  AuthCard(
                    child: Column(
                      children: [
                        AppTextField(
                          hint: 'Nama lengkap',
                          controller: _fullName,
                        ),
                        gap,
                        AppTextField(
                          hint: 'Nama Panggilan',
                          controller: _nickname,
                        ),
                        gap,
                        AppTextField(
                          hint: 'Nomor Telepon',
                          controller: _phone,
                          keyboardType: TextInputType.phone,
                        ),
                        gap,
                        AppTextField(
                          hint: 'Email',
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        gap,
                        AppTextField(
                          hint: 'Kata Sandi',
                          obscure: true,
                          controller: _password,
                        ),
                        gap,
                        AppTextField(
                          hint: 'Konfirmasi Kata Sandi',
                          obscure: true,
                          controller: _confirm,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: PrimaryButton(label: 'Daftar', onPressed: _register),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
