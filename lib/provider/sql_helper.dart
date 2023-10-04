// ignore_for_file: avoid_print

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:subspace/model/blog_class.dart';

class SQLHelper {
  static Database? database;
  static get getDatabase async {
    if (database != null) return database;
    database = await initDatabase();
    return database;
  }

  static Future<Database> initDatabase() async {
    String path = p.join(await getDatabasesPath(), 'fav_database.db');
    return await openDatabase(path, version: 5, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
        CREATE TABLE fav_items (
        id TEXT PRIMARY KEY,
        title TEXT,
        imageUrl TEXT
      )
      ''');
    batch.commit();
    print('on create was called');
  }

  static Future insertFavItem(FavBlog blog) async {
    Database db = await getDatabase;
    await db.insert('fav_items', blog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(await db.query('fav_items'));
  }

  static Future removeAllItems() async {
    Database db = await getDatabase;
    await db.execute('DELETE FROM fav_items');
  }

  static Future<List<Map>> loadItems() async {
    Database db = await getDatabase;
    return await db.query('fav_items');
  }

  static Future deleteFavItem(String id) async {
    Database db = await getDatabase;
    await db.delete('fav_items', where: 'id = ?', whereArgs: [id]);
  }
}
