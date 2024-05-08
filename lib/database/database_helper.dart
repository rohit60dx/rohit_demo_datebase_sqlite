import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;
  static final String tableName = 'users';

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initializeDatabase();
    return _database!;
  }

  static Future<Database> initializeDatabase() async {
    String directory = await getDatabasesPath();
    String path = join(directory, 'users.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            firstName TEXT,
            lastName TEXT,
            email TEXT,
            phoneNumber TEXT
          )
          ''');
    });
  }

  static Future<void> insertUser(Map<String, dynamic> userData) async {
    final Database db = await database;
    await db.insert(tableName, userData);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final Database db = await database;
    return await db.query(tableName);
  }
}
