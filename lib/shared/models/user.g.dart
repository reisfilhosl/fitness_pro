// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 7;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String,
      name: fields[1] as String,
      age: fields[2] as int,
      gender: fields[3] as Gender,
      height: fields[4] as double,
      initialWeight: fields[5] as double,
      goal: fields[6] as FitnessGoal,
      createdAt: fields[7] as DateTime,
      lastWorkoutDate: fields[8] as DateTime?,
      totalWorkouts: fields[9] as int,
      currentStreak: fields[10] as int,
      longestStreak: fields[11] as int,
      totalXP: fields[12] as int,
      level: fields[13] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.gender)
      ..writeByte(4)
      ..write(obj.height)
      ..writeByte(5)
      ..write(obj.initialWeight)
      ..writeByte(6)
      ..write(obj.goal)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.lastWorkoutDate)
      ..writeByte(9)
      ..write(obj.totalWorkouts)
      ..writeByte(10)
      ..write(obj.currentStreak)
      ..writeByte(11)
      ..write(obj.longestStreak)
      ..writeByte(12)
      ..write(obj.totalXP)
      ..writeByte(13)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GenderAdapter extends TypeAdapter<Gender> {
  @override
  final int typeId = 8;

  @override
  Gender read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      case 2:
        return Gender.other;
      default:
        return Gender.male;
    }
  }

  @override
  void write(BinaryWriter writer, Gender obj) {
    switch (obj) {
      case Gender.male:
        writer.writeByte(0);
        break;
      case Gender.female:
        writer.writeByte(1);
        break;
      case Gender.other:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FitnessGoalAdapter extends TypeAdapter<FitnessGoal> {
  @override
  final int typeId = 9;

  @override
  FitnessGoal read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FitnessGoal.gainWeight;
      case 1:
        return FitnessGoal.loseWeight;
      case 2:
        return FitnessGoal.maintainWeight;
      case 3:
        return FitnessGoal.buildMuscle;
      case 4:
        return FitnessGoal.improveEndurance;
      default:
        return FitnessGoal.gainWeight;
    }
  }

  @override
  void write(BinaryWriter writer, FitnessGoal obj) {
    switch (obj) {
      case FitnessGoal.gainWeight:
        writer.writeByte(0);
        break;
      case FitnessGoal.loseWeight:
        writer.writeByte(1);
        break;
      case FitnessGoal.maintainWeight:
        writer.writeByte(2);
        break;
      case FitnessGoal.buildMuscle:
        writer.writeByte(3);
        break;
      case FitnessGoal.improveEndurance:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FitnessGoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      height: (json['height'] as num).toDouble(),
      initialWeight: (json['initialWeight'] as num).toDouble(),
      goal: $enumDecode(_$FitnessGoalEnumMap, json['goal']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      lastWorkoutDate: json['lastWorkoutDate'] == null
          ? null
          : DateTime.parse(json['lastWorkoutDate'] as String),
      totalWorkouts: (json['totalWorkouts'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      totalXP: (json['totalXP'] as num?)?.toInt() ?? 0,
      level: (json['level'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'gender': _$GenderEnumMap[instance.gender]!,
      'height': instance.height,
      'initialWeight': instance.initialWeight,
      'goal': _$FitnessGoalEnumMap[instance.goal]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'lastWorkoutDate': instance.lastWorkoutDate?.toIso8601String(),
      'totalWorkouts': instance.totalWorkouts,
      'currentStreak': instance.currentStreak,
      'longestStreak': instance.longestStreak,
      'totalXP': instance.totalXP,
      'level': instance.level,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.other: 'other',
};

const _$FitnessGoalEnumMap = {
  FitnessGoal.gainWeight: 'gainWeight',
  FitnessGoal.loseWeight: 'loseWeight',
  FitnessGoal.maintainWeight: 'maintainWeight',
  FitnessGoal.buildMuscle: 'buildMuscle',
  FitnessGoal.improveEndurance: 'improveEndurance',
};
