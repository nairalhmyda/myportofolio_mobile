
import 'package:flutter/foundation.dart';
import 'api_client.dart';

/// Menyimpan status autentikasi pengguna selama aplikasi berjalan.
class AuthState extends ChangeNotifier {
  AuthState(this._apiClient, {String? initialToken})
      : _token = initialToken;

  final ApiClient _apiClient;
  String? _token;

  // Mengambil token pengguna saat ini.
  String? get token => _token;

  // Memeriksa apakah pengguna sudah login.
  bool get isLoggedIn => _token != null;

  // Login menggunakan username dan password.
  Future<void> login(String username, String password) async {
    _token = await _apiClient.obtainToken(username, password);

    // Memberitahu widget bahwa status login berubah.
    notifyListeners();
  }

  // Logout dari aplikasi dan backend Django.
  Future<void> logout() async {
    final current = _token;

    if (current == null) return;

    try {
      // Meminta Django menghapus token pengguna.
      await _apiClient.logout(token: current);
    } on ApiException catch (error) {
      // Jika request gagal, sesi lokal tetap akan dihapus.
      debugPrint('Logout gagal di server: ${error.statusCode}');
    } finally {
      // Selalu hapus token lokal, termasuk jika request gagal.
      _token = null;
      notifyListeners();
    }
  }
}
