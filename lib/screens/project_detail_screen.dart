import 'package:flutter/material.dart';

import '../models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Proyek')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(project.title, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          if (project.projectImageUrl.trim().isNotEmpty) ...[
            Image.network(
              project.projectImageUrl,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Text('Gambar tidak dapat dimuat.'),
            ),
            const SizedBox(height: 16),
          ],
          const Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(project.description),
          const SizedBox(height: 16),
          const Text('Teknologi', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(project.techStack),
          const SizedBox(height: 16),
          const Text('Tautan Proyek', style: TextStyle(fontWeight: FontWeight.bold)),
          SelectableText(project.projectUrl),
        ],
      ),
    );
  }
}
