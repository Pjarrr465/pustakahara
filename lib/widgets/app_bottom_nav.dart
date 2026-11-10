import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

/// Bottom nav: item aktif berupa lingkaran hijau muda + label
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(Icons.home_rounded, 'Beranda'),
    _NavItem(Icons.local_library_rounded, 'Koleksi'),
    _NavItem(Icons.menu_book_rounded, 'Pinjaman'),
    _NavItem(Icons.person_rounded, 'Profil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final selected = i == currentIndex;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(i),
                child: SizedBox(
                  width: 64,
                  height: 64,
                  child: Center(
                    child: selected
                        ? Container(
                            width: 58,
                            height: 58,
                            decoration: const BoxDecoration(
                              color: AppColors.field,
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  item.icon,
                                  size: 22,
                                  color: AppColors.green,
                                ),
                                Text(
                                  item.label,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.green,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Icon(item.icon, size: 26, color: AppColors.green),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
