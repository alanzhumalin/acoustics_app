import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollLinearCubit extends Cubit<double> {
  final ScrollController scrollController = ScrollController();
  ScrollController get scrollLinearController => scrollController;
  ScrollLinearCubit() : super(0.2) {
    scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (!scrollController.hasClients) return;

    double progress = scrollController.offset /
        (scrollController.position.maxScrollExtent == 0
            ? 1
            : scrollController.position.maxScrollExtent);

    emit(0.2 + (progress * 0.8));
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
