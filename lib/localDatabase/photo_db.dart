import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/export_models.dart';

class PhotoDatabaseHelper {
  static final PhotoDatabaseHelper instance = PhotoDatabaseHelper._privateConstructor();
  static Database? _database;

  PhotoDatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'photos.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE photos(
        id INTEGER PRIMARY KEY,
        albumId INTEGER,
        title TEXT,
        url TEXT,
        thumbnailUrl TEXT
      )
    ''');
  }

  Future<int> insertPhoto(PhotoModel photo) async {
    Database db = await instance.database;
    return await db.insert('photos', photo.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<PhotoModel>> getPhotos({int? albumId}) async {
  Database db = await instance.database;
  List<Map<String, dynamic>> maps;

  if (albumId != null) {
    maps = await db.query(
      'photos',
      where: 'albumId = ?',
      whereArgs: [albumId],
    );
  } else {
    maps = await db.query('photos');
  }

  return List.generate(maps.length, (index) {
    return PhotoModel.fromJson(maps[index]);
  });
}


  Future<int> updatePhoto(PhotoModel photo) async {
    Database db = await instance.database;
    return await db.update('photos', photo.toJson(),
        where: 'id = ?', whereArgs: [photo.id]);
  }

  Future<int> deletePhoto(int id) async {
    Database db = await instance.database;
    return await db.delete('photos', where: 'id = ?', whereArgs: [id]);
  }
}
