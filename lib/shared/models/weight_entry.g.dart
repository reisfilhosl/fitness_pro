// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeightEntryAdapter extends TypeAdapter<WeightEntry> {
  @override
  final int typeId = 10;

  @override
  WeightEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeightEntry(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      weight: fields[2] as double,
      notes: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, WeightEntry obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightEntry _$WeightEntryFromJson(Map<String, dynamic> json) => WeightEntry(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      weight: (json['weight'] as num).toDouble(),
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WeightEntryToJson(WeightEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date.toIso8601String(),
      'weight': instance.weight,
      'notes': instance.notes,
    };
