import 'package:flutter/material.dart';

import '../widgets/app_bottom_nav.dart';
import 'buku_page.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'rak_page.dart';

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
        children: [
          const HomePage(),
          const RakPage(),
          BukuPage(onOpenRak: () => setState(() => _index = 1)),
          const ProfilePage(),
        ],
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
