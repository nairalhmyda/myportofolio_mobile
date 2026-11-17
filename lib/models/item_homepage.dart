import 'package:material_ui/material_ui.dart';

enum MenuAction { viewProjects, addProject, logout }

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final MenuAction action;

  const ItemHomepage(this.name, this.icon, this.color, this.action);
}
