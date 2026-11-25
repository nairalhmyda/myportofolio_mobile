import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/experience_form.dart';
import '../screens/login_screen.dart';
import '../screens/project_form.dart';
import '../screens/project_list_page.dart';
import '../services/auth_state.dart';
import 'auth_guard.dart';

enum DrawerDestination { home, projects, project, experience }

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.currentPage});

  final DrawerDestination currentPage;

  Future<void> _open(BuildContext context, DrawerDestination destination) async {
    // Buka login sebelum menutup drawer agar BuildContext masih valid.
    if (destination == DrawerDestination.project) {
      final allowed = await ensureLoggedIn(context);
      if (!allowed || !context.mounted) return;
    }
    if (!context.mounted) return;

    final navigator = Navigator.of(context);
    navigator.pop(); // Tutup drawer.
    if (currentPage == destination) return;

    if (destination == DrawerDestination.home) {
      navigator.popUntil((route) => route.isFirst);
      return;
    }

    final Widget target = switch (destination) {
      DrawerDestination.projects => const ProjectListPage(),
      DrawerDestination.project => const ProjectFormPage(),
      DrawerDestination.experience => const ExperienceFormPage(),
      DrawerDestination.home => const SizedBox.shrink(),
    };
    navigator.push(MaterialPageRoute<void>(builder: (_) => target));
  }

  Future<void> _logout(BuildContext context) async {
    final navigator = Navigator.of(context);
    final auth = context.read<AuthState>();
    navigator.pop(); // Tutup drawer sebelum request.
    try {
      await auth.logout();
    } catch (_) {
      // Meskipun request jaringan gagal, AuthState menghapus token lokal.
    }
    if (!navigator.mounted) return;
    // Pengguna tidak boleh tertinggal di formulir yang membutuhkan login.
    if (currentPage != DrawerDestination.home) {
      navigator.popUntil((route) => route.isFirst);
    }
    ScaffoldMessenger.of(navigator.context).showSnackBar(
      const SnackBar(content: Text('Kamu telah logout.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthState>().isLoggedIn;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'MyPortfolio\nExplore your projects and experiences!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _open(context, DrawerDestination.home),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('Lihat Proyek'),
            onTap: () => _open(context, DrawerDestination.projects),
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () => _open(context, DrawerDestination.project),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Add Experience'),
            onTap: () => _open(context, DrawerDestination.experience),
          ),
          if (!isLoggedIn)
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Login'),
              onTap: () {
                final navigator = Navigator.of(context);
                navigator.pop();
                navigator.push<bool>(
                  MaterialPageRoute<bool>(builder: (_) => const LoginScreen()),
                );
              },
            )
          else
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () => _logout(context),
            ),
        ],
      ),
    );
  }
}
