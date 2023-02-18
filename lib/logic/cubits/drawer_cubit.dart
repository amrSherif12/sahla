import 'package:bloc/bloc.dart';

import 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState_> {
  DrawerCubit() : super(DrawerHome());

  int pageIndex = 0;

  goToHome() {
    pageIndex = 0;

    emit(DrawerHome());
  }

  goToOffers() {
    pageIndex = 1;

    emit(DrawerOffers());
  }

  goToProfile() {
    pageIndex = 2;

    emit(DrawerProfile());
  }

  goToAbout() {
    pageIndex = 3;

    emit(DrawerAbout());
  }
}
