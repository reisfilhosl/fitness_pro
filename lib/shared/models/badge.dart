import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'badge.g.dart';

@HiveType(typeId: 11)
@JsonSerializable()
class Badge {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String icon;

  @HiveField(4)
  final BadgeRarity rarity;

  @HiveField(5)
  final DateTime? unlockedAt;

  const Badge({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.rarity,
    this.unlockedAt,
  });

  factory Badge.fromJson(Map<String, dynamic> json) => _$BadgeFromJson(json);
  Map<String, dynamic> toJson() => _$BadgeToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Badge && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Badge(id: $id, name: $name, rarity: $rarity)';
}

@HiveType(typeId: 12)
enum BadgeRarity {
  @HiveField(0)
  common,
  @HiveField(1)
  rare,
  @HiveField(2)
  epic,
  @HiveField(3)
  legendary,
}

extension BadgeRarityExtension on BadgeRarity {
  String get displayName {
    switch (this) {
      case BadgeRarity.common:
        return 'Comum';
      case BadgeRarity.rare:
        return 'Raro';
      case BadgeRarity.epic:
        return 'Épico';
      case BadgeRarity.legendary:
        return 'Lendário';
    }
  }
}
