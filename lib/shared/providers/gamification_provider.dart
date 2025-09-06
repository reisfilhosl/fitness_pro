import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/gamification_service.dart';
import '../models/user.dart';
import '../models/workout.dart';
import '../models/badge.dart';
import 'app_providers.dart';

// Gamification Provider
final gamificationProvider = StateNotifierProvider<GamificationNotifier, Map<String, dynamic>>((ref) {
  return GamificationNotifier(ref);
});

class GamificationNotifier extends StateNotifier<Map<String, dynamic>> {
  final Ref _ref;
  
  GamificationNotifier(this._ref) : super({}) {
    _updateStats();
  }

  void _updateStats() {
    final user = _ref.read(userProvider);
    final workouts = _ref.read(workoutsProvider);
    final badges = _ref.read(badgesProvider);
    
    if (user != null) {
      final stats = GamificationService.calculateGamificationStats(user, workouts);
      state = {
        ...stats,
        'badgesCount': badges.length,
        'unlockedBadges': badges.where((b) => b.unlockedAt != null).length,
      };
    }
  }

  /// Atualiza estatísticas de gamificação do usuário
  Future<void> updateStats() async {
    _updateStats();
  }

  /// Adiciona XP ao usuário após um treino
  Future<void> addWorkoutXP(Workout workout) async {
    final user = _ref.read(userProvider);
    if (user == null) return;

    // Calcula XP do treino
    final workoutXP = GamificationService.calculateWorkoutXP(workout);
    final newTotalXP = user.totalXP + workoutXP;
    final newLevel = GamificationService.calculateLevel(newTotalXP);
    
    // Atualiza usuário
    final updatedUser = user.copyWith(
      totalXP: newTotalXP,
      level: newLevel,
      totalWorkouts: user.totalWorkouts + 1,
      lastWorkoutDate: workout.date,
    );
    
    await _ref.read(userProvider.notifier).updateUser(updatedUser);
    
    // Verifica novos badges
    await _checkForNewBadges(updatedUser, workout);
    
    // Atualiza estatísticas
    _updateStats();
  }

  /// Atualiza streak do usuário
  Future<void> updateStreak() async {
    final user = _ref.read(userProvider);
    final workouts = _ref.read(workoutsProvider);
    
    if (user == null) return;

    final currentStreak = GamificationService.calculateWorkoutStreak(workouts);
    final longestStreak = currentStreak > user.longestStreak ? currentStreak : user.longestStreak;
    
    final updatedUser = user.copyWith(
      currentStreak: currentStreak,
      longestStreak: longestStreak,
    );
    
    await _ref.read(userProvider.notifier).updateUser(updatedUser);
    _updateStats();
  }

  /// Adiciona badge ao usuário
  Future<void> addBadge(Badge badge) async {
    await _ref.read(badgesProvider.notifier).addBadge(badge);
    _updateStats();
  }

  /// Verifica e adiciona novos badges
  Future<void> _checkForNewBadges(User user, Workout workout) async {
    final workouts = _ref.read(workoutsProvider);
    final existingBadges = _ref.read(badgesProvider);
    
    final newBadges = GamificationService.checkForNewBadges(user, workouts, existingBadges);
    
    for (final badge in newBadges) {
      await addBadge(badge);
    }
  }

  /// Calcula estatísticas completas de gamificação
  Map<String, dynamic> calculateFullStats(User user, List<Workout> workouts) {
    return GamificationService.calculateGamificationStats(user, workouts);
  }
}

