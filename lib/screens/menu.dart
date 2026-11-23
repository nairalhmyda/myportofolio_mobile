import 'package:material_ui/material_ui.dart';

import 'project_list_page.dart';
import '../widgets/info_card.dart';
import '../widgets/project_card.dart';
import '../models/item_homepage.dart';
import 'project_form.dart';
import 'experience_form.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506532233";
  final String nama = "Naira Al Humayda";
  final String kelas = "PBP E";

  static const items = [
    ItemHomepage(
      'Lihat Proyek',
      Icons.folder,
      Color(0xFF1D4ED8),
      MenuAction.viewProjects,
    ),
    ItemHomepage(
      'Tambah Proyek',
      Icons.add_circle,
      Color(0xFF166534),
      MenuAction.addProject,
    ),
    ItemHomepage('Logout', Icons.logout, Color(0xFFB91C1C), MenuAction.logout),
    ItemHomepage(
      'Tambah Pengalaman',
      Icons.work_outline,
      Colors.deepPurple,
      MenuAction.addExperience,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur visual dasar halaman (AppBar, Body, SnackBar).
    return Scaffold(
      // AppBar menampilkan bar bagian atas halaman aplikasi.
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      // Body halaman utama dengan padding di sekelilingnya.
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal untuk menampilkan 3 InfoCard secara sejajar.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            // Bagian tengah: pesan sambutan dan kisi tombol menu portofolio.
            Center(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di MyPortfolio Mobile!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  // GridView menampilkan kartu tombol dalam tata letak kisi 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // shrinkWrap agar ukuran kisi menyesuaikan tinggi konten anak.
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(
                        item,
                        onPressed: () {
                          if (item.action == MenuAction.viewProjects) {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const ProjectListPage(),
                              ),
                            );
                          } else if (item.action == MenuAction.addProject) {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const ProjectFormPage(),
                              ),
                            );
                          } else if (item.action == MenuAction.addExperience) {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const ExperienceFormPage(),
                              ),
                            );
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
