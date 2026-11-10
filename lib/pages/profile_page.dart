import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../theme/app_colors.dart';
import '../widgets/logout_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _header(),
                // kartu menumpuk di tepi bawah header
                const Positioned(
                  left: 16,
                  right: 16,
                  bottom: -50,
                  child: SizedBox(height: 132, child: _MemberCard()),
                ),
              ],
            ),
            const SizedBox(height: 62), // 50 (kartu keluar header) + jarak
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const _MenuItem(
                    icon: Icons.history_rounded,
                    color: AppColors.green,
                    tile: Color(0xFFE3F6EC),
                    title: 'Riwayat Peminjaman',
                    subtitle: 'Arsip Buku yang Pernah Dipinjam & Di kembalikan',
                  ),
                  _MenuItem(
                    icon: Icons.notifications_none_rounded,
                    color: AppColors.green,
                    tile: const Color(0xFFE3F6EC),
                    title: 'Pengaturan Notifikasi',
                    subtitle: 'Pengingat Tenggat Jatuh Tempo (WhatsApp, Email)',
                    onTap: () => Navigator.pushNamed(context, '/notif'),
                  ),
                  const _MenuItem(
                    icon: Icons.verified_user_outlined,
                    color: Color(0xFF4F46E5),
                    tile: Color(0xFFE8E9FB),
                    title: 'Keamanan Akun',
                    subtitle: 'Kata Sandi & Verifikasi Login',
                  ),
                  const _MenuItem(
                    icon: Icons.help_outline_rounded,
                    color: Color(0xFFD97706),
                    tile: Color(0xFFFEF3DC),
                    title: 'Bantuan & FAQ',
                    subtitle: 'Ketentuan, Denda, & Kontak Pustakawan',
                  ),
                  _MenuItem(
                    icon: Icons.logout_rounded,
                    color: const Color(0xFFDC2F55),
                    tile: const Color(0xFFFCE4EA),
                    title: 'Log Out',
                    subtitle: 'Keluar dari sesi akun saat ini',
                    onTap: () => showLogoutDialog(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 110),
      decoration: const BoxDecoration(
        color: AppColors.green,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(48)),
      ),
      child: Column(
        children: [
          Text(
            (AuthService.currentUser?.fullName ?? 'Pustakawan'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            (AuthService.currentUser?.email ?? '-'),
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 108,
            height: 108,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                      ),
                      // ganti dengan foto: backgroundImage: AssetImage('assets/images/profile.jpg')
                      child: const CircleAvatar(
                        radius: 44,
                        backgroundColor: AppColors.field,
                        child: Icon(
                          Icons.person_rounded,
                          size: 50,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 0,
                  bottom: 4,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.edit_rounded,
                      size: 14,
                      color: AppColors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard();

  static const _bars = [
    1,
    2,
    1,
    3,
    1,
    1,
    2,
    1,
    3,
    1,
    2,
    1,
    1,
    3,
    1,
    2,
    1,
    2,
    1,
    1,
    3,
    1,
    2,
    1,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0B1F2E), Color(0xFF1F3B3A)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_stories_rounded, size: 16, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'Pustakawan Card',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (AuthService.currentUser?.nickname ?? '-'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    (AuthService.currentUser?.memberId ?? '-'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Akses Pustakawan Tanpa Batas',
                    style: TextStyle(color: Color(0xFF4ADE80), fontSize: 8),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Terverifikasi Aktif',
                style: TextStyle(color: Colors.white, fontSize: 8),
              ),
              Row(
                children: [
                  for (final w in _bars)
                    Container(
                      width: w.toDouble(),
                      height: 14,
                      margin: const EdgeInsets.only(right: 1.5),
                      color: Colors.white,
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color tile;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.color,
    required this.tile,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: tile,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.hint,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
