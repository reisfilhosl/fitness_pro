import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';

class ExportScreen extends ConsumerWidget {
  const ExportScreen({super.key});

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exportar Dados'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resumo dos dados
            _buildDataSummary(context, user, workouts.length, weightEntries.length),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Opções de export
            _buildExportOptions(context),
            
            const SizedBox(height: AppConstants.largePadding),
            
            // Informações sobre export
            _buildExportInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDataSummary(BuildContext context, user, int totalWorkouts, int totalWeightEntries) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo dos Dados',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'Treinos',
                    totalWorkouts.toString(),
                    Icons.fitness_center,
                    AppConstants.primaryColor,
                  ),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'Registros de Peso',
                    totalWeightEntries.toString(),
                    Icons.monitor_weight,
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'XP Total',
                    user.totalXP.toString(),
                    Icons.star,
                    Colors.amber,
                  ),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'Nível',
                    user.level.toString(),
                    Icons.trending_up,
                    Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(BuildContext context, String label, String value, IconData icon, Color color) {
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
        ),
      ],
    );
  }

  Widget _buildExportOptions(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            child: Text(
              'Formatos de Export',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          _buildExportOption(
            context,
            'Relatório PDF',
            'Gera um relatório completo com gráficos e estatísticas',
            Icons.picture_as_pdf,
            () => _exportPDF(context),
          ),
          const Divider(height: 1),
          _buildExportOption(
            context,
            'Dados CSV',
            'Exporta todos os dados em formato CSV para análise',
            Icons.table_chart,
            () => _exportCSV(context),
          ),
          const Divider(height: 1),
          _buildExportOption(
            context,
            'Backup Completo',
            'Cria um backup de todos os dados do app',
            Icons.backup,
            () => _exportBackup(context),
          ),
        ],
      ),
    );
  }

  Widget _buildExportOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.primaryColor),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _buildExportInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                Text(
                  'Informações sobre Export',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              '• Os dados são exportados com base na data atual',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '• O PDF inclui gráficos de evolução e estatísticas',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '• O CSV pode ser aberto no Excel ou Google Sheets',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              '• O backup pode ser usado para restaurar dados',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _exportPDF(BuildContext context) {
    // TODO: Implementar export PDF
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de export PDF em desenvolvimento'),
      ),
    );
  }

  void _exportCSV(BuildContext context) {
    // TODO: Implementar export CSV
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de export CSV em desenvolvimento'),
      ),
    );
  }

  void _exportBackup(BuildContext context) {
    // TODO: Implementar backup
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidade de backup em desenvolvimento'),
      ),
    );
  }
}
