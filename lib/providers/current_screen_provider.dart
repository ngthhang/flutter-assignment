import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentScreenProvider = StateNotifierProvider((ref) {
  return CurrentScreen();
});

class CurrentScreen extends StateNotifier<int> {
  CurrentScreen() : super(0);

  void changeScreen(index) => state = index;
  int getCurrent() => state;
}
