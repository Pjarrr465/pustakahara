import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/primary_button.dart';
import '../widgets/snack.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _login() {
    if (AuthService.login(_idController.text, _pwController.text)) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      showMessage(context, 'Email/nomor telepon atau kata sandi salah');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          hint: 'Nomor Telepon atau Email',
                          controller: _idController,
                        ),
                        const SizedBox(height: 10),
                        AppTextField(
                          hint: 'Kata Sandi',
                          obscure: true,
                          controller: _pwController,
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/update-password',
                              arguments: _idController.text,
                            ),
                            child: const Text(
                              'Lupa kata sandi?',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.green,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 64),
                    child: Column(
                      children: [
                        PrimaryButton(label: 'Masuk', onPressed: _login),
                        const SizedBox(height: 12),
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                'Atau',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.hint,
                                ),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 12),
                        PrimaryButton(
                          label: 'Daftar',
                          onPressed: () =>
                              Navigator.pushNamed(context, '/register'),
                        ),
                      ],
                    ),
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
