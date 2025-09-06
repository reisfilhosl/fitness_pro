import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'MuvviFit';
  static const String appVersion = '1.0.0';
  
  // XP System
  static const int baseXPPerWorkout = 100;
  static const int xpPerSet = 10;
  static const int xpPerKg = 1;
  static const int xpPerMinute = 5;
  static const int xpForStreak = 50;
  
  // Level System
  static const int baseXPForLevel = 1000;
  static const double xpMultiplier = 1.2;
  
  // Streak System
  static const int maxStreakDays = 7; // Para calcular streak semanal
  static const int streakResetHours = 48; // Horas para resetar streak
  
  // Workout Limits
  static const int maxSetsPerExercise = 20;
  static const int maxExercisesPerWorkout = 50;
  static const double maxWeight = 1000.0; // kg
  static const int maxReps = 1000;
  
  // UI Constants
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  static const double borderRadius = 12.0;
  static const double cardElevation = 2.0;
  
  // Colors - Apple Style
  static const Color primaryColor = Color(0xFF007AFF); // Azul iOS
  static const Color secondaryColor = Color(0xFF5856D6); // Roxo iOS
  static const Color accentColor = Color(0xFFFF9500); // Laranja iOS
  static const Color successColor = Color(0xFF34C759); // Verde iOS
  static const Color warningColor = Color(0xFFFF9500); // Laranja iOS
  static const Color errorColor = Color(0xFFFF3B30); // Vermelho iOS
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Chart Colors - Apple Style
  static const List<int> chartColors = [
    0xFF007AFF, // Azul iOS
    0xFF5856D6, // Roxo iOS
    0xFF34C759, // Verde iOS
    0xFFFF9500, // Laranja iOS
    0xFFFF3B30, // Vermelho iOS
    0xFF5AC8FA, // Azul claro iOS
    0xFFFF2D92, // Rosa iOS
    0xFF8E8E93, // Cinza iOS
  ];
  
  // Muscle Group Colors - Apple Style
  static const Map<String, int> muscleGroupColors = {
    'chest': 0xFF007AFF, // Azul iOS
    'back': 0xFF5856D6, // Roxo iOS
    'shoulders': 0xFF34C759, // Verde iOS
    'arms': 0xFFFF9500, // Laranja iOS
    'legs': 0xFFFF3B30, // Vermelho iOS
    'core': 0xFF5AC8FA, // Azul claro iOS
    'glutes': 0xFFFF2D92, // Rosa iOS
    'calves': 0xFF8E8E93, // Cinza iOS
    'fullBody': 0xFF007AFF, // Azul iOS
    'cardio': 0xFF34C759, // Verde iOS
  };
  
  // Exercise Categories
  static const List<String> exerciseCategories = [
    'Aeróbico',
    'Anaeróbico',
  ];
  
  // Muscle Groups
  static const List<String> muscleGroups = [
    'Peito',
    'Costas',
    'Ombros',
    'Braços',
    'Pernas',
    'Core',
    'Glúteos',
    'Panturrilhas',
    'Corpo Inteiro',
    'Cardio',
  ];
  
  // Fitness Goals
  static const List<String> fitnessGoals = [
    'Ganhar Peso',
    'Perder Peso',
    'Manter Peso',
    'Ganhar Massa',
    'Melhorar Resistência',
  ];
  
  // Genders
  static const List<String> genders = [
    'Masculino',
    'Feminino',
    'Outro',
  ];
  
  // Export Settings
  static const String csvDelimiter = ',';
  static const String pdfTitle = 'Relatório MuvviFit';
  static const String pdfAuthor = 'MuvviFit App';
  
  // Storage Keys
  static const String isFirstLaunchKey = 'is_first_launch';
  static const String themeModeKey = 'theme_mode';
  static const String userOnboardingKey = 'user_onboarding_completed';
  static const String lastWorkoutDateKey = 'last_workout_date';
  static const String currentStreakKey = 'current_streak';
  static const String longestStreakKey = 'longest_streak';
  static const String totalXPKey = 'total_xp';
  static const String levelKey = 'level';
}
