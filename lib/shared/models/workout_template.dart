import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_template.g.dart';

@HiveType(typeId: 20)
@JsonSerializable()
class WorkoutTemplate {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<WorkoutTemplateExercise> exercises;

  @HiveField(4)
  final WorkoutTemplateCategory category;

  @HiveField(5)
  final WorkoutTemplateDifficulty difficulty;

  @HiveField(6)
  final int estimatedDuration; // em minutos

  @HiveField(7)
  final String? imageUrl;

  @HiveField(8)
  final bool isCustom;

  @HiveField(9)
  final DateTime createdAt;

  const WorkoutTemplate({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.category,
    required this.difficulty,
    required this.estimatedDuration,
    this.imageUrl,
    this.isCustom = false,
    required this.createdAt,
  });

  factory WorkoutTemplate.fromJson(Map<String, dynamic> json) => _$WorkoutTemplateFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutTemplateToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkoutTemplate && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WorkoutTemplate(id: $id, name: $name, category: $category)';
}

@HiveType(typeId: 21)
@JsonSerializable()
class WorkoutTemplateExercise {
  @HiveField(0)
  final String exerciseId;

  @HiveField(1)
  final int sets;

  @HiveField(2)
  final int reps;

  @HiveField(3)
  final double? weight; // em kg

  @HiveField(4)
  final int? restSeconds;

  @HiveField(5)
  final String? notes;

  const WorkoutTemplateExercise({
    required this.exerciseId,
    required this.sets,
    required this.reps,
    this.weight,
    this.restSeconds,
    this.notes,
  });

  factory WorkoutTemplateExercise.fromJson(Map<String, dynamic> json) => _$WorkoutTemplateExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutTemplateExerciseToJson(this);
}

@HiveType(typeId: 22)
enum WorkoutTemplateCategory {
  @HiveField(0)
  fullBody,
  @HiveField(1)
  upperBody,
  @HiveField(2)
  lowerBody,
  @HiveField(3)
  push,
  @HiveField(4)
  pull,
  @HiveField(5)
  legs,
  @HiveField(6)
  cardio,
  @HiveField(7)
  core,
  @HiveField(8)
  flexibility,
}

@HiveType(typeId: 23)
enum WorkoutTemplateDifficulty {
  @HiveField(0)
  beginner,
  @HiveField(1)
  intermediate,
  @HiveField(2)
  advanced,
}

extension WorkoutTemplateCategoryExtension on WorkoutTemplateCategory {
  String get displayName {
    switch (this) {
      case WorkoutTemplateCategory.fullBody:
        return 'Corpo Inteiro';
      case WorkoutTemplateCategory.upperBody:
        return 'Membros Superiores';
      case WorkoutTemplateCategory.lowerBody:
        return 'Membros Inferiores';
      case WorkoutTemplateCategory.push:
        return 'Empurrar';
      case WorkoutTemplateCategory.pull:
        return 'Puxar';
      case WorkoutTemplateCategory.legs:
        return 'Pernas';
      case WorkoutTemplateCategory.cardio:
        return 'Cardio';
      case WorkoutTemplateCategory.core:
        return 'Core';
      case WorkoutTemplateCategory.flexibility:
        return 'Flexibilidade';
    }
  }

  String get emoji {
    switch (this) {
      case WorkoutTemplateCategory.fullBody:
        return '💪';
      case WorkoutTemplateCategory.upperBody:
        return '💪';
      case WorkoutTemplateCategory.lowerBody:
        return '🦵';
      case WorkoutTemplateCategory.push:
        return '🏋️';
      case WorkoutTemplateCategory.pull:
        return '🏋️‍♂️';
      case WorkoutTemplateCategory.legs:
        return '🦵';
      case WorkoutTemplateCategory.cardio:
        return '🏃';
      case WorkoutTemplateCategory.core:
        return '🔥';
      case WorkoutTemplateCategory.flexibility:
        return '🧘';
    }
  }
}

extension WorkoutTemplateDifficultyExtension on WorkoutTemplateDifficulty {
  String get displayName {
    switch (this) {
      case WorkoutTemplateDifficulty.beginner:
        return 'Iniciante';
      case WorkoutTemplateDifficulty.intermediate:
        return 'Intermediário';
      case WorkoutTemplateDifficulty.advanced:
        return 'Avançado';
    }
  }

  String get emoji {
    switch (this) {
      case WorkoutTemplateDifficulty.beginner:
        return '🌱';
      case WorkoutTemplateDifficulty.intermediate:
        return '🌿';
      case WorkoutTemplateDifficulty.advanced:
        return '🌳';
    }
  }
}
