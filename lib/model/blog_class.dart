class FavBlog {
  String id;
  String title;
  String imageUrl;
  FavBlog({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'imageUrl': imageUrl};
  }

  @override
  String toString() {
    return 'FavBlog{id: $id ,title:$title,imageUrl:$imageUrl}';
  }
}
