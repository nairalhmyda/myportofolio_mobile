import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../services/auth_state.dart';

/// Kembalikan true jika sudah login, atau berhasil login melalui layar Login.
Future<bool> ensureLoggedIn(BuildContext context) async {
  if (context.read<AuthState>().isLoggedIn) return true;

  final loggedIn = await Navigator.of(context).push<bool>(
    MaterialPageRoute<bool>(builder: (_) => const LoginScreen()),
  );
  return loggedIn ?? false;
}
