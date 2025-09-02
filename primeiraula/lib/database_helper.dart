import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'conversion.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('conversions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE conversions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        real REAL NOT NULL,
        dolar REAL NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  // CRUD usando a Model Conversion
  Future<int> insertConversion(Conversion conv) async {
    final db = await instance.database;
    return await db.insert('conversions', conv.toMap());
  }

  Future<List<Conversion>> getLastConversions() async {
    final db = await instance.database;
    final maps = await db.query('conversions', orderBy: 'id DESC', limit: 10);
    return maps.map((map) => Conversion.fromMap(map)).toList();
  }

  Future<int> updateConversion(Conversion conv) async {
    final db = await instance.database;
    return await db.update(
      'conversions',
      conv.toMap(),
      where: 'id = ?',
      whereArgs: [conv.id],
    );
  }

  Future<int> deleteConversion(int id) async {
    final db = await instance.database;
    return await db.delete('conversions', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllConversions() async {
    final db = await instance.database;
    return await db.delete('conversions');
  }
}
