import '../../shared/models/workout_template.dart';

class WorkoutTemplateSeed {
  static List<WorkoutTemplate> getTemplates() {
    return [
      // Treino de Corpo Inteiro - Iniciante
      WorkoutTemplate(
        id: 'fullbody_beginner_1',
        name: 'Corpo Inteiro Iniciante',
        description: 'Treino completo para iniciantes, trabalhando todos os grupos musculares',
        category: WorkoutTemplateCategory.fullBody,
        difficulty: WorkoutTemplateDifficulty.beginner,
        estimatedDuration: 45,
        exercises: [
          const WorkoutTemplateExercise(
            exerciseId: 'squat',
            sets: 3,
            reps: 12,
            restSeconds: 60,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'push_up',
            sets: 3,
            reps: 8,
            restSeconds: 60,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'plank',
            sets: 3,
            reps: 30, // segundos
            restSeconds: 45,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'lunges',
            sets: 3,
            reps: 10,
            restSeconds: 60,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'dumbbell_row',
            sets: 3,
            reps: 10,
            restSeconds: 60,
          ),
        ],
        createdAt: DateTime.now(),
      ),

      // Treino de Empurrar - Intermediário
      WorkoutTemplate(
        id: 'push_intermediate_1',
        name: 'Treino de Empurrar',
        description: 'Foco em peito, ombros e tríceps',
        category: WorkoutTemplateCategory.push,
        difficulty: WorkoutTemplateDifficulty.intermediate,
        estimatedDuration: 60,
        exercises: [
          const WorkoutTemplateExercise(
            exerciseId: 'bench_press',
            sets: 4,
            reps: 8,
            restSeconds: 90,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'overhead_press',
            sets: 4,
            reps: 8,
            restSeconds: 90,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'incline_dumbbell_press',
            sets: 3,
            reps: 10,
            restSeconds: 75,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'dips',
            sets: 3,
            reps: 12,
            restSeconds: 75,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'tricep_extension',
            sets: 3,
            reps: 12,
            restSeconds: 60,
          ),
        ],
        createdAt: DateTime.now(),
      ),

      // Treino de Puxar - Intermediário
      WorkoutTemplate(
        id: 'pull_intermediate_1',
        name: 'Treino de Puxar',
        description: 'Foco em costas e bíceps',
        category: WorkoutTemplateCategory.pull,
        difficulty: WorkoutTemplateDifficulty.intermediate,
        estimatedDuration: 60,
        exercises: [
          const WorkoutTemplateExercise(
            exerciseId: 'pull_ups',
            sets: 4,
            reps: 8,
            restSeconds: 90,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'barbell_row',
            sets: 4,
            reps: 8,
            restSeconds: 90,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'lat_pulldown',
            sets: 3,
            reps: 10,
            restSeconds: 75,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'face_pulls',
            sets: 3,
            reps: 15,
            restSeconds: 60,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'barbell_curl',
            sets: 3,
            reps: 12,
            restSeconds: 60,
          ),
        ],
        createdAt: DateTime.now(),
      ),

      // Treino de Pernas - Avançado
      WorkoutTemplate(
        id: 'legs_advanced_1',
        name: 'Pernas Avançado',
        description: 'Treino intenso para pernas e glúteos',
        category: WorkoutTemplateCategory.legs,
        difficulty: WorkoutTemplateDifficulty.advanced,
        estimatedDuration: 75,
        exercises: [
          const WorkoutTemplateExercise(
            exerciseId: 'squat',
            sets: 5,
            reps: 6,
            restSeconds: 120,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'deadlift',
            sets: 4,
            reps: 6,
            restSeconds: 120,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'bulgarian_split_squat',
            sets: 3,
            reps: 10,
            restSeconds: 90,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'romanian_deadlift',
            sets: 3,
            reps: 10,
            restSeconds: 90,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'calf_raises',
            sets: 4,
            reps: 15,
            restSeconds: 60,
          ),
        ],
        createdAt: DateTime.now(),
      ),

      // Treino de Core
      WorkoutTemplate(
        id: 'core_beginner_1',
        name: 'Core Forte',
        description: 'Exercícios para fortalecer o core',
        category: WorkoutTemplateCategory.core,
        difficulty: WorkoutTemplateDifficulty.beginner,
        estimatedDuration: 30,
        exercises: [
          const WorkoutTemplateExercise(
            exerciseId: 'plank',
            sets: 3,
            reps: 30,
            restSeconds: 45,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'russian_twists',
            sets: 3,
            reps: 20,
            restSeconds: 45,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'mountain_climbers',
            sets: 3,
            reps: 20,
            restSeconds: 45,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'dead_bug',
            sets: 3,
            reps: 12,
            restSeconds: 45,
          ),
        ],
        createdAt: DateTime.now(),
      ),

      // Treino de Cardio
      WorkoutTemplate(
        id: 'cardio_beginner_1',
        name: 'Cardio Básico',
        description: 'Treino cardiovascular para iniciantes',
        category: WorkoutTemplateCategory.cardio,
        difficulty: WorkoutTemplateDifficulty.beginner,
        estimatedDuration: 30,
        exercises: [
          const WorkoutTemplateExercise(
            exerciseId: 'jumping_jacks',
            sets: 3,
            reps: 30,
            restSeconds: 30,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'high_knees',
            sets: 3,
            reps: 30,
            restSeconds: 30,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'burpees',
            sets: 3,
            reps: 10,
            restSeconds: 60,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'mountain_climbers',
            sets: 3,
            reps: 20,
            restSeconds: 30,
          ),
        ],
        createdAt: DateTime.now(),
      ),

      // Treino de Flexibilidade
      WorkoutTemplate(
        id: 'flexibility_beginner_1',
        name: 'Flexibilidade e Mobilidade',
        description: 'Exercícios para melhorar flexibilidade e mobilidade',
        category: WorkoutTemplateCategory.flexibility,
        difficulty: WorkoutTemplateDifficulty.beginner,
        estimatedDuration: 25,
        exercises: [
          const WorkoutTemplateExercise(
            exerciseId: 'cat_cow_stretch',
            sets: 2,
            reps: 10,
            restSeconds: 30,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'hip_flexor_stretch',
            sets: 2,
            reps: 30,
            restSeconds: 30,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'shoulder_rolls',
            sets: 2,
            reps: 10,
            restSeconds: 30,
          ),
          const WorkoutTemplateExercise(
            exerciseId: 'neck_stretch',
            sets: 2,
            reps: 30,
            restSeconds: 30,
          ),
        ],
        createdAt: DateTime.now(),
      ),
    ];
  }
}
