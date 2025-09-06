import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';
import '../../../shared/widgets/badge_grid.dart';
import '../../profile/screens/edit_profile_screen.dart';
import '../../profile/screens/settings_screen.dart';
import '../../profile/screens/export_screen.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            // Card do Usuário
            _buildUserCard(context, user, latestWeight),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Estatísticas
            _buildStatsSection(context, user, workouts.length, weightEntries.length),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Badges
            _buildBadgesSection(context, ref, user),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Ações
            _buildActionsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, user, latestWeight) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppConstants.primaryColor.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: AppConstants.primaryColor,
                  ),
                ),
                const SizedBox(width: AppConstants.defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Nível ${user.level}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppConstants.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${user.age} anos • ${user.gender}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (latestWeight != null)
                        Text(
                          '${latestWeight.weight.toStringAsFixed(1)}kg',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EditProfileScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context, user, totalWorkouts, totalWeightEntries) {
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
              children: [
                Flexible(
                  child: _buildStatItem(
                    context,
                    'Treinos',
                    totalWorkouts.toString(),
                    Icons.fitness_center,
                    AppConstants.primaryColor,
                  ),
                ),
                Flexible(
                  child: _buildStatItem(
                    context,
                    'XP Total',
                    user.totalXP.toString(),
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                Flexible(
                  child: _buildStatItem(
                    context,
                    'Streak',
                    '${user.currentStreak} dias',
                    Icons.local_fire_department,
                    Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              children: [
                Flexible(
                  child: _buildStatItem(
                    context,
                    'Maior Streak',
                    '${user.longestStreak} dias',
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
                Flexible(
                  child: _buildStatItem(
                    context,
                    'Registros de Peso',
                    totalWeightEntries.toString(),
                    Icons.monitor_weight,
                    Colors.blue,
                  ),
                ),
                Flexible(
                  child: _buildStatItem(
                    context,
                    'Membro desde',
                    DateFormat('MMM/yyyy').format(user.createdAt),
                    Icons.calendar_today,
                    Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBadgesSection(BuildContext context, WidgetRef ref, user) {
    final badges = ref.watch(badgesProvider);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Conquistas',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Navegar para tela de badges
                  },
                  child: const Text('Ver todas'),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            SizedBox(
              height: 200,
              child: BadgeGrid(
                badges: badges,
                showUnlockedOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildActionTile(
            context,
            'Editar Perfil',
            'Atualize suas informações pessoais',
            Icons.person,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),
          _buildActionTile(
            context,
            'Exportar Dados',
            'Baixe seus dados em PDF ou CSV',
            Icons.download,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ExportScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),
          _buildActionTile(
            context,
            'Configurações',
            'Preferências e configurações do app',
            Icons.settings,
            () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsScreen(),
                ),
              );
            },
          ),
          const Divider(height: 1),
          _buildActionTile(
            context,
            'Sobre',
            'Informações sobre o MuvviFit',
            Icons.info,
            () {
              _showAboutDialog(context);
            },
          ),
          const Divider(height: 1),
          _buildActionTile(
            context,
            'Sair',
            'Encerrar sessão',
            Icons.logout,
            () {
              _showLogoutDialog(context);
            },
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red : AppConstants.primaryColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'MuvviFit',
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.fitness_center,
        size: 48,
        color: AppConstants.primaryColor,
      ),
      children: [
        const Text('Seu companheiro de treino minimalista e moderno.'),
        const SizedBox(height: 16),
        const Text('Desenvolvido com Flutter e muito ❤️'),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Tem certeza que deseja sair?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // TODO: Implementar logout
              Navigator.of(context).pop();
            },
            child: const Text('Sair', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
