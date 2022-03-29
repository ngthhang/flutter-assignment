import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/providers/current_screen_provider.dart';

class BottomNav extends ConsumerStatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends ConsumerState<BottomNav> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraint) => SizedBox(
        height: constraint.maxHeight / 8,
        child: Consumer(
          builder: (context, ref, _) {
            final currentScreen = ref.watch(currentScreenProvider.notifier).getCurrent();
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              currentIndex: currentScreen,
              selectedItemColor: Colors.yellow,
              unselectedItemColor: Colors.white,
              onTap: (index) => ref.read(currentScreenProvider.notifier).changeScreen(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bookmark),
                  label: "",
                )
              ],
            );
          },
        )
      )
    );
  }
}
