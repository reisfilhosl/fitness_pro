import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/services/hive_service.dart';
import '../../core/services/exercise_seed.dart';
import '../../core/services/badge_seed.dart';
import '../../core/services/workout_template_seed.dart';
import '../../shared/models/user.dart';
import '../../shared/models/exercise.dart';
import '../../shared/models/workout.dart';
import '../../shared/models/weight_entry.dart';
import '../../shared/models/badge.dart' as models;
import '../../shared/models/user_badge.dart';
import '../../shared/models/workout_template.dart';

// Hive Service Provider
final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());

// SharedPreferences Provider
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});

// User Provider
final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier();
});

class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null) {
    _loadUser();
  }

  Future<void> _loadUser() async {
    try {
      final user = HiveService.getCurrentUser();
      state = user;
    } catch (e) {
      // Se houver erro, mantém state como null
      state = null;
    }
  }

  Future<void> createUser(User user) async {
    await HiveService.saveCurrentUser(user);
    state = user;
  }

  Future<void> updateUser(User user) async {
    await HiveService.saveCurrentUser(user);
    state = user;
  }

  Future<void> clearUser() async {
    await HiveService.clearCurrentUser();
    state = null;
  }

  Future<void> addXP(int xp) async {
    if (state == null) return;
    
    final newXP = state!.totalXP + xp;
    final newLevel = _calculateLevel(newXP);
    
    final updatedUser = state!.copyWith(
      totalXP: newXP,
      level: newLevel,
    );
    
    await updateUser(updatedUser);
  }

  Future<void> updateStreak() async {
    if (state == null) return;
    
    final now = DateTime.now();
    final lastWorkout = state!.lastWorkoutDate;
    
    int newStreak = state!.currentStreak;
    
    if (lastWorkout != null) {
      final daysDifference = now.difference(lastWorkout).inDays;
      
      if (daysDifference == 1) {
        // Streak continua
        newStreak++;
      } else if (daysDifference > 1) {
        // Streak quebrada
        newStreak = 1;
      }
      // Se daysDifference == 0, mantém o streak atual
    } else {
      // Primeiro treino
      newStreak = 1;
    }
    
    final newLongestStreak = newStreak > state!.longestStreak 
        ? newStreak 
        : state!.longestStreak;
    
    final updatedUser = state!.copyWith(
      currentStreak: newStreak,
      longestStreak: newLongestStreak,
      lastWorkoutDate: now,
      totalWorkouts: state!.totalWorkouts + 1,
    );
    
    await updateUser(updatedUser);
  }

  int _calculateLevel(int xp) {
    int level = 1;
    int requiredXP = 1000; // XP base para nível 2
    
    while (xp >= requiredXP) {
      level++;
      xp -= requiredXP;
      requiredXP = (requiredXP * 1.2).round();
    }
    
    return level;
  }
}

// Exercises Provider
final exercisesProvider = StateNotifierProvider<ExercisesNotifier, List<Exercise>>((ref) {
  return ExercisesNotifier();
});

class ExercisesNotifier extends StateNotifier<List<Exercise>> {
  ExercisesNotifier() : super([]) {
    _loadExercises();
  }

  void _loadExercises() {
    state = HiveService.getAllExercises();
    
    // Se não há exercícios, carrega o seed
    if (state.isEmpty) {
      _loadSeedExercises();
    }
  }

  void _loadSeedExercises() {
    final seedExercises = ExerciseSeed.getExercises();
    HiveService.saveExercises(seedExercises);
    state = seedExercises;
  }

  List<Exercise> getExercisesByCategory(String category) {
    return state.where((exercise) => 
      exercise.category.displayName.toLowerCase() == category.toLowerCase()
    ).toList();
  }

  List<Exercise> getExercisesByMuscleGroup(String muscleGroup) {
    return state.where((exercise) => 
      exercise.muscleGroup.displayName.toLowerCase() == muscleGroup.toLowerCase()
    ).toList();
  }

