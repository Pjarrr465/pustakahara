/// Auth sementara (tanpa server). Semua data hanya tersimpan di memori,
/// jadi akun baru hilang saat aplikasi di-restart penuh.
class AppUser {
  String fullName;
  String nickname;
  String phone;
  String email;
  String password;
  String memberId;

  AppUser({
    required this.fullName,
    required this.nickname,
    required this.phone,
    required this.email,
    required this.password,
    required this.memberId,
  });
}

class AuthService {
  // Akun dummy bawaan
  static final List<AppUser> _users = [
    AppUser(
      fullName: 'Pustakawan',
      nickname: 'angang',
      phone: '08123456789',
      email: 'angang@gmail.com',
      password: '12345678',
      memberId: 'LIB-2026-087',
    ),
  ];

  /// User yang sedang login (null jika belum login)
  static AppUser? currentUser;

  static AppUser? _find(String id) {
    final key = id.trim().toLowerCase();
    if (key.isEmpty) return null;
    for (final u in _users) {
      if (u.email.toLowerCase() == key || u.phone == key) return u;
    }
    return null;
  }

  /// Login dengan email ATAU nomor telepon
  static bool login(String id, String pw) {
    final user = _find(id);
    if (user != null && user.password == pw) {
      currentUser = user;
      return true;
    }
    return false;
  }

  static void logout() => currentUser = null;

  /// Mengembalikan pesan error, atau null jika berhasil
  static String? register({
    required String fullName,
    required String nickname,
    required String phone,
    required String email,
    required String password,
    required String confirm,
  }) {
    fullName = fullName.trim();
    nickname = nickname.trim();
    phone = phone.trim();
    email = email.trim().toLowerCase();

    if ([
      fullName,
      nickname,
      phone,
      email,
      password,
      confirm,
    ].any((e) => e.isEmpty)) {
      return 'Semua kolom harus diisi';
    }
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) {
      return 'Format email tidak valid';
    }
    if (!RegExp(r'^[0-9]{9,15}$').hasMatch(phone)) {
      return 'Nomor telepon harus 9-15 digit angka';
    }
    if (password.length < 8) return 'Kata sandi minimal 8 karakter';
    if (password != confirm) return 'Konfirmasi kata sandi tidak sama';
    if (_find(email) != null) return 'Email sudah terdaftar';
    if (_find(phone) != null) return 'Nomor telepon sudah terdaftar';

    _users.add(
      AppUser(
        fullName: fullName,
        nickname: nickname,
        phone: phone,
        email: email,
        password: password,
        memberId: 'LIB-2026-${(87 + _users.length).toString().padLeft(3, '0')}',
      ),
    );
    return null;
  }

  /// Jika sudah login -> akun yang login. Jika belum (dari "Lupa kata sandi?")
  /// -> akun dicari dari email/telepon yang diketik di halaman Login.
  static String? changePassword(
    String current,
    String newPw,
    String confirm, {
    String? identifier,
  }) {
    final user = currentUser ?? _find(identifier ?? '');
    if (user == null) {
      return 'Isi Email/Nomor Telepon di halaman Login terlebih dahulu';
    }
    if (current.isEmpty || newPw.isEmpty || confirm.isEmpty) {
      return 'Semua kolom harus diisi';
    }
    if (current != user.password) return 'Kata sandi lama salah';
    if (newPw.length < 8) return 'Kata sandi baru minimal 8 karakter';
    if (newPw != confirm) return 'Konfirmasi kata sandi tidak sama';
    user.password = newPw;
    return null;
  }
}
