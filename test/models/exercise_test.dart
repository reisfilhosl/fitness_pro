import 'package:flutter_test/flutter_test.dart';
import 'package:muvvifit/shared/models/exercise.dart';

void main() {
  group('Exercise Model Tests', () {
    test('should create exercise with correct properties', () {
      final exercise = Exercise(
        id: 'test_id',
        name: 'Supino Reto',
        category: ExerciseCategory.anaerobic,
        muscleGroup: MuscleGroup.chest,
        equipment: 'Barra',
        defaultUnit: ExerciseUnit.kg,
        description: 'Test description',
      );

      expect(exercise.id, 'test_id');
      expect(exercise.name, 'Supino Reto');
      expect(exercise.category, ExerciseCategory.anaerobic);
      expect(exercise.muscleGroup, MuscleGroup.chest);
      expect(exercise.equipment, 'Barra');
      expect(exercise.defaultUnit, ExerciseUnit.kg);
      expect(exercise.description, 'Test description');
      expect(exercise.isMetric, true);
    });

    test('should create exercise copy with updated properties', () {
      final originalExercise = Exercise(
        id: 'test_id',
        name: 'Supino Reto',
        category: ExerciseCategory.anaerobic,
        muscleGroup: MuscleGroup.chest,
        equipment: 'Barra',
        defaultUnit: ExerciseUnit.kg,
      );

      final updatedExercise = originalExercise.copyWith(
        name: 'Supino Inclinado',
        equipment: 'Halteres',
      );

      expect(updatedExercise.id, 'test_id');
      expect(updatedExercise.name, 'Supino Inclinado');
      expect(updatedExercise.equipment, 'Halteres');
      expect(updatedExercise.category, ExerciseCategory.anaerobic);
      expect(updatedExercise.muscleGroup, MuscleGroup.chest);
    });

    test('should test equality correctly', () {
      final exercise1 = Exercise(
        id: 'test_id',
        name: 'Supino Reto',
        category: ExerciseCategory.anaerobic,
        muscleGroup: MuscleGroup.chest,
        equipment: 'Barra',
        defaultUnit: ExerciseUnit.kg,
      );

      final exercise2 = Exercise(
        id: 'test_id',
        name: 'Supino Inclinado',
        category: ExerciseCategory.anaerobic,
        muscleGroup: MuscleGroup.chest,
        equipment: 'Halteres',
        defaultUnit: ExerciseUnit.kg,
      );

      final exercise3 = Exercise(
        id: 'different_id',
        name: 'Supino Reto',
        category: ExerciseCategory.anaerobic,
        muscleGroup: MuscleGroup.chest,
        equipment: 'Barra',
        defaultUnit: ExerciseUnit.kg,
      );

      expect(exercise1 == exercise2, true); // Same ID
      expect(exercise1 == exercise3, false); // Different ID
    });
  });

  group('ExerciseCategory Extension Tests', () {
    test('should return correct display names', () {
      expect(ExerciseCategory.aerobic.displayName, 'Aeróbico');
      expect(ExerciseCategory.anaerobic.displayName, 'Anaeróbico');
    });
  });

  group('MuscleGroup Extension Tests', () {
    test('should return correct display names', () {
      expect(MuscleGroup.chest.displayName, 'Peito');
      expect(MuscleGroup.back.displayName, 'Costas');
      expect(MuscleGroup.shoulders.displayName, 'Ombros');
      expect(MuscleGroup.arms.displayName, 'Braços');
      expect(MuscleGroup.legs.displayName, 'Pernas');
      expect(MuscleGroup.core.displayName, 'Core');
      expect(MuscleGroup.glutes.displayName, 'Glúteos');
      expect(MuscleGroup.calves.displayName, 'Panturrilhas');
      expect(MuscleGroup.fullBody.displayName, 'Corpo Inteiro');
      expect(MuscleGroup.cardio.displayName, 'Cardio');
    });
  });

  group('ExerciseUnit Extension Tests', () {
    test('should return correct display names', () {
      expect(ExerciseUnit.kg.displayName, 'kg');
      expect(ExerciseUnit.reps.displayName, 'reps');
      expect(ExerciseUnit.time.displayName, 'min');
      expect(ExerciseUnit.distance.displayName, 'km');
      expect(ExerciseUnit.calories.displayName, 'cal');
    });
  });
}