  List<Exercise> searchExercises(String query) {
    if (query.isEmpty) return state;
    
    return state.where((exercise) => 
      exercise.name.toLowerCase().contains(query.toLowerCase()) ||
      exercise.muscleGroup.displayName.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}

// Workouts Provider
final workoutsProvider = StateNotifierProvider<WorkoutsNotifier, List<Workout>>((ref) {
  return WorkoutsNotifier();
});

class WorkoutsNotifier extends StateNotifier<List<Workout>> {
  WorkoutsNotifier() : super([]) {
    _loadWorkouts();
  }

  void _loadWorkouts() {
    state = HiveService.getAllWorkouts();
  }

  Future<void> addWorkout(Workout workout) async {
    await HiveService.saveWorkout(workout);
    state = HiveService.getAllWorkouts();
  }

  Future<void> updateWorkout(Workout workout) async {
    await HiveService.saveWorkout(workout);
    state = HiveService.getAllWorkouts();
  }

  Future<void> deleteWorkout(String workoutId) async {
    await HiveService.deleteWorkout(workoutId);
    state = HiveService.getAllWorkouts();
  }

  List<Workout> getWorkoutsByDateRange(DateTime start, DateTime end) {
    return HiveService.getWorkoutsByDateRange(start, end);
  }

  Workout? getWorkoutById(String id) {
    return HiveService.getWorkout(id);
  }
}

// Weight Entries Provider
final weightEntriesProvider = StateNotifierProvider<WeightEntriesNotifier, List<WeightEntry>>((ref) {
  return WeightEntriesNotifier();
});

class WeightEntriesNotifier extends StateNotifier<List<WeightEntry>> {
  WeightEntriesNotifier() : super([]) {
    _loadWeightEntries();
  }

  void _loadWeightEntries() {
    state = HiveService.getAllWeightEntries();
  }

  Future<void> addWeightEntry(WeightEntry entry) async {
    await HiveService.saveWeightEntry(entry);
    state = HiveService.getAllWeightEntries();
  }

  Future<void> addWeightEntryByValue(double weight) async {
    final entry = WeightEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      weight: weight,
      date: DateTime.now(),
    );
    await HiveService.saveWeightEntry(entry);
    state = HiveService.getAllWeightEntries();
  }

  Future<void> updateWeightEntry(WeightEntry entry) async {
    await HiveService.saveWeightEntry(entry);
    state = HiveService.getAllWeightEntries();
  }

  Future<void> deleteWeightEntry(String entryId) async {
    await HiveService.deleteWeightEntry(entryId);
    state = HiveService.getAllWeightEntries();
  }

  List<WeightEntry> getWeightEntriesByDateRange(DateTime start, DateTime end) {
    return HiveService.getWeightEntriesByDateRange(start, end);
  }

  WeightEntry? getLatestWeightEntry() {
    if (state.isEmpty) return null;
    return state.reduce((a, b) => a.date.isAfter(b.date) ? a : b);
  }
}

// Badges Provider
final badgesProvider = StateNotifierProvider<BadgesNotifier, List<models.Badge>>((ref) {
  return BadgesNotifier();
});

class BadgesNotifier extends StateNotifier<List<models.Badge>> {
  BadgesNotifier() : super([]) {
    _loadBadges();
  }

  void _loadBadges() {
    state = HiveService.getAllBadges();
    
    // Se não há badges, carrega o seed
    if (state.isEmpty) {
      _loadSeedBadges();
    }
  }

  void _loadSeedBadges() {
    final seedBadges = BadgeSeed.getBadges();
    HiveService.saveBadges(seedBadges);
    state = seedBadges;
  }

  models.Badge? getBadgeById(String id) {
    return HiveService.getBadge(id);
  }

  Future<void> addBadge(models.Badge badge) async {
    await HiveService.saveBadge(badge);
    state = HiveService.getAllBadges();
  }
}

// User Badges Provider
final userBadgesProvider = StateNotifierProvider<UserBadgesNotifier, List<UserBadge>>((ref) {
  return UserBadgesNotifier();
});

class UserBadgesNotifier extends StateNotifier<List<UserBadge>> {
  UserBadgesNotifier() : super([]) {
    _loadUserBadges();
  }

  void _loadUserBadges() {
    // TODO: Implementar quando tivermos sistema de usuários
    state = [];
  }

  Future<void> addUserBadge(UserBadge userBadge) async {
    await HiveService.saveUserBadge(userBadge);
    state = HiveService.getUserBadges(userBadge.userId);
  }

  List<UserBadge> getUserBadges(String userId) {
    return HiveService.getUserBadges(userId);
  }
}

// Theme Mode Provider
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt('theme_mode') ?? 0;
      state = ThemeMode.values[themeModeIndex];
    } catch (e) {
      // Se houver erro, mantém o tema do sistema
      state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('theme_mode', themeMode.index);
      state = themeMode;
    } catch (e) {
      // Se houver erro, apenas atualiza o state
      state = themeMode;
    }
  }
}

// Gamification Provider - Importado do arquivo dedicado

// Workout Templates Provider
final workoutTemplatesProvider = StateNotifierProvider<WorkoutTemplatesNotifier, List<WorkoutTemplate>>((ref) {
  return WorkoutTemplatesNotifier();
});

class WorkoutTemplatesNotifier extends StateNotifier<List<WorkoutTemplate>> {
  WorkoutTemplatesNotifier() : super([]) {
    _loadTemplates();
  }

  void _loadTemplates() {
    state = HiveService.getAllWorkoutTemplates();
    
    // Se não há templates, carrega o seed
    if (state.isEmpty) {
      _loadSeedTemplates();
    }
  }

  void _loadSeedTemplates() {
    final seedTemplates = WorkoutTemplateSeed.getTemplates();
    HiveService.saveWorkoutTemplates(seedTemplates);
    state = seedTemplates;
  }

  Future<void> addTemplate(WorkoutTemplate template) async {
    await HiveService.saveWorkoutTemplate(template);
    state = HiveService.getAllWorkoutTemplates();
  }

  Future<void> updateTemplate(WorkoutTemplate template) async {
    await HiveService.saveWorkoutTemplate(template);
    state = HiveService.getAllWorkoutTemplates();
  }

  Future<void> deleteTemplate(String templateId) async {
    await HiveService.deleteWorkoutTemplate(templateId);
    state = HiveService.getAllWorkoutTemplates();
  }

  List<WorkoutTemplate> getTemplatesByCategory(WorkoutTemplateCategory category) {
    return state.where((template) => template.category == category).toList();
  }

  List<WorkoutTemplate> getTemplatesByDifficulty(WorkoutTemplateDifficulty difficulty) {
    return state.where((template) => template.difficulty == difficulty).toList();
  }

  List<WorkoutTemplate> getCustomTemplates() {
    return state.where((template) => template.isCustom).toList();
  }
}
