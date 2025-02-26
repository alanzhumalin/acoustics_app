import 'package:flutter_bloc/flutter_bloc.dart';

class IndexBottomNavBar extends Cubit<int> {
  IndexBottomNavBar() : super(0);

  void indexChange(int index) {
    emit(index);
  }
}
