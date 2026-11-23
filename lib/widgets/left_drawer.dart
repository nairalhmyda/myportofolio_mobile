import 'package:material_ui/material_ui.dart';

import '../screens/menu.dart';
import '../screens/project_form.dart';
import '../screens/experience_form.dart';

enum DrawerDestination { home, project, experience }

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.currentPage});

  final DrawerDestination currentPage;

  void _goTo(BuildContext context, Widget page, DrawerDestination destination) {
    final navigator = Navigator.of(context);

    // Tutup drawer terlebih dahulu
    navigator.pop();

    // Jangan membuka ulang halaman yang sama
    if (currentPage == destination) return;

    if (destination == DrawerDestination.home) {
      // Kembali ke Home dan bersihkan riwayat halaman
      navigator.pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const MyHomePage()),
        (route) => false,
      );
    } else {
      // Ganti halaman sekarang dengan tujuan baru
      navigator.pushReplacement(MaterialPageRoute<void>(builder: (_) => page));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'MyPortfolio',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () =>
                _goTo(context, const MyHomePage(), DrawerDestination.home),
          ),

          ListTile(
            leading: const Icon(Icons.add_circle),
            title: const Text('Add Project'),
            onTap: () => _goTo(
              context,
              const ProjectFormPage(),
              DrawerDestination.project,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.work),
            title: const Text('Add Experience'),
            onTap: () => _goTo(
              context,
              const ExperienceFormPage(),
              DrawerDestination.experience,
            ),
          ),
        ],
      ),
    );
  }
}
