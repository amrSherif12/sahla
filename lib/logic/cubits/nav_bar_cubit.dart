import 'package:bloc/bloc.dart';
import 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarMedFood());

  int pageIndex = 0;

  goToMedFun() {
    pageIndex = 0;

    emit(NavBarMedFood());
  }

  goToHomeFun() {
    pageIndex = 1;

    emit(NavBarHomeFun());
  }

  goToRESport() {
    pageIndex = 2;

    emit(NavBarRESport());
  }

  goToEducOthers() {
    pageIndex = 3;

    emit(NavBarEducOthers());
  }
}
