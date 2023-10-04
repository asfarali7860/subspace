import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:subspace/model/blog_model.dart';

class PostsRepo {
  static Future<List<Blog>> fetchPosts() async {
    const String url = 'https://intent-kit-16.hasura.app/api/rest/blogs/';
    const String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    List<Blog> posts = [];
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      List result = jsonDecode(response.body)['blogs'];

      for (int i = 0; i < result.length; i++) {
        Blog post = Blog.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  // static Future<bool> addPost() async {
  //   var client = http.Client();

  //   try {
  //     var response = await client
  //         .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
  //       "title": "Akshit is a Flutter Teacher",
  //       "body": "Akshit makes good Bloc videos",
  //       "userId": "34"
  //     });

  //     if (response.statusCode >= 200 && response.statusCode < 300) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //     return false;
  //   }
  // }
}
