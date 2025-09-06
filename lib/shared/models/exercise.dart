import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Exercise {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final ExerciseCategory category;

  @HiveField(3)
  final MuscleGroup muscleGroup;

  @HiveField(4)
  final String? equipment;

  @HiveField(5)
  final ExerciseUnit defaultUnit;

  @HiveField(6)
  final bool isMetric;

  @HiveField(7)
  final String? description;

  const Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.muscleGroup,
    this.equipment,
    required this.defaultUnit,
    this.isMetric = true,
    this.description,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$ExerciseToJson(this);

  Exercise copyWith({
    String? id,
    String? name,
    ExerciseCategory? category,
    MuscleGroup? muscleGroup,
    String? equipment,
    ExerciseUnit? defaultUnit,
    bool? isMetric,
    String? description,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      equipment: equipment ?? this.equipment,
      defaultUnit: defaultUnit ?? this.defaultUnit,
      isMetric: isMetric ?? this.isMetric,
      description: description ?? this.description,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Exercise && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Exercise(id: $id, name: $name, category: $category)';
}

@HiveType(typeId: 1)
enum ExerciseCategory {
  @HiveField(0)
  aerobic,
  @HiveField(1)
  anaerobic,
}

@HiveType(typeId: 2)
enum MuscleGroup {
  @HiveField(0)
  chest,
  @HiveField(1)
  back,
  @HiveField(2)
  shoulders,
  @HiveField(3)
  arms,
  @HiveField(4)
  legs,
  @HiveField(5)
  core,
  @HiveField(6)
  glutes,
  @HiveField(7)
  calves,
  @HiveField(8)
  fullBody,
  @HiveField(9)
  cardio,
}

@HiveType(typeId: 3)
enum ExerciseUnit {
  @HiveField(0)
  kg,
  @HiveField(1)
  reps,
  @HiveField(2)
  time,
  @HiveField(3)
  distance,
  @HiveField(4)
  calories,
}

extension ExerciseCategoryExtension on ExerciseCategory {
  String get displayName {
    switch (this) {
      case ExerciseCategory.aerobic:
        return 'Aeróbico';
      case ExerciseCategory.anaerobic:
        return 'Anaeróbico';
    }
  }
}

extension MuscleGroupExtension on MuscleGroup {
  String get displayName {
    switch (this) {
      case MuscleGroup.chest:
        return 'Peito';
      case MuscleGroup.back:
        return 'Costas';
      case MuscleGroup.shoulders:
        return 'Ombros';
      case MuscleGroup.arms:
        return 'Braços';
      case MuscleGroup.legs:
        return 'Pernas';
      case MuscleGroup.core:
        return 'Core';
      case MuscleGroup.glutes:
        return 'Glúteos';
      case MuscleGroup.calves:
        return 'Panturrilhas';
      case MuscleGroup.fullBody:
        return 'Corpo Inteiro';
      case MuscleGroup.cardio:
        return 'Cardio';
    }
  }
}

extension ExerciseUnitExtension on ExerciseUnit {
  String get displayName {
    switch (this) {
      case ExerciseUnit.kg:
        return 'kg';
      case ExerciseUnit.reps:
        return 'reps';
      case ExerciseUnit.time:
        return 'min';
      case ExerciseUnit.distance:
        return 'km';
      case ExerciseUnit.calories:
        return 'cal';
    }
  }
}

