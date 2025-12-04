import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/project.dart';

class ProjectMapScreen extends StatelessWidget {
  const ProjectMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = ModalRoute.of(context)!.settings.arguments as Project?;

    return Scaffold(
      appBar: AppBar(
        title: Text(project?.name ?? 'Détails du Chantier'),
      ),
      body: Center(
        child: Text('Carte pour le chantier: ${project?.name ?? 'N/A'}'),
      ),
    );
  }
}
