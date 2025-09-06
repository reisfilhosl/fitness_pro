import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/workout.dart';

class WorkoutExerciseCard extends StatefulWidget {
  final WorkoutExercise exercise;
  final Function(WorkoutExercise) onUpdate;
  final VoidCallback onRemove;

  const WorkoutExerciseCard({
    super.key,
    required this.exercise,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  State<WorkoutExerciseCard> createState() => _WorkoutExerciseCardState();
}

class _WorkoutExerciseCardState extends State<WorkoutExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header do exercício
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exercise.exercise.name,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        '${widget.exercise.exercise.category.name} • ${widget.exercise.exercise.muscleGroup.name}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: widget.onRemove,
                  icon: const Icon(Icons.close, color: Colors.red),
                ),
              ],
            ),
            
            const SizedBox(height: AppConstants.defaultPadding),
            
            // Lista de séries
            ...widget.exercise.sets.asMap().entries.map((entry) {
              final index = entry.key;
              final set = entry.value;
              return _buildSetRow(index, set);
            }),
            
            const SizedBox(height: AppConstants.smallPadding),
            
            // Botão para adicionar série
            TextButton.icon(
              onPressed: _addSet,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Série'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetRow(int index, WorkoutSet set) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
      padding: const EdgeInsets.all(AppConstants.smallPadding),
      decoration: BoxDecoration(
        color: set.completed 
            ? AppConstants.primaryColor.withOpacity(0.1)
            : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: set.completed 
              ? AppConstants.primaryColor.withOpacity(0.3)
              : Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          // Número da série
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: set.completed 
                  ? AppConstants.primaryColor
                  : Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          
          const SizedBox(width: AppConstants.smallPadding),
          
          // Peso
          Expanded(
            flex: 2,
            child: TextFormField(
              initialValue: set.weight > 0 ? set.weight.toString() : '',
              decoration: const InputDecoration(
                labelText: 'Peso',
                suffixText: 'kg',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final weight = double.tryParse(value) ?? 0.0;
                _updateSet(index, set.copyWith(weight: weight));
              },
            ),
          ),
          
          const SizedBox(width: AppConstants.smallPadding),
          
          // Repetições
          Expanded(
            flex: 2,
            child: TextFormField(
              initialValue: set.reps > 0 ? set.reps.toString() : '',
              decoration: const InputDecoration(
                labelText: 'Reps',
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final reps = int.tryParse(value) ?? 0;
                _updateSet(index, set.copyWith(reps: reps));
              },
            ),
          ),
          
          const SizedBox(width: AppConstants.smallPadding),
          
          // Checkbox de concluído
          Checkbox(
            value: set.completed,
            onChanged: (value) {
              _updateSet(index, set.copyWith(completed: value ?? false));
            },
          ),
          
          // Botão de remover série
          IconButton(
            onPressed: () => _removeSet(index),
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  void _addSet() {
    final newSet = WorkoutSet(
      id: const Uuid().v4(),
      weight: 0.0,
      reps: 0,
    );
    
    final updatedExercise = widget.exercise.copyWith(
      sets: [...widget.exercise.sets, newSet],
    );
    
    widget.onUpdate(updatedExercise);
  }

  void _removeSet(int index) {
    if (widget.exercise.sets.length <= 1) return;
    
    final updatedSets = List<WorkoutSet>.from(widget.exercise.sets);
    updatedSets.removeAt(index);
    
    final updatedExercise = widget.exercise.copyWith(sets: updatedSets);
    widget.onUpdate(updatedExercise);
  }

  void _updateSet(int index, WorkoutSet updatedSet) {
    final updatedSets = List<WorkoutSet>.from(widget.exercise.sets);
    updatedSets[index] = updatedSet;
    
    final updatedExercise = widget.exercise.copyWith(sets: updatedSets);
    widget.onUpdate(updatedExercise);
  }
}
