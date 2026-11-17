import 'package:material_ui/material_ui.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  static const _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  String _projectName = '';
  String _description = '';
  String _category = _categories.first;
  String _technologies = '';
  String _projectLink = '';

  Widget _input({
    required String label,
    required ValueChanged<String> onChanged,
    bool isRequired = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        onChanged: onChanged,
        validator: (value) {
          if (isRequired && (value == null || value.trim().isEmpty)) {
            return '$label tidak boleh kosong.';
          }
          return null;
        },
      ),
    );
  }

  void _saveProject() {
    if (!_formKey.currentState!.validate()) return;

    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Proyek berhasil ditambahkan!'),
        scrollable: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Proyek: $_projectName'),
            Text('Deskripsi: $_description'),
            Text('Kategori: $_category'),
            Text('Teknologi: $_technologies'),
            Text('Tautan: $_projectLink'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _formKey.currentState!.reset();
              _projectName = '';
              _description = '';
              _category = _categories.first;
              _technologies = '';
              _projectLink = '';
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project Form')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _input(
                label: 'Nama Proyek',
                isRequired: true,
                onChanged: (value) => _projectName = value,
              ),
              _input(
                label: 'Deskripsi Proyek',
                isRequired: true,
                maxLines: 5,
                onChanged: (value) => _description = value,
              ),
              DropdownButtonFormField<String>(
                initialValue: _categories.first,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Kategori Proyek',
                  border: OutlineInputBorder(),
                ),
                items: [
                  for (final category in _categories)
                    DropdownMenuItem(value: category, child: Text(category)),
                ],
                onChanged: (value) => _category = value ?? _categories.first,
              ),
              const SizedBox(height: 12),
              _input(
                label: 'Teknologi yang Digunakan',
                onChanged: (value) => _technologies = value,
              ),
              _input(
                label: 'Tautan Proyek (opsional)',
                onChanged: (value) => _projectLink = value,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProject,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
