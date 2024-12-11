import 'package:dersgo_app/feature/notification/cubit/notification_state.dart';
import 'package:dersgo_app/feature/notification/service/notification_service.dart';
import 'package:dersgo_app/product/global/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService _notificationService = NotificationService.instance;
  bool _isNotificationProcessing = false;

  NotificationCubit(int userId, {List<Works>? initialWorks})
      : super(NotificationState.initial()) {
    initializeListener(userId);

    if (initialWorks != null && initialWorks.isNotEmpty) {
      emit(state.copyWith(
        notification: initialWorks.map((work) {
          return {
            'body': work.description ?? 'No Description',
            'workId': work.assignmentId,
            'userId': work.userId,
            'isCompleted': work.isCompleted ?? false,
          };
        }).toList(),
        notificationState: NotificationStates.completed,
      ));
    }
  }


  Future<void> initializeListener(int userId) async {
    OneSignal.Notifications.addForegroundWillDisplayListener((event) async {
      if (_isNotificationProcessing) return;

      _isNotificationProcessing = true;

      debugPrint("DİNLEYİCİ: ${event.jsonRepresentation()}");

      final String body = event.notification.body ?? 'Mesaj Yok';
      addNotification(body, userId);

      await Future.delayed(const Duration(seconds: 2));
      _isNotificationProcessing = false;
    });
  }

void addNotification(String body, int userId) async {
  if (state.notification.isEmpty || state.notification.last['body'] != body) {
    emit(state.copyWith(
      
      notificationState: NotificationStates.loading, 
    ));
    final Works? createdWork = await createWork(userId, body);
    if (createdWork != null) {
     
      final newNotification = {
        'body': createdWork.description,
        'workId': createdWork.assignmentId,
        'userId': createdWork.userId,
        'isCompleted': createdWork.isCompleted,
      };
      final updatedNotifications = List<Map<String, dynamic>>.from(state.notification)
        ..add(newNotification);
      emit(state.copyWith(
        notification: updatedNotifications,
        notificationState: NotificationStates.completed,
      ));
    } else {
      debugPrint("Failed to add notification with full work details.");
    }
  }
}

Future<Works?> createWork(int userId, String body) async {
  try {
    Works work = Works(
      description: body,
      userId: userId,
      isCompleted: true,
    );

    final Works? response = await _notificationService.createWork(userId, work);

    if (response != null) {
      debugPrint("Work successfully created for notification: $body");
      return response; // API'den dönen Works nesnesi
    } else {
      debugPrint("Failed to create work for notification: $body");
    }
  } catch (e) {
    debugPrint("Error in createWork: $e");
  }
  return null; 
}

Future<void> deleteWork(int userId, int workId, int index) async {
  try {
  
    final response = await _notificationService.deleteWork(userId, workId);

    if (response) {
      final updatedNotifications = List<Map<String, dynamic>>.from(state.notification);
      updatedNotifications.removeAt(index);
      emit(state.copyWith(
        notification: updatedNotifications,
        notificationState: NotificationStates.completed,
      ));
      debugPrint("Work successfully deleted: ID $workId");
    } else {
      debugPrint("Failed to delete work: ID $workId");
    }
  } catch (e) {
    debugPrint("Error in deleteWork: $e");
  }
}

}
