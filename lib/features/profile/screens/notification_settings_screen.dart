import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/notification_service.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
  bool _dailyRemindersEnabled = false;
  bool _streakRemindersEnabled = false;
  bool _achievementNotificationsEnabled = false;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 18, minute: 0);

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  void _loadSettings() {
    // TODO: Carregar configurações salvas
    setState(() {
      _dailyRemindersEnabled = false;
      _streakRemindersEnabled = true;
      _achievementNotificationsEnabled = true;
    });
  }

  Future<void> _saveSettings() async {
    // TODO: Salvar configurações
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configurações salvas!'),
          backgroundColor: AppConstants.primaryColor,
        ),
      );
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
    );
    
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
      await _saveSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        children: [
          // Lembretes Diários
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule, color: AppConstants.primaryColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lembretes Diários',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Receba lembretes para treinar todos os dias',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: _dailyRemindersEnabled,
                        onChanged: (value) async {
                          setState(() {
                            _dailyRemindersEnabled = value;
                          });
                          
                          if (value) {
                            await NotificationService.scheduleDailyReminder(
                              hour: _reminderTime.hour,
                              minute: _reminderTime.minute,
                            );
                          } else {
                            await NotificationService.cancelNotification(1);
                          }
                          
                          await _saveSettings();
                        },
                      ),
                    ],
                  ),
                  if (_dailyRemindersEnabled) ...[
                    const SizedBox(height: 16),
                    InkWell(
                      onTap: _selectTime,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time),
                            const SizedBox(width: 12),
                            Text(
                              'Horário: ${_reminderTime.format(context)}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const Spacer(),
                            const Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lembretes de Streak
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.local_fire_department, color: AppConstants.primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lembretes de Streak',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Receba avisos quando sua streak estiver em risco',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _streakRemindersEnabled,
                    onChanged: (value) async {
                      setState(() {
                        _streakRemindersEnabled = value;
                      });
                      await _saveSettings();
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Notificações de Conquistas
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.emoji_events, color: AppConstants.primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conquistas',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Receba notificações quando ganhar badges',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _achievementNotificationsEnabled,
                    onChanged: (value) async {
                      setState(() {
                        _achievementNotificationsEnabled = value;
                      });
                      await _saveSettings();
                    },
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Teste de Notificação
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Teste de Notificação',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Envie uma notificação de teste para verificar se está funcionando',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await NotificationService.scheduleAchievementNotification(
                          title: 'Teste de Notificação 🧪',
                          body: 'Se você está vendo isso, as notificações estão funcionando!',
                        );
                        
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Notificação de teste enviada!'),
                              backgroundColor: AppConstants.primaryColor,
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.send),
                      label: const Text('Enviar Teste'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
