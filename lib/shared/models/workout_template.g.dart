// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_template.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutTemplateAdapter extends TypeAdapter<WorkoutTemplate> {
  @override
  final int typeId = 20;

  @override
  WorkoutTemplate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutTemplate(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      exercises: (fields[3] as List).cast<WorkoutTemplateExercise>(),
      category: fields[4] as WorkoutTemplateCategory,
      difficulty: fields[5] as WorkoutTemplateDifficulty,
      estimatedDuration: fields[6] as int,
      imageUrl: fields[7] as String?,
      isCustom: fields[8] as bool,
      createdAt: fields[9] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutTemplate obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.exercises)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.difficulty)
      ..writeByte(6)
      ..write(obj.estimatedDuration)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.isCustom)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutTemplateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutTemplateExerciseAdapter
    extends TypeAdapter<WorkoutTemplateExercise> {
  @override
  final int typeId = 21;

  @override
  WorkoutTemplateExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutTemplateExercise(
      exerciseId: fields[0] as String,
      sets: fields[1] as int,
      reps: fields[2] as int,
      weight: fields[3] as double?,
      restSeconds: fields[4] as int?,
      notes: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutTemplateExercise obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.exerciseId)
      ..writeByte(1)
      ..write(obj.sets)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.restSeconds)
      ..writeByte(5)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutTemplateExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutTemplateCategoryAdapter
    extends TypeAdapter<WorkoutTemplateCategory> {
  @override
  final int typeId = 22;

  @override
  WorkoutTemplateCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkoutTemplateCategory.fullBody;
      case 1:
        return WorkoutTemplateCategory.upperBody;
      case 2:
        return WorkoutTemplateCategory.lowerBody;
      case 3:
        return WorkoutTemplateCategory.push;
      case 4:
        return WorkoutTemplateCategory.pull;
      case 5:
        return WorkoutTemplateCategory.legs;
      case 6:
        return WorkoutTemplateCategory.cardio;
      case 7:
        return WorkoutTemplateCategory.core;
      case 8:
        return WorkoutTemplateCategory.flexibility;
      default:
        return WorkoutTemplateCategory.fullBody;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutTemplateCategory obj) {
    switch (obj) {
      case WorkoutTemplateCategory.fullBody:
        writer.writeByte(0);
        break;
      case WorkoutTemplateCategory.upperBody:
        writer.writeByte(1);
        break;
      case WorkoutTemplateCategory.lowerBody:
        writer.writeByte(2);
        break;
      case WorkoutTemplateCategory.push:
        writer.writeByte(3);
        break;
      case WorkoutTemplateCategory.pull:
        writer.writeByte(4);
        break;
      case WorkoutTemplateCategory.legs:
        writer.writeByte(5);
        break;
      case WorkoutTemplateCategory.cardio:
        writer.writeByte(6);
        break;
      case WorkoutTemplateCategory.core:
        writer.writeByte(7);
        break;
      case WorkoutTemplateCategory.flexibility:
        writer.writeByte(8);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutTemplateCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutTemplateDifficultyAdapter
    extends TypeAdapter<WorkoutTemplateDifficulty> {
  @override
  final int typeId = 23;

  @override
  WorkoutTemplateDifficulty read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkoutTemplateDifficulty.beginner;
      case 1:
        return WorkoutTemplateDifficulty.intermediate;
      case 2:
        return WorkoutTemplateDifficulty.advanced;
      default:
        return WorkoutTemplateDifficulty.beginner;
    }
  }

  @override
  void write(BinaryWriter writer, WorkoutTemplateDifficulty obj) {
    switch (obj) {
      case WorkoutTemplateDifficulty.beginner:
        writer.writeByte(0);
        break;
      case WorkoutTemplateDifficulty.intermediate:
        writer.writeByte(1);
        break;
      case WorkoutTemplateDifficulty.advanced:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutTemplateDifficultyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutTemplate _$WorkoutTemplateFromJson(Map<String, dynamic> json) =>
    WorkoutTemplate(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) =>
              WorkoutTemplateExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: $enumDecode(_$WorkoutTemplateCategoryEnumMap, json['category']),
      difficulty:
          $enumDecode(_$WorkoutTemplateDifficultyEnumMap, json['difficulty']),
      estimatedDuration: (json['estimatedDuration'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      isCustom: json['isCustom'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$WorkoutTemplateToJson(WorkoutTemplate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'exercises': instance.exercises,
      'category': _$WorkoutTemplateCategoryEnumMap[instance.category]!,
      'difficulty': _$WorkoutTemplateDifficultyEnumMap[instance.difficulty]!,
      'estimatedDuration': instance.estimatedDuration,
      'imageUrl': instance.imageUrl,
      'isCustom': instance.isCustom,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$WorkoutTemplateCategoryEnumMap = {
  WorkoutTemplateCategory.fullBody: 'fullBody',
  WorkoutTemplateCategory.upperBody: 'upperBody',
  WorkoutTemplateCategory.lowerBody: 'lowerBody',
  WorkoutTemplateCategory.push: 'push',
  WorkoutTemplateCategory.pull: 'pull',
  WorkoutTemplateCategory.legs: 'legs',
  WorkoutTemplateCategory.cardio: 'cardio',
  WorkoutTemplateCategory.core: 'core',
  WorkoutTemplateCategory.flexibility: 'flexibility',
};

const _$WorkoutTemplateDifficultyEnumMap = {
  WorkoutTemplateDifficulty.beginner: 'beginner',
  WorkoutTemplateDifficulty.intermediate: 'intermediate',
  WorkoutTemplateDifficulty.advanced: 'advanced',
};

WorkoutTemplateExercise _$WorkoutTemplateExerciseFromJson(
        Map<String, dynamic> json) =>
    WorkoutTemplateExercise(
      exerciseId: json['exerciseId'] as String,
      sets: (json['sets'] as num).toInt(),
      reps: (json['reps'] as num).toInt(),
      weight: (json['weight'] as num?)?.toDouble(),
      restSeconds: (json['restSeconds'] as num?)?.toInt(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WorkoutTemplateExerciseToJson(
        WorkoutTemplateExercise instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'sets': instance.sets,
      'reps': instance.reps,
      'weight': instance.weight,
      'restSeconds': instance.restSeconds,
      'notes': instance.notes,
    };
