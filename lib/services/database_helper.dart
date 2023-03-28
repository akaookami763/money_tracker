import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static late Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = await getDatabasesPath();
    return await openDatabase(path,
        version: 1,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE transactions(tag INTEGER PRIMARY KEY AUTOINCREMENT, category TEXT, cost DOUBLE, date TIMESTAMP, extraNotes TEXT)
          CREATE TABLE cagetories(tag INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)
          ''');
  }
}