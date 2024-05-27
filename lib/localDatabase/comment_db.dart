import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/comment_model.dart';

class CommentDatabaseHelper {
  static final CommentDatabaseHelper instance = CommentDatabaseHelper._privateConstructor();
  static Database? _database;

  CommentDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'comments.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE comments(
        id INTEGER PRIMARY KEY,
        postId INTEGER,
        name TEXT,
        email TEXT,
        body TEXT
      )
    ''');
  }

  Future<int> insertComment(CommentModel comment) async {
    Database db = await instance.database;
    return await db.insert('comments', comment.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

 Future<List<CommentModel>> getComments({int? postId}) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps;

  if (postId != null) {
    maps = await db.query(
      'comments',
      where: 'postId = ?',
      whereArgs: [postId],
    );
  } else {
    maps = await db.query('comments');
  }

  return List.generate(maps.length, (index) {
    return CommentModel.fromJson(maps[index]);
  });
}


  Future<int> updateComment(CommentModel comment) async {
    Database db = await instance.database;
    return await db.update('comments', comment.toJson(),
        where: 'id = ?', whereArgs: [comment.id]);
  }

  Future<int> deleteComment(int id) async {
    Database db = await instance.database;
    return await db.delete('comments', where: 'id = ?', whereArgs: [id]);
  }
}
