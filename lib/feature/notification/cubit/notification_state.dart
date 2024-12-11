// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:dersgo_app/product/global/model/user_model.dart';

class NotificationState extends Equatable {
  final NotificationStates? notificationState;
  final List<Map<String, dynamic>> notification;
  final Works? work;
  const NotificationState({
    this.notificationState,
    required this.notification,
    this.work,
  });
  
  factory NotificationState.initial(){
    return const NotificationState(
      notificationState: NotificationStates.initial,
      notification: [],
      work: null,
    );
  }

  @override
  List<Object?> get props => [notificationState, notification, work];

  NotificationState copyWith({
    NotificationStates? notificationState,
    List<Map<String, dynamic>>? notification,
    Works? work
  }) {
    return NotificationState(
      notificationState: notificationState ?? this.notificationState,
      notification: notification ?? this.notification,
      work: work ?? this.work
    );
  }
}

enum NotificationStates{
  initial,
  loading,
  completed
}