import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import '../../shared/models/exercise.dart';
import '../../shared/models/workout.dart';
import '../../shared/models/user.dart';
import '../../shared/models/weight_entry.dart';
import '../../shared/models/badge.dart';
import '../../shared/models/user_badge.dart';
import '../../shared/models/workout_template.dart';

class HiveService {
  static const String _userBoxName = 'user';
  static const String _exercisesBoxName = 'exercises';
  static const String _workoutsBoxName = 'workouts';
  static const String _weightEntriesBoxName = 'weight_entries';
  static const String _badgesBoxName = 'badges';
  static const String _userBadgesBoxName = 'user_badges';

  static Box<User>? _userBox;
  static Box<Exercise>? _exercisesBox;
  static Box<Workout>? _workoutsBox;
  static Box<WeightEntry>? _weightEntriesBox;
  static Box<Badge>? _badgesBox;
  static Box<UserBadge>? _userBadgesBox;
  static Box<WorkoutTemplate>? _workoutTemplatesBox;

  static Future<void> init() async {
    try {
      await Hive.initFlutter();
      
      // Registrar adapters
      Hive.registerAdapter(ExerciseAdapter());
      Hive.registerAdapter(ExerciseCategoryAdapter());
      Hive.registerAdapter(MuscleGroupAdapter());
      Hive.registerAdapter(ExerciseUnitAdapter());
      
      Hive.registerAdapter(WorkoutAdapter());
      Hive.registerAdapter(WorkoutExerciseAdapter());
      Hive.registerAdapter(WorkoutSetAdapter());
      
      Hive.registerAdapter(UserAdapter());
      Hive.registerAdapter(GenderAdapter());
      Hive.registerAdapter(FitnessGoalAdapter());
      
      Hive.registerAdapter(WeightEntryAdapter());
      
      Hive.registerAdapter(BadgeAdapter());
      Hive.registerAdapter(BadgeRarityAdapter());
      Hive.registerAdapter(UserBadgeAdapter());
      
      Hive.registerAdapter(WorkoutTemplateAdapter());
      Hive.registerAdapter(WorkoutTemplateExerciseAdapter());
      Hive.registerAdapter(WorkoutTemplateCategoryAdapter());
      Hive.registerAdapter(WorkoutTemplateDifficultyAdapter());

      // Abrir boxes
      _userBox = await Hive.openBox<User>(_userBoxName);
      _exercisesBox = await Hive.openBox<Exercise>(_exercisesBoxName);
      _workoutsBox = await Hive.openBox<Workout>(_workoutsBoxName);
      _weightEntriesBox = await Hive.openBox<WeightEntry>(_weightEntriesBoxName);
      _badgesBox = await Hive.openBox<Badge>(_badgesBoxName);
      _userBadgesBox = await Hive.openBox<UserBadge>(_userBadgesBoxName);
      _workoutTemplatesBox = await Hive.openBox<WorkoutTemplate>('workout_templates');
    } catch (e) {
      print('Erro na inicialização do Hive: $e');
      rethrow;
    }
  }

  // Getters para os boxes
  static Box<User> get userBox => _userBox!;
  static Box<Exercise> get exercisesBox => _exercisesBox!;
  static Box<Workout> get workoutsBox => _workoutsBox!;
  static Box<WeightEntry> get weightEntriesBox => _weightEntriesBox!;
  static Box<Badge> get badgesBox => _badgesBox!;
  static Box<UserBadge> get userBadgesBox => _userBadgesBox!;

  // Métodos de conveniência para User
  static User? getCurrentUser() {
    try {
      return userBox.get('current_user');
    } catch (e) {
      return null;
    }
  }
  
  static Future<void> saveCurrentUser(User user) async {
    try {
      await userBox.put('current_user', user);
    } catch (e) {
      // Log error if needed
    }
  }
  
  static Future<void> clearCurrentUser() async {
    try {
      await userBox.delete('current_user');
    } catch (e) {
      // Log error if needed
    }
  }

  // Métodos de conveniência para Exercises
  static List<Exercise> getAllExercises() => exercisesBox.values.toList();
  static Future<void> saveExercise(Exercise exercise) => exercisesBox.put(exercise.id, exercise);
  static Future<void> saveExercises(List<Exercise> exercises) {
    final Map<String, Exercise> exerciseMap = {
      for (var exercise in exercises) exercise.id: exercise
    };
    return exercisesBox.putAll(exerciseMap);
  }
  static Exercise? getExercise(String id) => exercisesBox.get(id);
  static Future<void> deleteExercise(String id) => exercisesBox.delete(id);

