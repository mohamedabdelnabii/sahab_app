import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/app_constants.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());
  int currentIndex = AppConstants.indexHome;

  void changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavBarChanged());
  }
}
