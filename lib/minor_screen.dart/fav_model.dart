// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:subspace/minor_screen.dart/blog_detail.dart';
import 'package:subspace/model/blog_class.dart';
import 'package:subspace/provider/fav_provider.dart';
import 'package:provider/provider.dart';
// import 'package:subspace/provider/sql_helper.dart';

class FavModel extends StatelessWidget {
  const FavModel({Key? key, required this.blog, required this.internet})
      : super(key: key);
  final FavBlog blog;
  final bool internet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlogDetailPage(
                      id: blog.id,
                      title: blog.title,
                      imageUrl: blog.imageUrl,
                      internet: internet)));
        },
        child: Card(
          child: SizedBox(
            height: 110,
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: internet == true
                        ? Image.network(
                            blog.imageUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.asset('image/img.png'),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          blog.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade700),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  context.read<Fav>().removeThis(blog.id);
                                },
                                icon: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.black,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
