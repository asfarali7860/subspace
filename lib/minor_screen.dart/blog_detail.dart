// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:subspace/provider/fav_provider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class BlogDetailPage extends StatefulWidget {
  final String id;
  final String title;
  final String imageUrl;
  final bool? internet;
  const BlogDetailPage({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.id,
    this.internet,
  });

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blog Detailed View'),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: widget.internet == true
                        ? Image.network(widget.imageUrl)
                        : Image.asset('image/img.png')),
                const GreyDivider(),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Add to Favourite',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey.shade600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                                minWidth: 22, maxWidth: 22),
                            onPressed: () {
                              var existingItemWishlist = context
                                  .read<Fav>()
                                  .getFavItems
                                  .firstWhereOrNull(
                                      (blog) => blog.id == widget.id);
                              existingItemWishlist != null
                                  ? context.read<Fav>().removeThis(widget.id)
                                  : context.read<Fav>().addFavItem(
                                      widget.id, widget.title, widget.imageUrl);
                            },
                            icon: context
                                        .watch<Fav>()
                                        .getFavItems
                                        .firstWhereOrNull(
                                            (blog) => blog.id == widget.id) !=
                                    null
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 30,
                                  )
                                : const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                    size: 30,
                                  )),
                      ),
                    ],
                  ),
                ),
                const GreyDivider(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ));
  }
}

class GreyDivider extends StatelessWidget {
  const GreyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Divider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }
}
