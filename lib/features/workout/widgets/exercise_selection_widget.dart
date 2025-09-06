import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/exercise.dart';
import '../../../shared/providers/app_providers.dart';

class ExerciseSelectionWidget extends ConsumerStatefulWidget {
  final Function(Exercise) onExerciseSelected;

  const ExerciseSelectionWidget({
    super.key,
    required this.onExerciseSelected,
  });

  @override
  ConsumerState<ExerciseSelectionWidget> createState() => _ExerciseSelectionWidgetState();
}

class _ExerciseSelectionWidgetState extends ConsumerState<ExerciseSelectionWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Todos';
  String _selectedMuscleGroup = 'Todos';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exercises = ref.watch(exercisesProvider);
    
    // Filtrar exercícios
    var filteredExercises = exercises;
    
    // Filtro por categoria
    if (_selectedCategory != 'Todos') {
      filteredExercises = filteredExercises.where((exercise) => 
        exercise.category.displayName == _selectedCategory
      ).toList();
    }
    
    // Filtro por grupo muscular
    if (_selectedMuscleGroup != 'Todos') {
      filteredExercises = filteredExercises.where((exercise) => 
        exercise.muscleGroup.displayName == _selectedMuscleGroup
      ).toList();
    }
    
    // Filtro por busca
    if (_searchController.text.isNotEmpty) {
      filteredExercises = filteredExercises.where((exercise) => 
        exercise.name.toLowerCase().contains(_searchController.text.toLowerCase())
      ).toList();
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Text(
                'Selecionar Exercício',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          
          // Barra de busca
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar exercícios...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          
          // Filtros
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Categoria',
                    isDense: true,
                  ),
                  items: ['Todos', ...AppConstants.exerciseCategories]
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value!;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppConstants.defaultPadding),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedMuscleGroup,
                  decoration: const InputDecoration(
                    labelText: 'Grupo Muscular',
                    isDense: true,
                  ),
                  items: ['Todos', ...AppConstants.muscleGroups]
                      .map((group) => DropdownMenuItem(
                            value: group,
                            child: Text(group),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedMuscleGroup = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          
          // Lista de exercícios
          Expanded(
            child: filteredExercises.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      final exercise = filteredExercises[index];
                      return _buildExerciseCard(exercise);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          Text(
            'Nenhum exercício encontrado',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: AppConstants.smallPadding),
          Text(
            'Tente ajustar os filtros ou termo de busca',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppConstants.muscleGroupColors[exercise.muscleGroup.name]?.let((color) => Color(color).withOpacity(0.1)) ?? 
                          AppConstants.primaryColor.withOpacity(0.1),
          child: Icon(
            _getExerciseIcon(exercise.category),
            color: AppConstants.muscleGroupColors[exercise.muscleGroup.name]?.let((color) => Color(color)) ?? 
                   AppConstants.primaryColor,
          ),
        ),
        title: Text(
          exercise.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${exercise.category.displayName} • ${exercise.muscleGroup.displayName}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (exercise.equipment != null)
              Text(
                'Equipamento: ${exercise.equipment}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
          ],
        ),
        trailing: Icon(
          Icons.add_circle_outline,
          color: AppConstants.primaryColor,
        ),
        onTap: () => widget.onExerciseSelected(exercise),
      ),
    );
  }

  IconData _getExerciseIcon(ExerciseCategory category) {
    switch (category) {
      case ExerciseCategory.aerobic:
        return Icons.directions_run;
      case ExerciseCategory.anaerobic:
        return Icons.fitness_center;
    }
  }
}

extension NullableExtension<T> on T? {
  R? let<R>(R Function(T) block) {
    if (this != null) {
      return block(this as T);
    }
    return null;
  }
}

