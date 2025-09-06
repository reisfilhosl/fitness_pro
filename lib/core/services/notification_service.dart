import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications = 
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Inicializa timezone
    tz.initializeTimeZones();
    
    // Configurações para Android
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // Configurações para iOS
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );
    
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    
    await _notifications.initialize(settings);
  }

  static Future<void> requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> scheduleWorkoutReminder({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'workout_reminders',
          'Lembretes de Treino',
          channelDescription: 'Notificações para lembrar de treinar',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleDailyReminder({
    required int hour,
    required int minute,
  }) async {
    final now = DateTime.now();
    var scheduledDate = DateTime(now.year, now.month, now.day, hour, minute);
    
    // Se o horário já passou hoje, agenda para amanhã
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await scheduleWorkoutReminder(
      id: 1,
      title: 'Hora do Treino! 💪',
      body: 'Que tal fazer um treino hoje? Seu corpo agradece!',
      scheduledTime: scheduledDate,
    );
  }

  static Future<void> scheduleStreakReminder({
    required int daysWithoutWorkout,
  }) async {
    String title;
    String body;
    
    switch (daysWithoutWorkout) {
      case 1:
        title = 'Não perca o ritmo! 🔥';
        body = 'Você perdeu apenas 1 dia. Volte hoje e mantenha sua streak!';
        break;
      case 2:
        title = 'Sua streak está em risco! ⚠️';
        body = 'Já são 2 dias sem treinar. Que tal voltar hoje?';
        break;
      case 3:
        title = 'Streak perdida! 😔';
        body = 'Sua streak de $daysWithoutWorkout dias foi quebrada. Vamos começar uma nova?';
        break;
      default:
        title = 'Vamos treinar? 💪';
        body = 'Já faz $daysWithoutWorkout dias sem treinar. Que tal voltar hoje?';
    }

    await scheduleWorkoutReminder(
      id: 2,
      title: title,
      body: body,
      scheduledTime: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  static Future<void> scheduleAchievementNotification({
    required String title,
    required String body,
  }) async {
    await _notifications.show(
      3,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'achievements',
          'Conquistas',
          channelDescription: 'Notificações de conquistas e badges',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  static Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  static Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}
