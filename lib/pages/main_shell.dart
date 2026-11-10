import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';
import 'home_page.dart';
import 'profile_page.dart';

/// Kerangka utama setelah login: 4 tab + bottom nav
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [
          HomePage(),
          _Placeholder('Koleksi'),
          _Placeholder('Pinjaman'),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final String name;
  const _Placeholder(this.name);

  @override
  Widget build(BuildContext context) =>
      Center(child: Text('Halaman $name (belum dibuat)'));
}
