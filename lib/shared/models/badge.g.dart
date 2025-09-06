// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BadgeAdapter extends TypeAdapter<Badge> {
  @override
  final int typeId = 11;

  @override
  Badge read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Badge(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      icon: fields[3] as String,
      rarity: fields[4] as BadgeRarity,
      unlockedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Badge obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.icon)
      ..writeByte(4)
      ..write(obj.rarity)
      ..writeByte(5)
      ..write(obj.unlockedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BadgeRarityAdapter extends TypeAdapter<BadgeRarity> {
  @override
  final int typeId = 12;

  @override
  BadgeRarity read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return BadgeRarity.common;
      case 1:
        return BadgeRarity.rare;
      case 2:
        return BadgeRarity.epic;
      case 3:
        return BadgeRarity.legendary;
      default:
        return BadgeRarity.common;
    }
  }

  @override
  void write(BinaryWriter writer, BadgeRarity obj) {
    switch (obj) {
      case BadgeRarity.common:
        writer.writeByte(0);
        break;
      case BadgeRarity.rare:
        writer.writeByte(1);
        break;
      case BadgeRarity.epic:
        writer.writeByte(2);
        break;
      case BadgeRarity.legendary:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeRarityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Badge _$BadgeFromJson(Map<String, dynamic> json) => Badge(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      rarity: $enumDecode(_$BadgeRarityEnumMap, json['rarity']),
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
    );

Map<String, dynamic> _$BadgeToJson(Badge instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'rarity': _$BadgeRarityEnumMap[instance.rarity]!,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
    };

const _$BadgeRarityEnumMap = {
  BadgeRarity.common: 'common',
  BadgeRarity.rare: 'rare',
  BadgeRarity.epic: 'epic',
  BadgeRarity.legendary: 'legendary',
};
