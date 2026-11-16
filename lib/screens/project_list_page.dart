import 'package:flutter/material.dart';

class PortfolioProject {
  final String title;
  final String description;
  final String technologies;

  const PortfolioProject({
    required this.title,
    required this.description,
    required this.technologies,
  });
}

const projects = [
  PortfolioProject(
    title: 'MyPortfolio Web',
    description:
        'Website untuk menampilkan proyek-proyek yang pernah aku buat.',
    technologies: 'Django, HTML, CSS, JavaScript',
  ),
  PortfolioProject(
    title: 'Saved Recipe',
    description: 'website untuk menyimpan dan mengelompokkan resep.',
    technologies: 'Django, HTML, CSS, JavaScript',
  ),
];

class ProjectListPage extends StatelessWidget {
  const ProjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Proyek')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (final project in projects)
            Card(
              child: ExpansionTile(
                title: Text(project.title),
                children: [
                  ListTile(
                    title: Text(project.description),
                    subtitle: Text('Teknologi: ${project.technologies}'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