  // Métodos de conveniência para Workouts
  static List<Workout> getAllWorkouts() => workoutsBox.values.toList();
  static List<Workout> getWorkoutsByDateRange(DateTime start, DateTime end) {
    return workoutsBox.values
        .where((workout) => 
            workout.date.isAfter(start.subtract(const Duration(days: 1))) &&
            workout.date.isBefore(end.add(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }
  static Future<void> saveWorkout(Workout workout) => workoutsBox.put(workout.id, workout);
  static Future<void> deleteWorkout(String id) => workoutsBox.delete(id);
  static Workout? getWorkout(String id) => workoutsBox.get(id);

  // Métodos de conveniência para WeightEntries
  static List<WeightEntry> getAllWeightEntries() => weightEntriesBox.values.toList();
  static List<WeightEntry> getWeightEntriesByDateRange(DateTime start, DateTime end) {
    return weightEntriesBox.values
        .where((entry) => 
            entry.date.isAfter(start.subtract(const Duration(days: 1))) &&
            entry.date.isBefore(end.add(const Duration(days: 1))))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
  static Future<void> saveWeightEntry(WeightEntry entry) => weightEntriesBox.put(entry.id, entry);
  static Future<void> deleteWeightEntry(String id) => weightEntriesBox.delete(id);
  static WeightEntry? getWeightEntry(String id) => weightEntriesBox.get(id);

  // Métodos de conveniência para Badges
  static List<Badge> getAllBadges() => badgesBox.values.toList();
  static Future<void> saveBadge(Badge badge) => badgesBox.put(badge.id, badge);
  static Future<void> saveBadges(List<Badge> badges) {
    final Map<String, Badge> badgeMap = {
      for (var badge in badges) badge.id: badge
    };
    return badgesBox.putAll(badgeMap);
  }
  static Badge? getBadge(String id) => badgesBox.get(id);

  // Métodos de conveniência para UserBadges
  static List<UserBadge> getUserBadges(String userId) {
    return userBadgesBox.values
        .where((userBadge) => userBadge.userId == userId)
        .toList()
      ..sort((a, b) => b.unlockedAt.compareTo(a.unlockedAt));
  }
  static Future<void> saveUserBadge(UserBadge userBadge) => userBadgesBox.put(userBadge.id, userBadge);
  static Future<void> deleteUserBadge(String id) => userBadgesBox.delete(id);

  // Limpar todos os dados
  static Future<void> clearAllData() async {
    await userBox.clear();
    await exercisesBox.clear();
    await workoutsBox.clear();
    await weightEntriesBox.clear();
    await badgesBox.clear();
    await userBadgesBox.clear();
  }

  // Fechar todos os boxes
  // GAMIFICAÇÃO
  
  /// Adiciona XP ao usuário e atualiza nível
  static Future<void> addXPToUser(String userId, int xp) async {
    final user = getUser(userId);
    if (user == null) return;
    
    final newTotalXP = user.totalXP + xp;
    final newLevel = _calculateLevel(newTotalXP);
    
    final updatedUser = user.copyWith(
      totalXP: newTotalXP,
      level: newLevel,
    );
    
    await updateUser(updatedUser);
  }
  
  /// Atualiza streak do usuário
  static Future<void> updateUserStreak(String userId, int newStreak) async {
    final user = getUser(userId);
    if (user == null) return;
    
    final updatedUser = user.copyWith(
      currentStreak: newStreak,
      longestStreak: newStreak > user.longestStreak ? newStreak : user.longestStreak,
    );
    
    await updateUser(updatedUser);
  }
  
  /// Adiciona badge ao usuário
  static Future<void> addBadgeToUser(String userId, Badge badge) async {
    final userBadge = UserBadge(
      id: '${userId}_${badge.id}',
      userId: userId,
      badgeId: badge.id,
      unlockedAt: badge.unlockedAt ?? DateTime.now(),
    );
    
    await userBadgesBox.put(userBadge.id, userBadge);
  }
  
  
  /// Obtém usuário por ID
  static User? getUser(String userId) {
    return userBox.get(userId);
  }
  
  /// Atualiza usuário
  static Future<void> updateUser(User user) async {
    await userBox.put(user.id, user);
  }
  
  /// Obtém treinos do usuário
  static List<Workout> getUserWorkouts(String userId) {
    return workoutsBox.values
        .where((w) => w.id.contains(userId))
        .toList();
  }
  
  /// Obtém estatísticas de gamificação do usuário
  static Map<String, dynamic> getUserGamificationStats(String userId) {
    final user = getUser(userId);
    if (user == null) return {};
    
    final badges = getUserBadges(userId);
    
    return {
      'totalXP': user.totalXP,
      'level': user.level,
      'currentStreak': user.currentStreak,
      'longestStreak': user.longestStreak,
      'totalWorkouts': user.totalWorkouts,
      'badgesCount': badges.length,
      'badges': badges,
    };
  }
  
  /// Calcula nível baseado no XP
  static int _calculateLevel(int totalXP) {
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

  // Workout Templates
  static Box<WorkoutTemplate> get workoutTemplatesBox => Hive.box<WorkoutTemplate>('workout_templates');
  
  /// Salva template de treino
  static Future<void> saveWorkoutTemplate(WorkoutTemplate template) async {
    await workoutTemplatesBox.put(template.id, template);
  }
  
  /// Salva múltiplos templates
  static Future<void> saveWorkoutTemplates(List<WorkoutTemplate> templates) async {
    final Map<String, WorkoutTemplate> templateMap = {
      for (var template in templates) template.id: template
    };
    await workoutTemplatesBox.putAll(templateMap);
  }
  
  /// Obtém todos os templates
  static List<WorkoutTemplate> getAllWorkoutTemplates() {
    return workoutTemplatesBox.values.toList();
  }
  
  /// Obtém template por ID
  static WorkoutTemplate? getWorkoutTemplate(String templateId) {
    return workoutTemplatesBox.get(templateId);
  }
  
  /// Deleta template
  static Future<void> deleteWorkoutTemplate(String templateId) async {
    await workoutTemplatesBox.delete(templateId);
  }

  static Future<void> close() async {
    await userBox.close();
    await exercisesBox.close();
    await workoutsBox.close();
    await weightEntriesBox.close();
    await badgesBox.close();
    await userBadgesBox.close();
    await workoutTemplatesBox.close();
  }
}
