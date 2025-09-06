import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';
import '../../workout/screens/add_workout_screen.dart';

class ActivityTab extends ConsumerWidget {
  const ActivityTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutsProvider);
    final user = ref.watch(userProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Agrupar treinos por data
    final groupedWorkouts = _groupWorkoutsByDate(workouts);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atividade'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Implementar filtros
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Card de Hoje
          _buildTodayCard(context, ref),
          
          // Lista de treinos
          Expanded(
            child: groupedWorkouts.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: const EdgeInsets.all(AppConstants.defaultPadding),
                    itemCount: groupedWorkouts.length,
                    itemBuilder: (context, index) {
                      final entry = groupedWorkouts.entries.elementAt(index);
                      return _buildDateGroup(context, entry.key, entry.value);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton.extended(
          heroTag: "activity_fab",
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AddWorkoutScreen(),
              ),
            );
          },
          icon: const Icon(Icons.add, size: 20),
          label: const Text(
            'Novo Treino',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayCard(BuildContext context, WidgetRef ref) {
    final today = DateTime.now();
    final todayWorkouts = ref.watch(workoutsProvider)
        .where((workout) => 
            workout.date.year == today.year &&
            workout.date.month == today.month &&
            workout.date.day == today.day)
        .toList();

    return Container(
      margin: const EdgeInsets.all(0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.today,
                    color: AppConstants.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Hoje',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  if (todayWorkouts.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${todayWorkouts.length} treino${todayWorkouts.length > 1 ? 's' : ''}',
                        style: TextStyle(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppConstants.defaultPadding),
              if (todayWorkouts.isEmpty)
                Column(
                  children: [
                    Icon(
                      Icons.fitness_center_outlined,
                      size: 48,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Nenhum treino hoje',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Que tal começar agora?',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                )
              else
                ...todayWorkouts.map((workout) => _buildWorkoutSummary(context, workout)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutSummary(BuildContext context, workout) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppConstants.primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            color: AppConstants.primaryColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${workout.exercises.length} exercícios',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  '${workout.totalVolume.toStringAsFixed(0)}kg • ${DateFormat('HH:mm').format(workout.date)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
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
              'Nenhum treino registrado',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              'Comece sua jornada fitness registrando seu primeiro treino!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.largePadding),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddWorkoutScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Primeiro Treino'),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<dynamic>> _groupWorkoutsByDate(List<dynamic> workouts) {
    final Map<String, List<dynamic>> grouped = {};
    
    for (final workout in workouts) {
      final dateKey = DateFormat('dd/MM/yyyy').format(workout.date);
      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(workout);
    }
    
    // Ordenar por data (mais recente primeiro)
    final sortedEntries = grouped.entries.toList()
      ..sort((a, b) {
        final dateA = DateFormat('dd/MM/yyyy').parse(a.key);
        final dateB = DateFormat('dd/MM/yyyy').parse(b.key);
        return dateB.compareTo(dateA);
      });
    
    return Map.fromEntries(sortedEntries);
  }

  Widget _buildDateGroup(BuildContext context, String date, List<dynamic> workouts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
          child: Text(
            date,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppConstants.primaryColor,
            ),
          ),
        ),
        ...workouts.map((workout) => _buildWorkoutCard(context, workout)),
        const SizedBox(height: AppConstants.defaultPadding),
      ],
    );
  }

  Widget _buildWorkoutCard(BuildContext context, workout) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppConstants.smallPadding),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
          child: Icon(
            Icons.fitness_center,
            color: AppConstants.primaryColor,
          ),
        ),
        title: Text(
          '${workout.exercises.length} exercícios',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${workout.totalVolume.toStringAsFixed(0)}kg de volume total',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (workout.duration != null)
              Text(
                'Duração: ${workout.duration!.inMinutes}min',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            Text(
              DateFormat('HH:mm').format(workout.date),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'view',
              child: Row(
                children: [
                  Icon(Icons.visibility),
                  SizedBox(width: 8),
                  Text('Ver detalhes'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'duplicate',
              child: Row(
                children: [
                  Icon(Icons.copy),
                  SizedBox(width: 8),
                  Text('Duplicar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Excluir', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case 'view':
                _showWorkoutDetails(context, workout);
                break;
              case 'edit':
                _editWorkout(context, workout);
                break;
              case 'duplicate':
                _duplicateWorkout(context, workout);
                break;
              case 'delete':
                _showDeleteDialog(context, workout);
                break;
            }
          },
        ),
        onTap: () {
          _showWorkoutDetails(context, workout);
        },
      ),
    );
  }

  void _showWorkoutDetails(BuildContext context, workout) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    'Detalhes do Treino',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailCard(
                      context,
                      'Data e Hora',
                      DateFormat('dd/MM/yyyy HH:mm').format(workout.date),
                      Icons.calendar_today,
                    ),
                    _buildDetailCard(
                      context,
                      'Exercícios',
                      '${workout.exercises.length} exercícios',
                      Icons.fitness_center,
                    ),
                    _buildDetailCard(
                      context,
                      'Volume Total',
                      '${workout.totalVolume.toStringAsFixed(0)}kg',
                      Icons.scale,
                    ),
                    if (workout.duration != null)
                      _buildDetailCard(
                        context,
                        'Duração',
                        '${workout.duration!.inMinutes} minutos',
                        Icons.timer,
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Exercícios',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    ...workout.exercises.map((exercise) => _buildExerciseItem(context, exercise)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context, String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF8E8E93),
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseItem(BuildContext context, exercise) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E5EA)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${exercise.sets.length} séries',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF8E8E93),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _editWorkout(BuildContext context, workout) {
    // TODO: Implementar edição de treino
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de edição será implementada em breve'),
      ),
    );
  }

  void _duplicateWorkout(BuildContext context, workout) {
    // TODO: Implementar duplicação de treino
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de duplicação será implementada em breve'),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, workout) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Treino'),
        content: const Text('Tem certeza que deseja excluir este treino?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implementar exclusão
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade de exclusão será implementada em breve'),
                ),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
