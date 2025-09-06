import '../../shared/models/badge.dart';

class BadgeSeed {
  static List<Badge> getBadges() {
    return [
      // BADGES DE CONSISTÊNCIA
      Badge(
        id: 'first_workout',
        name: 'Primeiro Passo',
        description: 'Complete seu primeiro treino',
        icon: '🎯',
        rarity: BadgeRarity.common,
      ),
      Badge(
        id: 'streak_3',
        name: 'Consistência',
        description: 'Treine por 3 dias consecutivos',
        icon: '🔥',
        rarity: BadgeRarity.common,
      ),
      Badge(
        id: 'streak_7',
        name: 'Determinação',
        description: 'Treine por 7 dias consecutivos',
        icon: '💪',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'streak_30',
        name: 'Lenda',
        description: 'Treine por 30 dias consecutivos',
        icon: '👑',
        rarity: BadgeRarity.legendary,
      ),
      Badge(
        id: 'hundred_workouts',
        name: 'Centenário',
        description: 'Complete 100 treinos',
        icon: '💯',
        rarity: BadgeRarity.epic,
      ),

      // BADGES DE FORÇA
      Badge(
        id: 'first_pr',
        name: 'Primeiro PR',
        description: 'Bata seu primeiro recorde pessoal',
        icon: '📈',
        rarity: BadgeRarity.common,
      ),
      Badge(
        id: 'bench_100',
        name: 'Supino 100kg',
        description: 'Faça supino com 100kg',
        icon: '🏋️',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'squat_150',
        name: 'Agachamento 150kg',
        description: 'Faça agachamento com 150kg',
        icon: '🦵',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'deadlift_200',
        name: 'Terra 200kg',
        description: 'Faça levantamento terra com 200kg',
        icon: '⚡',
        rarity: BadgeRarity.epic,
      ),

      // BADGES DE VOLUME
      Badge(
        id: 'volume_10k',
        name: 'Levantador',
        description: 'Acumule 10.000kg de volume total',
        icon: '🏋️‍♂️',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'volume_50k',
        name: 'Powerlifter',
        description: 'Acumule 50.000kg de volume total',
        icon: '💪',
        rarity: BadgeRarity.epic,
      ),
      Badge(
        id: 'volume_100k',
        name: 'Hércules',
        description: 'Acumule 100.000kg de volume total',
        icon: '⚡',
        rarity: BadgeRarity.legendary,
      ),

      // BADGES DE NÍVEL
      Badge(
        id: 'level_5',
        name: 'Experiente',
        description: 'Alcance o nível 5',
        icon: '⭐',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'level_10',
        name: 'Mestre',
        description: 'Alcance o nível 10',
        icon: '🌟',
        rarity: BadgeRarity.legendary,
      ),
      Badge(
        id: 'level_25',
        name: 'Lenda Viva',
        description: 'Alcance o nível 25',
        icon: '👑',
        rarity: BadgeRarity.legendary,
      ),

      // BADGES DE PESO
      Badge(
        id: 'weight_loss_5',
        name: 'Menos 5kg',
        description: 'Perdeu 5kg do peso inicial',
        icon: '📉',
        rarity: BadgeRarity.common,
      ),
      Badge(
        id: 'weight_loss_10',
        name: 'Transformação',
        description: 'Perdeu 10kg do peso inicial',
        icon: '🎯',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'weight_gain_5',
        name: 'Crescimento',
        description: 'Ganhou 5kg do peso inicial',
        icon: '📈',
        rarity: BadgeRarity.common,
      ),
      Badge(
        id: 'weight_gain_10',
        name: 'Evolução',
        description: 'Ganhou 10kg do peso inicial',
        icon: '🚀',
        rarity: BadgeRarity.rare,
      ),

      // BADGES DE RESISTÊNCIA
      Badge(
        id: 'cardio_30min',
        name: 'Cardio 30min',
        description: 'Complete 30 minutos de cardio',
        icon: '🏃',
        rarity: BadgeRarity.common,
      ),
      Badge(
        id: 'cardio_60min',
        name: 'Maratonista',
        description: 'Complete 60 minutos de cardio',
        icon: '🏃‍♂️',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'hiit_master',
        name: 'Mestre HIIT',
        description: 'Complete 20 sessões de HIIT',
        icon: '⚡',
        rarity: BadgeRarity.epic,
      ),

      // BADGES ESPECIAIS
      Badge(
        id: 'early_bird',
        name: 'Madrugador',
        description: 'Treine antes das 6h da manhã',
        icon: '🌅',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'night_owl',
        name: 'Coruja Noturna',
        description: 'Treine após as 22h',
        icon: '🦉',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'weekend_warrior',
        name: 'Guerreiro do Fim de Semana',
        description: 'Complete 5 treinos no fim de semana',
        icon: '⚔️',
        rarity: BadgeRarity.rare,
      ),
      Badge(
        id: 'volume_king',
        name: 'Rei do Volume',
        description: 'Complete um treino com mais de 10.000kg de volume',
        icon: '👑',
        rarity: BadgeRarity.legendary,
      ),
    ];
  }
}