import 'package:flutter/material.dart';

import 'theme/app_colors.dart';
import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'pages/main_shell.dart';
import 'pages/notification_page.dart';
import 'pages/change_password_page.dart';
import 'pages/update_password_page.dart';

void main() => runApp(const PustakaharaApp());

class PustakaharaApp extends StatelessWidget {
  const PustakaharaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pustakahara',
      theme: ThemeData(
        fontFamily: 'Poppins', // harus sama dengan "family" di pubspec.yaml
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/register': (_) => const RegisterPage(),
        '/home': (_) => const MainShell(),
        '/notif': (_) => const NotificationPage(),
        '/change-password': (_) => const ChangePasswordPage(),
        '/update-password': (_) => const UpdatePasswordPage(),
      },
    );
  }
}
