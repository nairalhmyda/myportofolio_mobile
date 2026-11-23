import 'package:material_ui/material_ui.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _nama = '';
  String _peran = '';
  String _deskripsi = '';
  String? _jenis;

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ringkasan Pengalaman'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama: $_nama'),
              Text('Peran: $_peran'),
              Text('Jenis: $_jenis'),
              Text('Deskripsi: $_deskripsi'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Pengalaman')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama Kegiatan',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() => _nama = value);
                  },
                  validator: (value) {
                    final teks = value?.trim() ?? '';
                    if (teks.isEmpty) {
                      return 'Nama kegiatan wajib diisi';
                    }
                    if (teks.length < 3) {
                      return 'Minimal 3 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Peran atau Jabatan',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() => _peran = value);
                  },
                  validator: (value) {
                    final teks = value?.trim() ?? '';
                    if (teks.isEmpty) {
                      return 'Peran wajib diisi';
                    }
                    if (teks.length < 2) {
                      return 'Minimal 2 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Jenis Pengalaman',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Organisasi',
                      child: Text('Organisasi'),
                    ),
                    DropdownMenuItem(value: 'Magang', child: Text('Magang')),
                    DropdownMenuItem(
                      value: 'Volunteer',
                      child: Text('Volunteer'),
                    ),
                    DropdownMenuItem(value: 'Lomba', child: Text('Lomba')),
                  ],
                  onChanged: (value) {
                    setState(() => _jenis = value);
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Pilih jenis pengalaman';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Deskripsi Pengalaman',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() => _deskripsi = value);
                  },
                  validator: (value) {
                    final teks = value?.trim() ?? '';
                    if (teks.isEmpty) {
                      return 'Deskripsi wajib diisi';
                    }
                    if (teks.length < 10) {
                      return 'Minimal 10 karakter';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),

                const SizedBox(height: 24),

                const Text(
                  'Preview Pengalaman',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                Card(
                  child: ListTile(
                    title: Text(
                      _nama.isEmpty ? 'Nama kegiatan belum diisi' : _nama,
                    ),
                    subtitle: Text(
                      'Peran: $_peran\n'
                      'Jenis: ${_jenis ?? "Belum dipilih"}\n'
                      'Deskripsi: $_deskripsi',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
