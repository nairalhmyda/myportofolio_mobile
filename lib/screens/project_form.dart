import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/project.dart';
import '../services/api_client.dart';
import '../services/auth_state.dart';
import '../widgets/auth_guard.dart';
import '../widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';
  bool _isSubmitting = false;

  String? _validateUrl(String? value, {bool optional = false}) {
    final text = (value ?? '').trim();
    if (optional && text.isEmpty) return null;
    final parsed = Uri.tryParse(text);
    if (parsed == null ||
        !(parsed.isScheme('http') || parsed.isScheme('https')) ||
        parsed.host.isEmpty) {
      return 'Gunakan URL lengkap, misalnya https://example.com';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _isSubmitting) return;

    final allowed = await ensureLoggedIn(context);
    if (!allowed || !mounted) return;
    final token = context.read<AuthState>().token;
    if (token == null) return;

    setState(() => _isSubmitting = true);
    try {
      final project = Project(
        title: _title.trim(),
        description: _description.trim(),
        techStack: _techStack.trim(),
        projectUrl: _projectUrl.trim(),
        projectImageUrl: _projectImageUrl.trim(),
      );

      await context.read<ApiClient>().createProject(project, token: token);
      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Proyek berhasil disimpan'),
          content: Text('Proyek "${project.title}" telah dikirim ke Django.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on ApiException catch (error) {
      if (!mounted) return;
      if (error.statusCode == 401) {
        await context.read<AuthState>().logout();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sesi berakhir. Silakan login ulang.')),
        );
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan proyek (HTTP ${error.statusCode}).')),
        );
      }
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat terhubung ke server.')),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Proyek')),
      drawer: const LeftDrawer(currentPage: DrawerDestination.project),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title', border: OutlineInputBorder(),
                ),
                onChanged: (value) => _title = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Judul proyek wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description', border: OutlineInputBorder(),
                ),
                onChanged: (value) => _description = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Deskripsi wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tech Stack', border: OutlineInputBorder(),
                ),
                onChanged: (value) => _techStack = value,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Teknologi wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Project URL', border: OutlineInputBorder(),
                ),
                onChanged: (value) => _projectUrl = value,
                validator: (value) => _validateUrl(value),
              ),
              const SizedBox(height: 12),
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Project Image URL (optional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => _projectImageUrl = value,
                validator: (value) => _validateUrl(value, optional: true),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20, width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Simpan ke Django'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
