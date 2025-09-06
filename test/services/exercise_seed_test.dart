import 'package:flutter_test/flutter_test.dart';
import 'package:muvvifit/core/services/exercise_seed.dart';
import 'package:muvvifit/shared/models/exercise.dart';

void main() {
  group('ExerciseSeed Tests', () {
    test('should return list of exercises', () {
      final exercises = ExerciseSeed.getExercises();
      
      expect(exercises, isNotEmpty);
      expect(exercises.length, greaterThan(40)); // Pelo menos 40 exercícios
    });

    test('should contain both aerobic and anaerobic exercises', () {
      final exercises = ExerciseSeed.getExercises();
      
      final aerobicExercises = exercises.where((e) => e.category == ExerciseCategory.aerobic).toList();
      final anaerobicExercises = exercises.where((e) => e.category == ExerciseCategory.anaerobic).toList();
      
      expect(aerobicExercises, isNotEmpty);
      expect(anaerobicExercises, isNotEmpty);
    });

    test('should contain exercises for all muscle groups', () {
      final exercises = ExerciseSeed.getExercises();
      final muscleGroups = exercises.map((e) => e.muscleGroup).toSet();
      
      expect(muscleGroups.contains(MuscleGroup.chest), true);
      expect(muscleGroups.contains(MuscleGroup.back), true);
      expect(muscleGroups.contains(MuscleGroup.shoulders), true);
      expect(muscleGroups.contains(MuscleGroup.arms), true);
      expect(muscleGroups.contains(MuscleGroup.legs), true);
      expect(muscleGroups.contains(MuscleGroup.core), true);
      expect(muscleGroups.contains(MuscleGroup.cardio), true);
    });

    test('should have unique IDs for all exercises', () {
      final exercises = ExerciseSeed.getExercises();
      final ids = exercises.map((e) => e.id).toList();
      final uniqueIds = ids.toSet();
      
      expect(ids.length, uniqueIds.length); // No duplicate IDs
    });

    test('should have valid exercise properties', () {
      final exercises = ExerciseSeed.getExercises();
      
      for (final exercise in exercises) {
        expect(exercise.id, isNotEmpty);
        expect(exercise.name, isNotEmpty);
        expect(exercise.category, isA<ExerciseCategory>());
        expect(exercise.muscleGroup, isA<MuscleGroup>());
        expect(exercise.defaultUnit, isA<ExerciseUnit>());
        expect(exercise.isMetric, isA<bool>());
      }
    });

    test('should contain specific exercises', () {
      final exercises = ExerciseSeed.getExercises();
      final exerciseNames = exercises.map((e) => e.name).toList();
      
      expect(exerciseNames.contains('Supino Reto'), true);
      expect(exerciseNames.contains('Agachamento Livre'), true);
      expect(exerciseNames.contains('Levantamento Terra'), true);
      expect(exerciseNames.contains('Corrida (Esteira)'), true);
      expect(exerciseNames.contains('Bicicleta Ergométrica'), true);
    });

    test('should have proper unit assignments', () {
      final exercises = ExerciseSeed.getExercises();
      
      for (final exercise in exercises) {
        if (exercise.category == ExerciseCategory.aerobic) {
          expect(exercise.defaultUnit, ExerciseUnit.time);
        } else {
          // Some anaerobic exercises might use time (like planks)
          expect(exercise.defaultUnit, anyOf([
            ExerciseUnit.kg,
            ExerciseUnit.reps,
            ExerciseUnit.time,
          ]));
        }
      }
    });
  });
}
