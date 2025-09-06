import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/services/gamification_service.dart';
import '../../core/services/hive_service.dart';
import '../models/user.dart';
import '../models/workout.dart';
import '../models/badge.dart';

part 'gamification_provider.g.dart';

@riverpod
class GamificationNotifier extends _$GamificationNotifier {
  @override
  Future<Map<String, dynamic>> build() async {
    // Retorna estatísticas vazias por padrão
    return {};
  }

  /// Atualiza estatísticas de gamificação do usuário
  Future<void> updateStats(String userId) async {
    final stats = HiveService.getUserGamificationStats(userId);
    state = AsyncValue.data(stats);
  }

  /// Adiciona XP ao usuário após um treino
  Future<void> addWorkoutXP(String userId, Workout workout) async {
    final xp = GamificationService.calculateWorkoutXP(workout);
    await HiveService.addXPToUser(userId, xp);
    
    // Atualiza as estatísticas
    await updateStats(userId);
  }

  /// Atualiza streak do usuário
  Future<void> updateStreak(String userId, int newStreak) async {
    await HiveService.updateUserStreak(userId, newStreak);
    await updateStats(userId);
  }

  /// Adiciona badge ao usuário
  Future<void> addBadge(String userId, Badge badge) async {
    await HiveService.addBadgeToUser(userId, badge);
    await updateStats(userId);
  }

  /// Verifica e adiciona novos badges
  Future<List<Badge>> checkForNewBadges(String userId, User user, List<Workout> workouts) async {
    final userBadges = HiveService.getUserBadges(userId);
    final existingBadges = userBadges.map((ub) => HiveService.getBadge(ub.badgeId)).where((b) => b != null).cast<Badge>().toList();
    final newBadges = GamificationService.checkForNewBadges(user, workouts, existingBadges);
    
    // Adiciona os novos badges
    for (final badge in newBadges) {
      await addBadge(userId, badge);
    }
    
    return newBadges;
  }

  /// Calcula estatísticas completas de gamificação
  Future<Map<String, dynamic>> calculateFullStats(String userId, User user, List<Workout> workouts) async {
    return GamificationService.calculateGamificationStats(user, workouts);
  }
}

@riverpod
class UserBadgesNotifier extends _$UserBadgesNotifier {
  @override
  Future<List<Badge>> build() async {
    return [];
  }

  /// Carrega badges do usuário
  Future<void> loadUserBadges(String userId) async {
    state = const AsyncValue.loading();
    try {
      final userBadges = HiveService.getUserBadges(userId);
      final badges = userBadges.map((ub) => HiveService.getBadge(ub.badgeId)).where((b) => b != null).cast<Badge>().toList();
      state = AsyncValue.data(badges);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  /// Adiciona um novo badge
  Future<void> addBadge(String userId, Badge badge) async {
    await HiveService.addBadgeToUser(userId, badge);
    await loadUserBadges(userId);
  }
}
