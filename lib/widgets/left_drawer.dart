import 'package:material_ui/material_ui.dart';

import '../screens/menu.dart';
import '../screens/project_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key, required this.isHome});

  final bool isHome;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'My Portfolio\nExplore personal projects and experiences!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              if (isHome) return;

              navigator.pushReplacement(
                MaterialPageRoute<void>(builder: (_) => const MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              if (!isHome) return;

              navigator.pushReplacement(
                MaterialPageRoute<void>(
                  builder: (_) => const ProjectFormPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
