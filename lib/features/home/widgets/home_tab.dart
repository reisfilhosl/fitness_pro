import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';
import '../../../shared/widgets/gamification_card.dart';
import '../../workout/screens/add_workout_screen.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final workouts = ref.watch(workoutsProvider);
    final weightEntries = ref.watch(weightEntriesProvider);

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final latestWeight = weightEntries.isNotEmpty 
        ? weightEntries.reduce((a, b) => a.date.isAfter(b.date) ? a : b)
        : null;

    final recentWorkouts = workouts.take(3).toList();
    final totalVolume = workouts.fold(0.0, (sum, workout) => sum + workout.totalVolume);

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${user.name.split(' ').first}!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implementar notificações
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card de Gamificação
            GamificationCard(
              level: user.level,
              totalXP: user.totalXP,
              currentStreak: user.currentStreak,
              longestStreak: user.longestStreak,
              badgesCount: 0, // TODO: Implementar contagem de badges
            ),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Cards de Progresso
            _buildProgressCards(context, user, latestWeight, totalVolume),
            
            // Treinos Recentes
            _buildRecentWorkouts(context, recentWorkouts),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Estatísticas Rápidas
            _buildQuickStats(context, user, workouts.length, totalVolume),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "home_fab",
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddWorkoutScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Novo Treino'),
      ),
    );
  }

  Widget _buildProgressCards(BuildContext context, user, latestWeight, totalVolume) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Seu Progresso',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        Row(
          children: [
            Expanded(
              child: _buildProgressCard(
                context,
                'Peso Atual',
                latestWeight?.weight.toStringAsFixed(1) ?? '--',
                'kg',
                Icons.monitor_weight,
                AppConstants.primaryColor,
              ),
            ),
            const SizedBox(width: AppConstants.defaultPadding),
            Expanded(
              child: _buildProgressCard(
                context,
                'Volume Total',
                (totalVolume / 1000).toStringAsFixed(1),
                't',
                Icons.fitness_center,
                Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressCard(
    BuildContext context,
    String title,
    String value,
    String unit,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildRecentWorkouts(BuildContext context, recentWorkouts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Treinos Recentes',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppConstants.defaultPadding),
        if (recentWorkouts.isEmpty)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                children: [
                  Icon(
                    Icons.fitness_center_outlined,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Nenhum treino registrado',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Toque no botão + para começar',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ...recentWorkouts.map((workout) => _buildWorkoutCard(context, workout)),
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
        subtitle: Text(
          '${workout.totalVolume.toStringAsFixed(0)}kg • ${workout.date.day}/${workout.date.month}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: () {
          // TODO: Navegar para detalhes do treino
        },
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, user, totalWorkouts, totalVolume) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estatísticas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(context, 'Treinos', totalWorkouts.toString(), Icons.fitness_center),
                _buildStatItem(context, 'XP Total', user.totalXP.toString(), Icons.star),
                _buildStatItem(context, 'Maior Streak', user.longestStreak.toString(), Icons.local_fire_department),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppConstants.primaryColor, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
