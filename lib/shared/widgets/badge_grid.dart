import 'package:flutter/material.dart';
import '../models/badge.dart' as models;

class BadgeGrid extends StatelessWidget {
  final List<models.Badge> badges;
  final bool showUnlockedOnly;

  const BadgeGrid({
    super.key,
    required this.badges,
    this.showUnlockedOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredBadges = showUnlockedOnly 
        ? badges.where((b) => b.unlockedAt != null).toList()
        : badges;

    if (filteredBadges.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              showUnlockedOnly 
                  ? 'Nenhum badge desbloqueado ainda'
                  : 'Nenhum badge disponível',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (showUnlockedOnly) ...[
              const SizedBox(height: 8),
              Text(
                'Continue treinando para desbloquear badges!',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: filteredBadges.length,
      itemBuilder: (context, index) {
        final badge = filteredBadges[index];
        return BadgeCard(badge: badge);
      },
    );
  }
}

class BadgeCard extends StatelessWidget {
  final models.Badge badge;

  const BadgeCard({
    super.key,
    required this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isUnlocked = badge.unlockedAt != null;

    return Container(
      decoration: BoxDecoration(
        color: isUnlocked 
            ? _getRarityColor(badge.rarity).withOpacity(0.1)
            : theme.colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUnlocked 
              ? _getRarityColor(badge.rarity)
              : theme.colorScheme.outline.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Badge Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isUnlocked 
                  ? _getRarityColor(badge.rarity)
                  : theme.colorScheme.onSurfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                badge.icon,
                style: TextStyle(
                  fontSize: 20,
                  color: isUnlocked ? Colors.white : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          
          // Badge Name
          Text(
            badge.name,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: isUnlocked 
                  ? theme.colorScheme.onSurface
                  : theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          
          // Rarity Indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: isUnlocked 
                  ? _getRarityColor(badge.rarity).withOpacity(0.2)
                  : theme.colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              badge.rarity.displayName,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isUnlocked 
                    ? _getRarityColor(badge.rarity)
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          
          if (isUnlocked) ...[
            const SizedBox(height: 4),
            Text(
              'Desbloqueado',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getRarityColor(models.BadgeRarity rarity) {
    switch (rarity) {
      case models.BadgeRarity.common:
        return Colors.green;
      case models.BadgeRarity.rare:
        return Colors.blue;
      case models.BadgeRarity.epic:
        return Colors.purple;
      case models.BadgeRarity.legendary:
        return Colors.orange;
    }
  }
}
