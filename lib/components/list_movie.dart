import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movieapp/components/horizontal_movie_card.dart';
import 'package:movieapp/providers/movies_provider.dart';

class ListPopularMovie extends ConsumerStatefulWidget {
  const ListPopularMovie({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListPopularMovieState();
}

class _ListPopularMovieState extends ConsumerState<ListPopularMovie> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(moviesNotifierProvider.notifier).getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          return ref.watch(moviesNotifierProvider).when(
              data: (data) => LayoutBuilder(builder: (context, constraint) {
                    return  Expanded(
                      flex: 3,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        itemCount: 10,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 16,
                        ),
                        itemBuilder: (context, index) {
                          final movie = data.items[index];
                          return Text(movie.title);
                        },
                      ),
                    );
                  }),
              error: (err, st) => Text(
                    err.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ));
        },
      ),
    );
  }

  @override
  // ignore: todo
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


 // Widget build(BuildContext context) {
  //   return SizedBox(
  //       height: 200,
  //       width: double.infinity,
  //       child: ListView.separated(
  //           scrollDirection: Axis.horizontal,
  //           separatorBuilder: (BuildContext context, int index) {
  //             return const SizedBox(height: 3);
  //           },
  //           padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
  //           itemCount: 10,
  //           itemBuilder: (context, item) =>
  //               Container(width: 100, color: Colors.yellow)));
  // }