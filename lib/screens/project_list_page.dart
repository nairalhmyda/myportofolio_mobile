
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';
import '../services/api_client.dart';
import 'project_detail_screen.dart';
import '../widgets/left_drawer.dart';

class ProjectListPage extends StatefulWidget {
  const ProjectListPage({super.key});

  @override
  State<ProjectListPage> createState() => _ProjectListPageState();
}

class _ProjectListPageState extends State<ProjectListPage> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();

    // Mengambil data proyek sekali saat halaman pertama dibuka.
    _projectsFuture = context.read<ApiClient>().getProjects();
  }

  // Mengambil ulang data ketika pengguna melakukan refresh.
  Future<void> _reload() async {
    final future = context.read<ApiClient>().getProjects();

    setState(() {
      _projectsFuture = future;
    });

    try {
      await future;
    } catch (_) {
      // Error akan ditampilkan oleh FutureBuilder.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Proyek'),
      ),

      drawer: const LeftDrawer(
        currentPage: DrawerDestination.projects,
      ),

      body: FutureBuilder<List<Project>>(
        future: _projectsFuture,
        builder: (context, snapshot) {

          // 1. Ketika data masih diambil dari Django.
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // 2. Ketika permintaan API gagal.
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Gagal memuat daftar proyek.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          // 3. Ketika data berhasil diterima.
          final projects = snapshot.data ?? <Project>[];

          // 4. Ketika Django belum memiliki proyek.
          if (projects.isEmpty) {
            return RefreshIndicator(
              onRefresh: _reload,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 150),
                  Center(
                    child: Text('Belum ada proyek.'),
                  ),
                ],
              ),
            );
          }

          // 5. Ketika Django memiliki daftar proyek.
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                final project = projects[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.folder),
                    title: Text(project.title),
                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(project.techStack),
                        Text(
                          project.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) =>
                              ProjectDetailScreen(project: project),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
