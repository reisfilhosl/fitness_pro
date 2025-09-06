import 'dart:math';
import 'package:muvvifit/shared/models/user.dart';
import 'package:muvvifit/shared/models/workout.dart';
import 'package:muvvifit/shared/models/badge.dart';

class GamificationService {
  /// Calcula XP baseado no volume do treino
  static int calculateWorkoutXP(Workout workout) {
    final totalVolume = workout.totalVolume;
    
    // XP baseado no volume: 1 XP para cada 100kg de volume
    final volumeXP = (totalVolume / 100).floor();
    
    // XP baseado na duração: 1 XP para cada 10 minutos
    final durationMinutes = workout.duration?.inMinutes ?? 0;
    final durationXP = (durationMinutes / 10).floor();
    
    // XP baseado no número de exercícios: 5 XP por exercício
    final exerciseXP = workout.exercises.length * 5;
    
    // XP baseado na consistência (streak)
    final consistencyXP = _calculateConsistencyXP(workout);
    
    return volumeXP + durationXP + exerciseXP + consistencyXP;
  }

  /// Calcula XP baseado na consistência (streak)
  static int _calculateConsistencyXP(Workout workout) {
    // TODO: Implementar cálculo de streak baseado em treinos anteriores
    // Por enquanto, retorna XP fixo baseado no dia da semana
    final weekday = workout.date.weekday;
    
    // Mais XP para treinos em dias "difíceis" (segunda, quarta, sexta)
    switch (weekday) {
      case 1: // Segunda
      case 3: // Quarta
      case 5: // Sexta
        return 10;
      case 2: // Terça
      case 4: // Quinta
        return 5;
      case 6: // Sábado
      case 7: // Domingo
        return 15; // Mais XP para treinos no fim de semana
      default:
        return 0;
    }
  }

  /// Calcula o nível do usuário baseado no XP total
  static int calculateLevel(int totalXP) {
    if (totalXP < 100) return 1;
    if (totalXP < 300) return 2;
    if (totalXP < 600) return 3;
    if (totalXP < 1000) return 4;
    if (totalXP < 1500) return 5;
    if (totalXP < 2100) return 6;
    if (totalXP < 2800) return 7;
    if (totalXP < 3600) return 8;
    if (totalXP < 4500) return 9;
    if (totalXP < 5500) return 10;
    
    // Para níveis acima de 10, usar fórmula: nível = sqrt(XP/100) + 1
    return sqrt(totalXP / 100).floor() + 1;
  }

  /// Calcula XP necessário para o próximo nível
  static int calculateXPForNextLevel(int currentLevel) {
    if (currentLevel < 10) {
      return (currentLevel * 100) + (currentLevel * 50);
    }
    
    // Para níveis 10+, usar fórmula: XP = (nível - 1)² * 100
    return ((currentLevel - 1) * (currentLevel - 1) * 100);
  }

  /// Calcula progresso para o próximo nível (0.0 a 1.0)
  static double calculateLevelProgress(int currentXP, int currentLevel) {
    final xpForCurrentLevel = currentLevel > 1 
        ? calculateXPForNextLevel(currentLevel - 1) 
        : 0;
    final xpForNextLevel = calculateXPForNextLevel(currentLevel);
    final xpInCurrentLevel = currentXP - xpForCurrentLevel;
    final xpNeededForLevel = xpForNextLevel - xpForCurrentLevel;
    
    return (xpInCurrentLevel / xpNeededForLevel).clamp(0.0, 1.0);
  }

  /// Calcula streak de treinos consecutivos
  static int calculateWorkoutStreak(List<Workout> workouts) {
    if (workouts.isEmpty) return 0;
    
    // Ordena treinos por data (mais recente primeiro)
    final sortedWorkouts = List<Workout>.from(workouts)
      ..sort((a, b) => b.date.compareTo(a.date));
    
    int streak = 0;
    DateTime? lastWorkoutDate;
    
    for (final workout in sortedWorkouts) {
      final workoutDate = DateTime(
        workout.date.year,
        workout.date.month,
        workout.date.day,
      );
      
      if (lastWorkoutDate == null) {
        // Primeiro treino
        lastWorkoutDate = workoutDate;
        streak = 1;
      } else {
        final daysDifference = lastWorkoutDate.difference(workoutDate).inDays;
        
        if (daysDifference == 1) {
          // Treino consecutivo
          streak++;
          lastWorkoutDate = workoutDate;
        } else if (daysDifference == 0) {
          // Mesmo dia, não conta para o streak
          continue;
        } else {
          // Streak quebrado
          break;
        }
      }
    }
    
    return streak;
  }

