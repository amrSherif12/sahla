import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_mode_state.dart';

class NotificationModeCubit extends Cubit<NotificationModeState> {
  NotificationModeCubit() : super(NotificationModeService());

  void service() {
    emit(NotificationModeService());
  }

  void offer() {
    emit(NotificationModeOffer());
  }
}
