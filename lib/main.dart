import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/screens/bookmark.dart';
import 'package:movieapp/screens/home.dart';
import 'package:movieapp/screens/search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ProviderScope(child: MyHomePage()),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> 
  with TickerProviderStateMixin {
  final _currentScreen = StateProvider((ref) => 0);
  static const _screens =  [HomeScreen(), SearchScreen(), BookmarkScreen()];
  final PageController _screenController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {

    ref.listen(_currentScreen, (int? previous, int next) {
      _screenController.jumpToPage(next);
    });

    return Scaffold(
    body: Stack(
      children: [
        PageView(
          controller: _screenController,
          children: _screens,
          physics: const NeverScrollableScrollPhysics(),
        )
      ]
    ),
    bottomNavigationBar: LayoutBuilder(
      builder: (_, constraint) => SizedBox(
        child: Consumer(
          builder: (context, ref, _) {
            final currentScreen = ref.watch(_currentScreen.state).state;
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.black,
              currentIndex: currentScreen,
              selectedItemColor: Colors.yellow,
              unselectedItemColor: Colors.white,
              onTap: (index) => ref.read(_currentScreen.state).state = index,
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
    ),
    );
  }
}
