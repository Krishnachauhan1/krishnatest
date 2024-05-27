import 'package:sqflite/sqflite.dart';
import '../model/export_models.dart';
import 'package:path/path.dart';
class UserProfileDatabaseHelper {
  static final UserProfileDatabaseHelper _instance = UserProfileDatabaseHelper._internal();
  factory UserProfileDatabaseHelper() => _instance;

  UserProfileDatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_profile.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE User (
        id INTEGER PRIMARY KEY,
        name TEXT,
        username TEXT,
        email TEXT,
        address TEXT,
        phone TEXT,
        website TEXT,
        company TEXT
      )
    ''');
  }

  Future<void> insertUser(UserModel user) async {
    Database db = await database;
    Map<String, dynamic> userMap = user.toDatabaseJson();
    await db.insert('User', userMap,conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<UserModel>> getUsers({int? id}) async {
  Database db = await database;
  List<Map<String, dynamic>> results;

  if (id != null) {
    // Query for a specific user
    results = await db.query('User', where: 'id = ?', whereArgs: [id]);
  } else {
    // Query for all users
    results = await db.query('User');
  }

  if (results.isNotEmpty) {
    return results.map((userMap) {
      return UserModel.fromDatabaseJson(userMap);
    }).toList();
  } else {
    return [];
  }
}
}
