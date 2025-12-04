import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:couldai_user_app/models/project.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  final List<Project> _projects = [];
  final _nameController = TextEditingController();
  final _uuid = const Uuid();

  void _addProject(String name) {
    if (name.isNotEmpty) {
      final newProject = Project(
        id: _uuid.v4(),
        name: name,
        createdAt: DateTime.now(),
      );
      setState(() {
        _projects.add(newProject);
      });
      _nameController.clear();
      Navigator.of(context).pop();
    }
  }

  void _editProject(Project project, String newName) {
    if (newName.isNotEmpty) {
      setState(() {
        project.name = newName;
      });
      _nameController.clear();
      Navigator.of(context).pop();
    }
  }

  void _deleteProject(Project project) {
    setState(() {
      _projects.remove(project);
    });
  }

  void _showProjectDialog({Project? project}) {
    if (project != null) {
      _nameController.text = project.name;
    } else {
      _nameController.clear();
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(project == null ? 'Nouveau Chantier' : 'Modifier le nom'),
          content: TextField(
            controller: _nameController,
            autofocus: true,
            decoration: const InputDecoration(labelText: 'Nom du chantier'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                if (project == null) {
                  _addProject(_nameController.text);
                } else {
                  _editProject(project, _nameController.text);
                }
              },
              child: const Text('Sauvegarder'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmation(Project project) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text('Êtes-vous sûr de vouloir supprimer le chantier "${project.name}" ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                _deleteProject(project);
                Navigator.of(context).pop();
              },
              child: const Text('Supprimer', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 30, errorBuilder: (context, error, stackTrace) => const Icon(Icons.construction, color: Colors.white)),
            const SizedBox(width: 10),
            const Text('Mes Chantiers'),
          ],
        ),
      ),
      body: _projects.isEmpty
          ? const Center(
              child: Text(
                'Aucun chantier pour le moment.\nAppuyez sur + pour en créer un.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: _projects.length,
              itemBuilder: (context, index) {
                final project = _projects[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6.0),
                  child: ListTile(
                    title: Text(project.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Créé le: ${DateFormat('dd/MM/yyyy HH:mm').format(project.createdAt)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blueGrey),
                          onPressed: () => _showProjectDialog(project: project),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _showDeleteConfirmation(project),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/project_map',
                        arguments: project,
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showProjectDialog(),
        tooltip: 'Nouveau Chantier',
        child: const Icon(Icons.add),
      ),
    );
  }
}
