import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weight_entry.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class WeightEntry {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final double weight; // em kg

  @HiveField(3)
  final String? notes;

  const WeightEntry({
    required this.id,
    required this.date,
    required this.weight,
    this.notes,
  });

  factory WeightEntry.fromJson(Map<String, dynamic> json) => _$WeightEntryFromJson(json);
  Map<String, dynamic> toJson() => _$WeightEntryToJson(this);

  WeightEntry copyWith({
    String? id,
    DateTime? date,
    double? weight,
    String? notes,
  }) {
    return WeightEntry(
      id: id ?? this.id,
      date: date ?? this.date,
      weight: weight ?? this.weight,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is WeightEntry && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'WeightEntry(id: $id, date: $date, weight: $weight)';
}

