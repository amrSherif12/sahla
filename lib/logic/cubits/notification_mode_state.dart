part of 'notification_mode_cubit.dart';

@immutable
abstract class NotificationModeState {}

class NotificationModeInitial extends NotificationModeState {}

class NotificationModeService extends NotificationModeState {}

class NotificationModeOffer extends NotificationModeState {}
