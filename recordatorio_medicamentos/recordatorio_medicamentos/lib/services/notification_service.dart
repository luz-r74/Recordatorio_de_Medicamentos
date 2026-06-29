import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._internal();
  static final NotificationService instance = NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    if (kIsWeb) {
      return;
    }

    tz.initializeTimeZones();

    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    await _plugin.initialize(settings: initializationSettings);
  }

  Future<void> scheduleDailyNotification({
    required int id,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final scheduledDate = _nextInstanceOfTime(hour, minute);

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'medicamentos_channel',
          'Recordatorios de Medicamentos',
          channelDescription: 'Recordatorios diarios para tomar medicamentos',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'Recordatorio',
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleMedicamento(Map<String, Object> medicamento) async {
    if (kIsWeb) {
      return;
    }

    final id = medicamento['id'] as int?;
    final hour = medicamento['hour'] as int?;
    final minute = medicamento['minute'] as int?;
    final nombre = medicamento['nombre'] as String?;

    if (id != null && hour != null && minute != null && nombre != null) {
      await scheduleDailyNotification(
        id: id,
        title: 'Hora de tomar $nombre',
        body: 'Recuerda tomar $nombre en este momento.',
        hour: hour,
        minute: minute,
      );
    }
  }

  Future<void> cancel(int id) async {
    if (kIsWeb) {
      return;
    }
    await _plugin.cancel(id: id);
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now) || scheduled.isAtSameMomentAs(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
