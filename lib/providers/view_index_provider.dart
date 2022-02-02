import 'package:flutter_riverpod/flutter_riverpod.dart';

final viewIndexProvider =
    StateNotifierProvider.autoDispose<ViewIndexProvider, int>(
        (ref) => ViewIndexProvider());

class ViewIndexProvider extends StateNotifier<int> {
  ViewIndexProvider() : super(_viewIndex);

  static const int _viewIndex = 0;

  void changeIndex(int newIndex) {
    state = newIndex;
  }
}
