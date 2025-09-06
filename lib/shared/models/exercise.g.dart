// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 0;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as ExerciseCategory,
      muscleGroup: fields[3] as MuscleGroup,
      equipment: fields[4] as String?,
      defaultUnit: fields[5] as ExerciseUnit,
      isMetric: fields[6] as bool,
      description: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.muscleGroup)
      ..writeByte(4)
      ..write(obj.equipment)
      ..writeByte(5)
      ..write(obj.defaultUnit)
      ..writeByte(6)
      ..write(obj.isMetric)
      ..writeByte(7)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseCategoryAdapter extends TypeAdapter<ExerciseCategory> {
  @override
  final int typeId = 1;

  @override
  ExerciseCategory read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExerciseCategory.aerobic;
      case 1:
        return ExerciseCategory.anaerobic;
      default:
        return ExerciseCategory.aerobic;
    }
  }

  @override
  void write(BinaryWriter writer, ExerciseCategory obj) {
    switch (obj) {
      case ExerciseCategory.aerobic:
        writer.writeByte(0);
        break;
      case ExerciseCategory.anaerobic:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MuscleGroupAdapter extends TypeAdapter<MuscleGroup> {
  @override
  final int typeId = 2;

  @override
  MuscleGroup read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MuscleGroup.chest;
      case 1:
        return MuscleGroup.back;
      case 2:
        return MuscleGroup.shoulders;
      case 3:
        return MuscleGroup.arms;
      case 4:
        return MuscleGroup.legs;
      case 5:
        return MuscleGroup.core;
      case 6:
        return MuscleGroup.glutes;
      case 7:
        return MuscleGroup.calves;
      case 8:
        return MuscleGroup.fullBody;
      case 9:
        return MuscleGroup.cardio;
      default:
        return MuscleGroup.chest;
    }
  }

  @override
  void write(BinaryWriter writer, MuscleGroup obj) {
    switch (obj) {
      case MuscleGroup.chest:
        writer.writeByte(0);
        break;
      case MuscleGroup.back:
        writer.writeByte(1);
        break;
      case MuscleGroup.shoulders:
        writer.writeByte(2);
        break;
      case MuscleGroup.arms:
        writer.writeByte(3);
        break;
      case MuscleGroup.legs:
        writer.writeByte(4);
        break;
      case MuscleGroup.core:
        writer.writeByte(5);
        break;
      case MuscleGroup.glutes:
        writer.writeByte(6);
        break;
      case MuscleGroup.calves:
        writer.writeByte(7);
        break;
      case MuscleGroup.fullBody:
        writer.writeByte(8);
        break;
      case MuscleGroup.cardio:
        writer.writeByte(9);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MuscleGroupAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseUnitAdapter extends TypeAdapter<ExerciseUnit> {
  @override
  final int typeId = 3;

  @override
  ExerciseUnit read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExerciseUnit.kg;
      case 1:
        return ExerciseUnit.reps;
      case 2:
        return ExerciseUnit.time;
      case 3:
        return ExerciseUnit.distance;
      case 4:
        return ExerciseUnit.calories;
      default:
        return ExerciseUnit.kg;
    }
  }

  @override
  void write(BinaryWriter writer, ExerciseUnit obj) {
    switch (obj) {
      case ExerciseUnit.kg:
        writer.writeByte(0);
        break;
      case ExerciseUnit.reps:
        writer.writeByte(1);
        break;
      case ExerciseUnit.time:
        writer.writeByte(2);
        break;
      case ExerciseUnit.distance:
        writer.writeByte(3);
        break;
      case ExerciseUnit.calories:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseUnitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      category: $enumDecode(_$ExerciseCategoryEnumMap, json['category']),
      muscleGroup: $enumDecode(_$MuscleGroupEnumMap, json['muscleGroup']),
      equipment: json['equipment'] as String?,
      defaultUnit: $enumDecode(_$ExerciseUnitEnumMap, json['defaultUnit']),
      isMetric: json['isMetric'] as bool? ?? true,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': _$ExerciseCategoryEnumMap[instance.category]!,
      'muscleGroup': _$MuscleGroupEnumMap[instance.muscleGroup]!,
      'equipment': instance.equipment,
      'defaultUnit': _$ExerciseUnitEnumMap[instance.defaultUnit]!,
      'isMetric': instance.isMetric,
      'description': instance.description,
    };

const _$ExerciseCategoryEnumMap = {
  ExerciseCategory.aerobic: 'aerobic',
  ExerciseCategory.anaerobic: 'anaerobic',
};

const _$MuscleGroupEnumMap = {
  MuscleGroup.chest: 'chest',
  MuscleGroup.back: 'back',
  MuscleGroup.shoulders: 'shoulders',
  MuscleGroup.arms: 'arms',
  MuscleGroup.legs: 'legs',
  MuscleGroup.core: 'core',
  MuscleGroup.glutes: 'glutes',
  MuscleGroup.calves: 'calves',
  MuscleGroup.fullBody: 'fullBody',
  MuscleGroup.cardio: 'cardio',
};

const _$ExerciseUnitEnumMap = {
  ExerciseUnit.kg: 'kg',
  ExerciseUnit.reps: 'reps',
  ExerciseUnit.time: 'time',
  ExerciseUnit.distance: 'distance',
  ExerciseUnit.calories: 'calories',
};
