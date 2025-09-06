import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_badge.g.dart';

@HiveType(typeId: 13)
@JsonSerializable()
class UserBadge {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String badgeId;

  @HiveField(3)
  final DateTime unlockedAt;

  const UserBadge({
    required this.id,
    required this.userId,
    required this.badgeId,
    required this.unlockedAt,
  });

  factory UserBadge.fromJson(Map<String, dynamic> json) => _$UserBadgeFromJson(json);
  Map<String, dynamic> toJson() => _$UserBadgeToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserBadge && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'UserBadge(id: $id, userId: $userId, badgeId: $badgeId)';
}
