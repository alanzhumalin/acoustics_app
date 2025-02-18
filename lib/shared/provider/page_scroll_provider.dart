import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageScrollController =
    StateProvider<ScrollController>((ref) => ScrollController());

final pageScrollControllerProvider = Provider((ref) {
  return ref.watch(pageScrollController);
});
