import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/export_models.dart';

class PostDatabaseHelper {
  static final PostDatabaseHelper instance = PostDatabaseHelper._privateConstructor();
  static Database? _database;

  PostDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'posts.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts(
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        title TEXT,
        body TEXT
      )
    ''');
  }

  Future<int> insertPost(PostModel post) async {
    Database db = await instance.database;
    return await db.insert('posts', post.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PostModel>> getPosts({int? userId}) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps;

  if (userId != null) {
    maps = await db.query(
      'posts',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  } else {
    maps = await db.query('posts');
  }

  return List.generate(maps.length, (index) {
    return PostModel.fromJson(maps[index]);
  });
}


  Future<int> updatePost(PostModel post) async {
    Database db = await instance.database;
    return await db.update('posts', post.toJson(),
        where: 'id = ?', whereArgs: [post.id]);
  }

  Future<int> deletePost(int id) async {
    Database db = await instance.database;
    return await db.delete('posts', where: 'id = ?', whereArgs: [id]);
  }
}
