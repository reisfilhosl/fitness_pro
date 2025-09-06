import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muvvifit/features/home/widgets/home_tab.dart';
import 'package:muvvifit/shared/models/user.dart';
import 'package:muvvifit/shared/providers/app_providers.dart';

void main() {
  group('HomeTab Widget Tests', () {
    testWidgets('should display user name in app bar', (WidgetTester tester) async {
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

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider.overrideWith((ref) => UserNotifier()..state = user),
            workoutsProvider.overrideWith((ref) => WorkoutsNotifier()..state = []),
            weightEntriesProvider.overrideWith((ref) => WeightEntriesNotifier()..state = []),
          ],
          child: const MaterialApp(
            home: HomeTab(),
          ),
        ),
      );

      expect(find.text('Olá, João!'), findsOneWidget);
    });

    testWidgets('should display empty state when no workouts', (WidgetTester tester) async {
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

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider.overrideWith((ref) => UserNotifier()..state = user),
            workoutsProvider.overrideWith((ref) => WorkoutsNotifier()..state = []),
            weightEntriesProvider.overrideWith((ref) => WeightEntriesNotifier()..state = []),
          ],
          child: const MaterialApp(
            home: HomeTab(),
          ),
        ),
      );

      expect(find.text('Nenhum treino registrado'), findsOneWidget);
      expect(find.text('Toque no botão + para começar'), findsOneWidget);
    });

    testWidgets('should display floating action button', (WidgetTester tester) async {
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

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider.overrideWith((ref) => UserNotifier()..state = user),
            workoutsProvider.overrideWith((ref) => WorkoutsNotifier()..state = []),
            weightEntriesProvider.overrideWith((ref) => WeightEntriesNotifier()..state = []),
          ],
          child: const MaterialApp(
            home: HomeTab(),
          ),
        ),
      );

      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.text('Novo Treino'), findsOneWidget);
    });

    testWidgets('should display user stats correctly', (WidgetTester tester) async {
      final user = User(
        id: 'user_id',
        name: 'João Silva',
        age: 30,
        gender: Gender.male,
        height: 180.0,
        initialWeight: 80.0,
        goal: FitnessGoal.buildMuscle,
        createdAt: DateTime(2024, 1, 1),
        totalWorkouts: 10,
        currentStreak: 5,
        longestStreak: 15,
        totalXP: 2500,
        level: 3,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            userProvider.overrideWith((ref) => UserNotifier()..state = user),
            workoutsProvider.overrideWith((ref) => WorkoutsNotifier()..state = []),
            weightEntriesProvider.overrideWith((ref) => WeightEntriesNotifier()..state = []),
          ],
          child: const MaterialApp(
            home: HomeTab(),
          ),
        ),
      );

      expect(find.text('Nível 3'), findsOneWidget);
      expect(find.text('5 dias'), findsOneWidget);
      expect(find.text('10'), findsOneWidget); // Total workouts
      expect(find.text('2500'), findsOneWidget); // Total XP
      expect(find.text('15'), findsOneWidget); // Longest streak
    });
  });
}