  /// Verifica se o usuário deve ganhar badges baseado no progresso
  static List<Badge> checkForNewBadges(User user, List<Workout> workouts, List<Badge> existingBadges) {
    final newBadges = <Badge>[];
    final existingBadgeIds = existingBadges.map((b) => b.id).toSet();
    
    // Badge de primeiro treino
    if (workouts.isNotEmpty && !existingBadgeIds.contains('first_workout')) {
      newBadges.add(Badge(
        id: 'first_workout',
        name: 'Primeiro Passo',
        description: 'Complete seu primeiro treino',
        icon: '🎯',
        rarity: BadgeRarity.common,
        unlockedAt: DateTime.now(),
      ));
    }
    
    // Badge de streak de 3 dias
    final streak = calculateWorkoutStreak(workouts);
    if (streak >= 3 && !existingBadgeIds.contains('streak_3')) {
      newBadges.add(Badge(
        id: 'streak_3',
        name: 'Consistência',
        description: 'Treine por 3 dias consecutivos',
        icon: '🔥',
        rarity: BadgeRarity.common,
        unlockedAt: DateTime.now(),
      ));
    }
    
    // Badge de streak de 7 dias
    if (streak >= 7 && !existingBadgeIds.contains('streak_7')) {
      newBadges.add(Badge(
        id: 'streak_7',
        name: 'Determinação',
        description: 'Treine por 7 dias consecutivos',
        icon: '💪',
        rarity: BadgeRarity.rare,
        unlockedAt: DateTime.now(),
      ));
    }
    
    // Badge de streak de 30 dias
    if (streak >= 30 && !existingBadgeIds.contains('streak_30')) {
      newBadges.add(Badge(
        id: 'streak_30',
        name: 'Lenda',
        description: 'Treine por 30 dias consecutivos',
        icon: '👑',
        rarity: BadgeRarity.legendary,
        unlockedAt: DateTime.now(),
      ));
    }
    
    // Badge de volume total
    final totalVolume = workouts.fold<double>(0, (sum, workout) => sum + workout.totalVolume);
    if (totalVolume >= 10000 && !existingBadgeIds.contains('volume_10k')) {
      newBadges.add(Badge(
        id: 'volume_10k',
        name: 'Levantador',
        description: 'Acumule 10.000kg de volume total',
        icon: '🏋️',
        rarity: BadgeRarity.rare,
        unlockedAt: DateTime.now(),
      ));
    }
    
    // Badge de nível 5
    final level = calculateLevel(user.totalXP);
    if (level >= 5 && !existingBadgeIds.contains('level_5')) {
      newBadges.add(Badge(
        id: 'level_5',
        name: 'Experiente',
        description: 'Alcance o nível 5',
        icon: '⭐',
        rarity: BadgeRarity.rare,
        unlockedAt: DateTime.now(),
      ));
    }
    
    // Badge de nível 10
    if (level >= 10 && !existingBadgeIds.contains('level_10')) {
      newBadges.add(Badge(
        id: 'level_10',
        name: 'Mestre',
        description: 'Alcance o nível 10',
        icon: '🌟',
        rarity: BadgeRarity.legendary,
        unlockedAt: DateTime.now(),
      ));
    }
    
    // Badge de treinos no fim de semana
    final weekendWorkouts = workouts.where((w) {
      final weekday = w.date.weekday;
      return weekday == 6 || weekday == 7; // Sábado ou Domingo
    }).length;
    
    if (weekendWorkouts >= 5 && !existingBadgeIds.contains('weekend_warrior')) {
      newBadges.add(Badge(
        id: 'weekend_warrior',
        name: 'Guerreiro do Fim de Semana',
        description: 'Complete 5 treinos no fim de semana',
        icon: '⚔️',
        rarity: BadgeRarity.rare,
        unlockedAt: DateTime.now(),
      ));
    }
    
    return newBadges;
  }

  /// Calcula estatísticas de gamificação
  static Map<String, dynamic> calculateGamificationStats(User user, List<Workout> workouts) {
    final totalXP = user.totalXP;
    final level = calculateLevel(totalXP);
    final xpForNextLevel = calculateXPForNextLevel(level);
    final levelProgress = calculateLevelProgress(totalXP, level);
    final streak = calculateWorkoutStreak(workouts);
    
    // Estatísticas do mês atual
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final monthWorkouts = workouts.where((w) => w.date.isAfter(startOfMonth)).toList();
    final monthVolume = monthWorkouts.fold<double>(0, (sum, w) => sum + w.totalVolume);
    
    // Estatísticas da semana atual
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final weekWorkouts = workouts.where((w) => w.date.isAfter(startOfWeek)).toList();
    final weekVolume = weekWorkouts.fold<double>(0, (sum, w) => sum + w.totalVolume);
    
    return {
      'totalXP': totalXP,
      'level': level,
      'xpForNextLevel': xpForNextLevel,
      'levelProgress': levelProgress,
      'streak': streak,
      'monthWorkouts': monthWorkouts.length,
      'monthVolume': monthVolume,
      'weekWorkouts': weekWorkouts.length,
      'weekVolume': weekVolume,
      'totalWorkouts': workouts.length,
      'totalVolume': workouts.fold<double>(0, (sum, w) => sum + w.totalVolume),
    };
  }
}
