import 'package:flutter_test/flutter_test.dart';
import 'package:muvvifit/shared/models/exercise.dart';
import 'package:muvvifit/shared/models/workout.dart';

void main() {
  group('WorkoutSet Model Tests', () {
    test('should create workout set with correct properties', () {
      final set = WorkoutSet(
        id: 'set_id',
        weight: 100.0,
        reps: 10,
        completed: true,
      );

      expect(set.id, 'set_id');
      expect(set.weight, 100.0);
      expect(set.reps, 10);
      expect(set.completed, true);
      expect(set.volume, 1000.0); // weight * reps
    });

    test('should calculate volume correctly', () {
      final set1 = WorkoutSet(id: '1', weight: 50.0, reps: 8);
      final set2 = WorkoutSet(id: '2', weight: 75.0, reps: 5);
      
      expect(set1.volume, 400.0);
      expect(set2.volume, 375.0);
    });

    test('should create workout set copy with updated properties', () {
      final originalSet = WorkoutSet(
        id: 'set_id',
        weight: 100.0,
        reps: 10,
        completed: false,
      );

      final updatedSet = originalSet.copyWith(
        weight: 110.0,
        completed: true,
      );

      expect(updatedSet.id, 'set_id');
      expect(updatedSet.weight, 110.0);
      expect(updatedSet.reps, 10);
      expect(updatedSet.completed, true);
    });
  });

  group('WorkoutExercise Model Tests', () {
    late Exercise testExercise;
    late List<WorkoutSet> testSets;

    setUp(() {
      testExercise = Exercise(
        id: 'exercise_id',
        name: 'Supino Reto',
        category: ExerciseCategory.anaerobic,
        muscleGroup: MuscleGroup.chest,
        equipment: 'Barra',
        defaultUnit: ExerciseUnit.kg,
      );

      testSets = [
        WorkoutSet(id: '1', weight: 100.0, reps: 10),
        WorkoutSet(id: '2', weight: 105.0, reps: 8),
        WorkoutSet(id: '3', weight: 110.0, reps: 6),
      ];
    });

    test('should create workout exercise with correct properties', () {
      final workoutExercise = WorkoutExercise(
        id: 'workout_exercise_id',
        exercise: testExercise,
        sets: testSets,
      );

      expect(workoutExercise.id, 'workout_exercise_id');
      expect(workoutExercise.exercise, testExercise);
      expect(workoutExercise.sets, testSets);
      expect(workoutExercise.totalVolume, 2500.0); // Sum of all sets volumes
    });

    test('should calculate total volume correctly', () {
      final workoutExercise = WorkoutExercise(
        id: 'workout_exercise_id',
        exercise: testExercise,
        sets: testSets,
      );

      expect(workoutExercise.totalVolume, 2500.0);
    });

    test('should create workout exercise copy with updated properties', () {
      final originalWorkoutExercise = WorkoutExercise(
        id: 'workout_exercise_id',
        exercise: testExercise,
        sets: testSets,
      );

      final newSets = [
        ...testSets,
        WorkoutSet(id: '4', weight: 115.0, reps: 4),
      ];

      final updatedWorkoutExercise = originalWorkoutExercise.copyWith(
        sets: newSets,
      );

      expect(updatedWorkoutExercise.id, 'workout_exercise_id');
      expect(updatedWorkoutExercise.exercise, testExercise);
      expect(updatedWorkoutExercise.sets, newSets);
      expect(updatedWorkoutExercise.totalVolume, 2960.0);
    });
  });

  group('Workout Model Tests', () {
    late List<WorkoutExercise> testExercises;

    setUp(() {
      final exercise = Exercise(
        id: 'exercise_id',
        name: 'Supino Reto',
        category: ExerciseCategory.anaerobic,
        muscleGroup: MuscleGroup.chest,
        equipment: 'Barra',
        defaultUnit: ExerciseUnit.kg,
      );

      final sets = [
        WorkoutSet(id: '1', weight: 100.0, reps: 10),
        WorkoutSet(id: '2', weight: 105.0, reps: 8),
      ];

      testExercises = [
        WorkoutExercise(
          id: 'workout_exercise_1',
          exercise: exercise,
          sets: sets,
        ),
      ];
    });

    test('should create workout with correct properties', () {
      final workout = Workout(
        id: 'workout_id',
        date: DateTime(2024, 1, 1),
        exercises: testExercises,
        totalVolume: 1850.0,
        notes: 'Test workout',
      );

      expect(workout.id, 'workout_id');
      expect(workout.date, DateTime(2024, 1, 1));
      expect(workout.exercises, testExercises);
      expect(workout.totalVolume, 1850.0);
      expect(workout.notes, 'Test workout');
    });

    test('should create workout copy with updated properties', () {
      final originalWorkout = Workout(
        id: 'workout_id',
        date: DateTime(2024, 1, 1),
        exercises: testExercises,
        totalVolume: 1850.0,
      );

      final updatedWorkout = originalWorkout.copyWith(
        totalVolume: 2000.0,
        notes: 'Updated workout',
      );

      expect(updatedWorkout.id, 'workout_id');
      expect(updatedWorkout.date, DateTime(2024, 1, 1));
      expect(updatedWorkout.exercises, testExercises);
      expect(updatedWorkout.totalVolume, 2000.0);
      expect(updatedWorkout.notes, 'Updated workout');
    });
  });
}
