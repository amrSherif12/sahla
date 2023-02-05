import 'package:bloc/bloc.dart';

import 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState_> {
  DrawerCubit() : super(DrawerHome());

  int pageIndex = 0;

  goToHome() {
    pageIndex = 0;

    emit(DrawerHome());
  }

  goToProfile() {
    pageIndex = 1;

    emit(DrawerProfile());
  }

  goToAbout() {
    pageIndex = 2;

    emit(DrawerAbout());
  }
}
