import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/export_models.dart';

class AlbumDatabaseHelper {
  static final AlbumDatabaseHelper instance = AlbumDatabaseHelper._privateConstructor();
  static Database? _database;

  AlbumDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'albums.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE albums(
        id INTEGER PRIMARY KEY,
        userId INTEGER,
        title TEXT
      )
    ''');
  }

  Future<int> insertAlbum(AlbumModel album) async {
    Database db = await instance.database;
    return await db.insert('albums', album.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

 Future<List<AlbumModel>> getAlbums({int? userId}) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps;

  if (userId != null) {
    maps = await db.query(
      'albums',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  } else {
    maps = await db.query('albums');
  }

  return List.generate(maps.length, (index) {
    return AlbumModel.fromJson(maps[index]);
  });
}


  Future<int> updateAlbum(AlbumModel album) async {
    Database db = await instance.database;
    return await db.update('albums', album.toJson(),
        where: 'id = ?', whereArgs: [album.id]);
  }

  Future<int> deleteAlbum(int id) async {
    Database db = await instance.database;
    return await db.delete('albums', where: 'id = ?', whereArgs: [id]);
  }
}