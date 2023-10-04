import 'package:flutter/material.dart';
import 'package:subspace/model/blog_class.dart';
import 'package:subspace/provider/sql_helper.dart';

class Fav extends ChangeNotifier {
  static List<FavBlog> list = [];
  List<FavBlog> get getFavItems {
    return list;
  }

  int? get count {
    return list.length;
  }

  void addFavItem(
    String id,
    String title,
    String imageUrl,
  ) async {
    final blog = FavBlog(
      id: id,
      title: title,
      imageUrl: imageUrl,
    );
    await SQLHelper.insertFavItem(blog).whenComplete(() => list.add(blog));
    notifyListeners();
  }

  void removeItem(FavBlog blog) async {
    await SQLHelper.deleteFavItem(blog.id)
        .whenComplete(() => list.remove(blog));
    notifyListeners();
  }

  void clearFavlist() async {
    await SQLHelper.removeAllItems().whenComplete(() => list.clear());
    notifyListeners();
  }

  loadFavItemsProvider() async {
    List<Map> data = await SQLHelper.loadItems();
    list = data.map((blog) {
      return FavBlog(
        id: blog['id'],
        title: blog['title'],
        imageUrl: blog['imageUrl'],
      );
    }).toList();
    notifyListeners();
  }

  void removeThis(String id) async {
    await SQLHelper.deleteFavItem(id)
        .whenComplete(() => list.removeWhere((element) => element.id == id));
    notifyListeners();
  }
}
