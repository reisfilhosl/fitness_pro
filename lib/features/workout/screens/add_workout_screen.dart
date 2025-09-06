import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/models/workout.dart';
import '../../../shared/providers/app_providers.dart';
import '../widgets/exercise_selection_widget.dart';
import '../widgets/workout_exercise_card.dart';

class AddWorkoutScreen extends ConsumerStatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  ConsumerState<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends ConsumerState<AddWorkoutScreen> {
  final List<WorkoutExercise> _exercises = [];
  final DateTime _workoutDate = DateTime.now();
  String? _notes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Treino'),
        actions: [
          if (_exercises.isNotEmpty)
            TextButton(
              onPressed: _saveWorkout,
              child: const Text('Salvar'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Data do treino
          _buildWorkoutDateCard(),
          
          // Lista de exercícios
          Expanded(
            child: _exercises.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    itemCount: _exercises.length,
                    itemBuilder: (context, index) {
                      return WorkoutExerciseCard(
                        exercise: _exercises[index],
                        onUpdate: (updatedExercise) {
                          setState(() {
                            _exercises[index] = updatedExercise;
                          });
                        },
                        onRemove: () {
                          setState(() {
                            _exercises.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "add_workout_fab",
        onPressed: _showExerciseSelection,
        icon: const Icon(Icons.add),
        label: const Text('Adicionar Exercício'),
      ),
    );
  }

  Widget _buildWorkoutDateCard() {
    return Card(
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today,
              color: AppConstants.primaryColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data do Treino',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${_workoutDate.day}/${_workoutDate.month}/${_workoutDate.year}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: _selectDate,
              child: const Text('Alterar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fitness_center_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: AppConstants.largePadding),
            Text(
              'Nenhum exercício adicionado',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              'Toque no botão + para adicionar exercícios ao seu treino',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _workoutDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (selectedDate != null) {
      setState(() {
        // Atualizar a data do treino
      });
    }
  }

  void _showExerciseSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ExerciseSelectionWidget(
        onExerciseSelected: (exercise) {
          _addExercise(exercise);
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _addExercise(exercise) {
    final workoutExercise = WorkoutExercise(
      id: const Uuid().v4(),
      exercise: exercise,
      sets: [
        WorkoutSet(
          id: const Uuid().v4(),
          weight: 0.0,
          reps: 0,
        ),
      ],
    );

    setState(() {
      _exercises.add(workoutExercise);
    });
  }

  void _saveWorkout() async {
    if (_exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adicione pelo menos um exercício'),
        ),
      );
      return;
    }

    // Calcular volume total
    final totalVolume = _exercises.fold(0.0, (sum, exercise) => sum + exercise.totalVolume);

    final workout = Workout(
      id: const Uuid().v4(),
      date: _workoutDate,
      exercises: _exercises,
      totalVolume: totalVolume,
      notes: _notes,
    );

    await ref.read(workoutsProvider.notifier).addWorkout(workout);
    
    // Atualizar streak do usuário
    await ref.read(userProvider.notifier).updateStreak();
    
    // Adicionar XP baseado no volume
    final xp = AppConstants.baseXPPerWorkout + (totalVolume * 0.1).round();
    await ref.read(userProvider.notifier).addXP(xp);

    if (mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Treino salvo! +$xp XP'),
          backgroundColor: AppConstants.primaryColor,
        ),
      );
    }
  }
}
