import 'package:flutter/material.dart';

class NotesEmptyState extends StatelessWidget {
  final VoidCallback onExploreCourses;

  const NotesEmptyState({
    super.key,
    required this.onExploreCourses,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 56,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'Nenhuma anotação encontrada',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Selecione outro filtro ou crie anotações em seus cursos.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: onExploreCourses,
            child: const Text('Explorar cursos'),
          ),
        ],
      ),
    );
  }
}
