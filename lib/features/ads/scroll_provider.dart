import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScrollProgressNotifier extends StateNotifier<double> {
  final ScrollController scrollController = ScrollController();

  ScrollProgressNotifier() : super(0.2) {
    scrollController.addListener(_updateProgress);
  }

  void _updateProgress() {
    if (!scrollController.hasClients) return;

    double progress = scrollController.offset /
        (scrollController.position.maxScrollExtent == 0
            ? 1
            : scrollController.position.maxScrollExtent);

    state = 0.2 + (progress * 0.8);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

final scrollProgressProvider =
    StateNotifierProvider<ScrollProgressNotifier, double>(
  (ref) => ScrollProgressNotifier(),
);

final scrollControllerProvider = Provider<ScrollController>(
  (ref) => ref.read(scrollProgressProvider.notifier).scrollController,
);
