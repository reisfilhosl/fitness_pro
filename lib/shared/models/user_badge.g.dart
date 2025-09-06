// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_badge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBadgeAdapter extends TypeAdapter<UserBadge> {
  @override
  final int typeId = 13;

  @override
  UserBadge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBadge(
      id: fields[0] as String,
      userId: fields[1] as String,
      badgeId: fields[2] as String,
      unlockedAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, UserBadge obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.badgeId)
      ..writeByte(3)
      ..write(obj.unlockedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBadgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBadge _$UserBadgeFromJson(Map<String, dynamic> json) => UserBadge(
      id: json['id'] as String,
      userId: json['userId'] as String,
      badgeId: json['badgeId'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
    );

Map<String, dynamic> _$UserBadgeToJson(UserBadge instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'badgeId': instance.badgeId,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
    };
