// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 4;

  @override
  Workout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workout(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      exercises: (fields[2] as List).cast<WorkoutExercise>(),
      duration: fields[3] as Duration?,
      totalVolume: fields[4] as double,
      notes: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.exercises)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.totalVolume)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutExerciseAdapter extends TypeAdapter<WorkoutExercise> {
  @override
  final int typeId = 5;

  @override
  WorkoutExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutExercise(
      id: fields[0] as String,
      exercise: fields[1] as Exercise,
      sets: (fields[2] as List).cast<WorkoutSet>(),
      restTime: fields[3] as Duration?,
      notes: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutExercise obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.exercise)
      ..writeByte(2)
      ..write(obj.sets)
      ..writeByte(3)
      ..write(obj.restTime)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutSetAdapter extends TypeAdapter<WorkoutSet> {
  @override
  final int typeId = 6;

  @override
  WorkoutSet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutSet(
      id: fields[0] as String,
      weight: fields[1] as double,
      reps: fields[2] as int,
      completed: fields[3] as bool,
      restTime: fields[4] as Duration?,
      notes: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutSet obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.completed)
      ..writeByte(4)
      ..write(obj.restTime)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutSetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Workout _$WorkoutFromJson(Map<String, dynamic> json) => Workout(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => WorkoutExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      totalVolume: (json['totalVolume'] as num).toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WorkoutToJson(Workout instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'exercises': instance.exercises,
      'duration': instance.duration?.inMicroseconds,
      'totalVolume': instance.totalVolume,
      'notes': instance.notes,
    };

WorkoutExercise _$WorkoutExerciseFromJson(Map<String, dynamic> json) =>
    WorkoutExercise(
      id: json['id'] as String,
      exercise: Exercise.fromJson(json['exercise'] as Map<String, dynamic>),
      sets: (json['sets'] as List<dynamic>)
          .map((e) => WorkoutSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      restTime: json['restTime'] == null
          ? null
          : Duration(microseconds: (json['restTime'] as num).toInt()),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WorkoutExerciseToJson(WorkoutExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exercise': instance.exercise,
      'sets': instance.sets,
      'restTime': instance.restTime?.inMicroseconds,
      'notes': instance.notes,
    };

WorkoutSet _$WorkoutSetFromJson(Map<String, dynamic> json) => WorkoutSet(
      id: json['id'] as String,
      weight: (json['weight'] as num).toDouble(),
      reps: (json['reps'] as num).toInt(),
      completed: json['completed'] as bool? ?? false,
      restTime: json['restTime'] == null
          ? null
          : Duration(microseconds: (json['restTime'] as num).toInt()),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WorkoutSetToJson(WorkoutSet instance) =>
    <String, dynamic>{
      'id': instance.id,
      'weight': instance.weight,
      'reps': instance.reps,
      'completed': instance.completed,
      'restTime': instance.restTime?.inMicroseconds,
      'notes': instance.notes,
    };
