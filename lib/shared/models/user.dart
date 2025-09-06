import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@HiveType(typeId: 7)
@JsonSerializable()
class User {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final int age;

  @HiveField(3)
  final Gender gender;

  @HiveField(4)
  final double height; // em cm

  @HiveField(5)
  final double initialWeight; // em kg

  @HiveField(6)
  final FitnessGoal goal;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime? lastWorkoutDate;

  @HiveField(9)
  final int totalWorkouts;

  @HiveField(10)
  final int currentStreak;

  @HiveField(11)
  final int longestStreak;

  @HiveField(12)
  final int totalXP;

  @HiveField(13)
  final int level;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.initialWeight,
    required this.goal,
    required this.createdAt,
    this.lastWorkoutDate,
    this.totalWorkouts = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.totalXP = 0,
    this.level = 1,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? name,
    int? age,
    Gender? gender,
    double? height,
    double? initialWeight,
    FitnessGoal? goal,
    DateTime? createdAt,
    DateTime? lastWorkoutDate,
    int? totalWorkouts,
    int? currentStreak,
    int? longestStreak,
    int? totalXP,
    int? level,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      initialWeight: initialWeight ?? this.initialWeight,
      goal: goal ?? this.goal,
      createdAt: createdAt ?? this.createdAt,
      lastWorkoutDate: lastWorkoutDate ?? this.lastWorkoutDate,
      totalWorkouts: totalWorkouts ?? this.totalWorkouts,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      totalXP: totalXP ?? this.totalXP,
      level: level ?? this.level,
    );
  }

  double get bmi => initialWeight / ((height / 100) * (height / 100));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'User(id: $id, name: $name, level: $level)';
}

@HiveType(typeId: 8)
enum Gender {
  @HiveField(0)
  male,
  @HiveField(1)
  female,
  @HiveField(2)
  other,
}

@HiveType(typeId: 9)
enum FitnessGoal {
  @HiveField(0)
  gainWeight,
  @HiveField(1)
  loseWeight,
  @HiveField(2)
  maintainWeight,
  @HiveField(3)
  buildMuscle,
  @HiveField(4)
  improveEndurance,
}

extension GenderExtension on Gender {
  String get displayName {
    switch (this) {
      case Gender.male:
        return 'Masculino';
      case Gender.female:
        return 'Feminino';
      case Gender.other:
        return 'Outro';
    }
  }
}

extension FitnessGoalExtension on FitnessGoal {
  String get displayName {
    switch (this) {
      case FitnessGoal.gainWeight:
        return 'Ganhar Peso';
      case FitnessGoal.loseWeight:
        return 'Perder Peso';
      case FitnessGoal.maintainWeight:
        return 'Manter Peso';
      case FitnessGoal.buildMuscle:
        return 'Ganhar Massa';
      case FitnessGoal.improveEndurance:
        return 'Melhorar Resistência';
    }
  }
}

