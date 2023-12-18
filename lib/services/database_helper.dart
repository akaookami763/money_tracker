import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), "money.db");
    print(path); // TODO: Remove once everything is tested and done
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        tag INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
''');
    await db.execute('''
      CREATE TABLE transactions (
        tag INTEGER PRIMARY KEY AUTOINCREMENT,
        category INTEGER,
        cost DOUBLE,
        date TIMESTAMP,
        extraNotes TEXT,
        FOREIGN KEY (category)
          REFERENCES categories (tag)
      )
    ''');
//     await db.execute('''
//       CREATE TABLE budgets (
//         tag INTEGER PRIMARY KEY AUTOINCREMENT,
//         name TEXT,
//         cost DOUBLE
//       )
// ''');
//     await db.execute('''
//       CREATE TABLE budget_categories (
//         budget_tag INTEGER,
//         financial_category_tag INTEGER,
//         CONSTRAINT budget_category PRIMARY KEY 
//       )
// ''');
  }
}
