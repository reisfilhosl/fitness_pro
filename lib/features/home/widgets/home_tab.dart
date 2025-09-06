import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';
import '../../../shared/providers/gamification_provider.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/gamification_card.dart';
import '../../workout/screens/add_workout_screen.dart';

class HomeTab extends ConsumerWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final workouts = ref.watch(workoutsProvider);
    final weightEntries = ref.watch(weightEntriesProvider);
    final gamificationStats = ref.watch(gamificationProvider);

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
        title: Row(
          children: [
            const AppLogo(width: 32, height: 32),
            const SizedBox(width: 12),
            Text(
              'Olá, ${user.name.split(' ').first}!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFFE5E5EA),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  size: 20,
                ),
              ),
              onPressed: () {
                // TODO: Implementar notificações
              },
            ),
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
              level: gamificationStats['level'] ?? user.level,
              totalXP: gamificationStats['totalXP'] ?? user.totalXP,
              currentStreak: gamificationStats['streak'] ?? user.currentStreak,
              longestStreak: user.longestStreak,
              badgesCount: gamificationStats['unlockedBadges'] ?? 0,
            ),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Cards de Progresso
            _buildProgressCards(context, user, latestWeight, totalVolume),
            const SizedBox(height: AppConstants.largePadding),

            // Treinos Recentes
            _buildRecentWorkouts(context, recentWorkouts),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Estatísticas Rápidas
            _buildQuickStats(context, user, workouts.length, totalVolume),
          ],
        ),
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
          heroTag: "home_fab",
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
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: const Color(0xFF8E8E93),
                fontWeight: FontWeight.w500,
              ),
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
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  unit,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
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
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8E8E93).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.fitness_center_outlined,
                      size: 32,
                      color: const Color(0xFF8E8E93),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum treino registrado',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF1C1C1E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Toque no botão + para começar',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF8E8E93),
                    ),
                    textAlign: TextAlign.center,
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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Navegar para detalhes do treino
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.fitness_center,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${workout.exercises.length} exercícios',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${workout.totalVolume.toStringAsFixed(0)}kg • ${workout.date.day}/${workout.date.month}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF8E8E93),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: const Color(0xFF8E8E93),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, user, totalWorkouts, totalVolume) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Estatísticas',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
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
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon, 
            color: Theme.of(context).colorScheme.primary, 
            size: 20,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF8E8E93),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
