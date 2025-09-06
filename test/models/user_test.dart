import 'package:flutter_test/flutter_test.dart';
import 'package:muvvifit/shared/models/user.dart';

void main() {
  group('User Model Tests', () {
    test('should create user with correct properties', () {
      final user = User(
        id: 'user_id',
        name: 'João Silva',
        age: 30,
        gender: Gender.male,
        height: 180.0,
        initialWeight: 80.0,
        goal: FitnessGoal.buildMuscle,
        createdAt: DateTime(2024, 1, 1),
      );

      expect(user.id, 'user_id');
      expect(user.name, 'João Silva');
      expect(user.age, 30);
      expect(user.gender, Gender.male);
      expect(user.height, 180.0);
      expect(user.initialWeight, 80.0);
      expect(user.goal, FitnessGoal.buildMuscle);
      expect(user.createdAt, DateTime(2024, 1, 1));
      expect(user.totalWorkouts, 0);
      expect(user.currentStreak, 0);
      expect(user.longestStreak, 0);
      expect(user.totalXP, 0);
      expect(user.level, 1);
    });

    test('should calculate BMI correctly', () {
      final user = User(
        id: 'user_id',
        name: 'João Silva',
        age: 30,
        gender: Gender.male,
        height: 180.0, // 1.80m
        initialWeight: 80.0, // 80kg
        goal: FitnessGoal.buildMuscle,
        createdAt: DateTime(2024, 1, 1),
      );

      // BMI = weight(kg) / height(m)²
      // BMI = 80 / (1.80)² = 80 / 3.24 = 24.69
      expect(user.bmi, closeTo(24.69, 0.01));
    });

    test('should create user copy with updated properties', () {
      final originalUser = User(
        id: 'user_id',
        name: 'João Silva',
        age: 30,
        gender: Gender.male,
        height: 180.0,
        initialWeight: 80.0,
        goal: FitnessGoal.buildMuscle,
        createdAt: DateTime(2024, 1, 1),
      );

      final updatedUser = originalUser.copyWith(
        name: 'João Santos',
        age: 31,
        totalWorkouts: 10,
        totalXP: 1000,
        level: 2,
      );

      expect(updatedUser.id, 'user_id');
      expect(updatedUser.name, 'João Santos');
      expect(updatedUser.age, 31);
      expect(updatedUser.gender, Gender.male);
      expect(updatedUser.height, 180.0);
      expect(updatedUser.initialWeight, 80.0);
      expect(updatedUser.goal, FitnessGoal.buildMuscle);
      expect(updatedUser.createdAt, DateTime(2024, 1, 1));
      expect(updatedUser.totalWorkouts, 10);
      expect(updatedUser.totalXP, 1000);
      expect(updatedUser.level, 2);
    });
  });

  group('Gender Extension Tests', () {
    test('should return correct display names', () {
      expect(Gender.male.displayName, 'Masculino');
      expect(Gender.female.displayName, 'Feminino');
      expect(Gender.other.displayName, 'Outro');
    });
  });

  group('FitnessGoal Extension Tests', () {
    test('should return correct display names', () {
      expect(FitnessGoal.gainWeight.displayName, 'Ganhar Peso');
      expect(FitnessGoal.loseWeight.displayName, 'Perder Peso');
      expect(FitnessGoal.maintainWeight.displayName, 'Manter Peso');
      expect(FitnessGoal.buildMuscle.displayName, 'Ganhar Massa');
      expect(FitnessGoal.improveEndurance.displayName, 'Melhorar Resistência');
    });
  });
}

