import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class VerticalMovieCard extends ConsumerStatefulWidget {
  VerticalMovieCard({
    Key? key,
    required this.imgUrl,
    required this.title,
    required this.rating,
    this.isBookmarked = false,
    this.onBookmarkCLicked,
    this.onTileClicked,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final double rating;
  bool isBookmarked;
  final Function()? onBookmarkCLicked;
  final Function()? onTileClicked;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VerticalMovieCardState();
}

class _VerticalMovieCardState extends ConsumerState<VerticalMovieCard>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(widget.imgUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
                widget.onBookmarkCLicked != null ? Positioned(
                  child: GestureDetector(
                    onTap: () => setState(() {
                      widget.isBookmarked = !widget.isBookmarked;
                      widget.onBookmarkCLicked?.call();
                    }),
                    child: Icon(
                      widget.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: widget.isBookmarked ? Colors.yellow : Colors.white,
                      size: 30.0,
                    ),
                  ),
                  top: 5,
                  right: 5,
                ): const Text(''),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Text(
                "${widget.rating}",
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
