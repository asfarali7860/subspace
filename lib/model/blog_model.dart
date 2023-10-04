// To parse this JSON data, do
//
//     final blogPost = blogPostFromJson(jsonString);

import 'dart:convert';

BlogPost blogPostFromJson(String str) => BlogPost.fromJson(json.decode(str));

String blogPostToJson(BlogPost data) => json.encode(data.toJson());

class BlogPost {
    List<Blog> blogs;

    BlogPost({
        required this.blogs,
    });

    factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
        blogs: List<Blog>.from(json["blogs"].map((x) => Blog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "blogs": List<dynamic>.from(blogs.map((x) => x.toJson())),
    };
}

class Blog {
    String id;
    String imageUrl;
    String title;

    Blog({
        required this.id,
        required this.imageUrl,
        required this.title,
    });

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
    };
}
