import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'exercise.dart';

part 'workout.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class Workout {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final List<WorkoutExercise> exercises;

  @HiveField(3)
  final Duration? duration;

  @HiveField(4)
  final double totalVolume;

  @HiveField(5)
  final String? notes;

  const Workout({
    required this.id,
    required this.date,
    required this.exercises,
    this.duration,
    required this.totalVolume,
    this.notes,
  });

  factory Workout.fromJson(Map<String, dynamic> json) => _$WorkoutFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutToJson(this);

  Workout copyWith({
    String? id,
    DateTime? date,
    List<WorkoutExercise>? exercises,
    Duration? duration,
    double? totalVolume,
    String? notes,
  }) {
    return Workout(
      id: id ?? this.id,
      date: date ?? this.date,
      exercises: exercises ?? this.exercises,
      duration: duration ?? this.duration,
      totalVolume: totalVolume ?? this.totalVolume,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Workout && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Workout(id: $id, date: $date, exercises: ${exercises.length})';
}

@HiveType(typeId: 5)
@JsonSerializable()
class WorkoutExercise {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final Exercise exercise;

  @HiveField(2)
  final List<WorkoutSet> sets;

  @HiveField(3)
  final Duration? restTime;

  @HiveField(4)
  final String? notes;

  const WorkoutExercise({
    required this.id,
    required this.exercise,
    required this.sets,
    this.restTime,
    this.notes,
  });

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) => _$WorkoutExerciseFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutExerciseToJson(this);

  WorkoutExercise copyWith({
    String? id,
    Exercise? exercise,
    List<WorkoutSet>? sets,
    Duration? restTime,
    String? notes,
  }) {
    return WorkoutExercise(
      id: id ?? this.id,
      exercise: exercise ?? this.exercise,
      sets: sets ?? this.sets,
      restTime: restTime ?? this.restTime,
      notes: notes ?? this.notes,
    );
  }

  double get totalVolume {
    return sets.fold(0.0, (sum, set) => sum + set.volume);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkoutExercise && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WorkoutExercise(id: $id, exercise: ${exercise.name}, sets: ${sets.length})';
}

@HiveType(typeId: 6)
@JsonSerializable()
class WorkoutSet {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final double weight;

  @HiveField(2)
  final int reps;

  @HiveField(3)
  final bool completed;

  @HiveField(4)
  final Duration? restTime;

  @HiveField(5)
  final String? notes;

  const WorkoutSet({
    required this.id,
    required this.weight,
    required this.reps,
    this.completed = false,
    this.restTime,
    this.notes,
  });

  factory WorkoutSet.fromJson(Map<String, dynamic> json) => _$WorkoutSetFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutSetToJson(this);

  WorkoutSet copyWith({
    String? id,
    double? weight,
    int? reps,
    bool? completed,
    Duration? restTime,
    String? notes,
  }) {
    return WorkoutSet(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      completed: completed ?? this.completed,
      restTime: restTime ?? this.restTime,
      notes: notes ?? this.notes,
    );
  }

  double get volume => weight * reps;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WorkoutSet && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WorkoutSet(id: $id, weight: $weight, reps: $reps, completed: $completed)';
}

