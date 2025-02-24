import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollHomeCubit extends Cubit<ScrollController> {
  ScrollHomeCubit() : super(ScrollController());

  void scrollToTop() {
    if (!state.hasClients) return;
    state.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void offSet() {}

  @override
  Future<void> close() {
    state.dispose();
    return super.close();
  }
}
