import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../shared/providers/app_providers.dart';

class ChartsTab extends ConsumerStatefulWidget {
  const ChartsTab({super.key});

  @override
  ConsumerState<ChartsTab> createState() => _ChartsTabState();
}

class _ChartsTabState extends ConsumerState<ChartsTab> with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = '7d';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weightEntries = ref.watch(weightEntriesProvider);
    final workouts = ref.watch(workoutsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráficos'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Peso', icon: Icon(Icons.monitor_weight)),
            Tab(text: 'Treinos', icon: Icon(Icons.fitness_center)),
            Tab(text: 'Volume', icon: Icon(Icons.bar_chart)),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: '7d',
                child: Text('7 dias'),
              ),
              const PopupMenuItem(
                value: '30d',
                child: Text('30 dias'),
              ),
              const PopupMenuItem(
                value: '90d',
                child: Text('90 dias'),
              ),
              const PopupMenuItem(
                value: '1y',
                child: Text('1 ano'),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_getPeriodLabel(_selectedPeriod)),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildWeightChart(weightEntries),
          _buildWorkoutsChart(workouts),
          _buildVolumeChart(workouts),
        ],
      ),
    );
  }

  String _getPeriodLabel(String period) {
    switch (period) {
      case '7d': return '7 dias';
      case '30d': return '30 dias';
      case '90d': return '90 dias';
      case '1y': return '1 ano';
      default: return '7 dias';
    }
  }

  List<dynamic> _getFilteredData(List<dynamic> data, String period) {
    final now = DateTime.now();
    final cutoff = now.subtract(Duration(days: _getDaysForPeriod(period)));
    
    return data.where((item) => item.date.isAfter(cutoff)).toList();
  }

  int _getDaysForPeriod(String period) {
    switch (period) {
      case '7d': return 7;
      case '30d': return 30;
      case '90d': return 90;
      case '1y': return 365;
      default: return 7;
    }
  }

  Widget _buildWeightChart(List<dynamic> weightEntries) {
    final filteredEntries = _getFilteredData(weightEntries, _selectedPeriod);
    
    if (filteredEntries.isEmpty) {
      return _buildEmptyState(
        'Nenhum registro de peso',
        'Adicione seu peso para ver a evolução',
        Icons.monitor_weight,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Evolução do Peso',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppConstants.defaultPadding),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${value.toInt()}kg',
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= filteredEntries.length) return const Text('');
                                final entry = filteredEntries[value.toInt()];
                                return Text(
                                  DateFormat('dd/MM').format(entry.date),
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: filteredEntries.asMap().entries.map((entry) {
                              return FlSpot(entry.key.toDouble(), entry.value.weight);
                            }).toList(),
                            isCurved: true,
                            color: AppConstants.primaryColor,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: AppConstants.primaryColor.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          _buildWeightStats(filteredEntries),
        ],
      ),
    );
  }

  Widget _buildWorkoutsChart(List<dynamic> workouts) {
    final filteredWorkouts = _getFilteredData(workouts, _selectedPeriod);
    
    if (filteredWorkouts.isEmpty) {
      return _buildEmptyState(
        'Nenhum treino registrado',
        'Registre treinos para ver a frequência',
        Icons.fitness_center,
      );
    }

    // Agrupar treinos por dia da semana
    final weeklyData = _getWeeklyWorkoutData(filteredWorkouts);

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequência de Treinos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppConstants.defaultPadding),
                  SizedBox(
                    height: 300,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: weeklyData.values.reduce((a, b) => a > b ? a : b).toDouble() + 1,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                const days = ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
                                return Text(
                                  days[value.toInt() % 7],
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        barGroups: weeklyData.entries.map((entry) {
                          return BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.toDouble(),
                                color: AppConstants.primaryColor,
                                width: 20,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          _buildWorkoutStats(filteredWorkouts),
        ],
      ),
    );
  }

  Widget _buildVolumeChart(List<dynamic> workouts) {
    final filteredWorkouts = _getFilteredData(workouts, _selectedPeriod);
    
    if (filteredWorkouts.isEmpty) {
      return _buildEmptyState(
        'Nenhum treino registrado',
        'Registre treinos para ver o volume',
        Icons.bar_chart,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Volume de Treinos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppConstants.defaultPadding),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(show: true),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 60,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  '${(value / 1000).toStringAsFixed(1)}t',
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                if (value.toInt() >= filteredWorkouts.length) return const Text('');
                                final workout = filteredWorkouts[value.toInt()];
                                return Text(
                                  DateFormat('dd/MM').format(workout.date),
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: filteredWorkouts.asMap().entries.map((entry) {
                              return FlSpot(entry.key.toDouble(), entry.value.totalVolume);
                            }).toList(),
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 3,
                            dotData: FlDotData(show: true),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.blue.withOpacity(0.1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppConstants.defaultPadding),
          _buildVolumeStats(filteredWorkouts),
        ],
      ),
    );
  }

  Map<int, int> _getWeeklyWorkoutData(List<dynamic> workouts) {
    final Map<int, int> weeklyData = {};
    
    for (int i = 0; i < 7; i++) {
      weeklyData[i] = 0;
    }
    
    for (final workout in workouts) {
      final weekday = workout.date.weekday % 7;
      weeklyData[weekday] = (weeklyData[weekday] ?? 0) + 1;
    }
    
    return weeklyData;
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.largePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: AppConstants.largePadding),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: AppConstants.defaultPadding),
            Text(
              subtitle,
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

  Widget _buildWeightStats(List<dynamic> entries) {
    if (entries.isEmpty) return const SizedBox.shrink();
    
    final latest = entries.last;
    final first = entries.first;
    final change = latest.weight - first.weight;
    final avgWeight = entries.fold(0.0, (sum, entry) => sum + entry.weight) / entries.length;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Peso Atual', '${latest.weight.toStringAsFixed(1)}kg', Icons.monitor_weight),
            _buildStatItem('Variação', '${change >= 0 ? '+' : ''}${change.toStringAsFixed(1)}kg', Icons.trending_up),
            _buildStatItem('Média', '${avgWeight.toStringAsFixed(1)}kg', Icons.analytics),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutStats(List<dynamic> workouts) {
    final totalWorkouts = workouts.length;
    final totalVolume = workouts.fold(0.0, (sum, workout) => sum + workout.totalVolume);
    final avgVolume = totalWorkouts > 0 ? totalVolume / totalWorkouts : 0.0;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Treinos', totalWorkouts.toString(), Icons.fitness_center),
            _buildStatItem('Volume Total', '${(totalVolume / 1000).toStringAsFixed(1)}t', Icons.bar_chart),
            _buildStatItem('Média/treino', '${avgVolume.toStringAsFixed(0)}kg', Icons.analytics),
          ],
        ),
      ),
    );
  }

  Widget _buildVolumeStats(List<dynamic> workouts) {
    final totalVolume = workouts.fold(0.0, (sum, workout) => sum + workout.totalVolume);
    final maxVolume = workouts.isNotEmpty 
        ? workouts.map((w) => w.totalVolume).reduce((a, b) => a > b ? a : b)
        : 0.0;
    final avgVolume = workouts.isNotEmpty ? totalVolume / workouts.length : 0.0;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem('Volume Total', '${(totalVolume / 1000).toStringAsFixed(1)}t', Icons.bar_chart),
            _buildStatItem('Maior Volume', '${maxVolume.toStringAsFixed(0)}kg', Icons.trending_up),
            _buildStatItem('Média', '${avgVolume.toStringAsFixed(0)}kg', Icons.analytics),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
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

