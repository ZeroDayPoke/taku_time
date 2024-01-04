import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/block.dart';

class DatabaseHelper {
  static const _databaseName = "taku_time.db";
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE blocks(
        id INTEGER PRIMARY KEY,
        type TEXT NOT NULL,
        duration INTEGER NOT NULL,
        startTime TEXT NOT NULL,
        isScheduled INTEGER NOT NULL,
        origin TEXT NOT NULL,
        priority INTEGER NOT NULL,
        note TEXT,
        isRecurring INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertBlock(Block block) async {
    Database db = await database;
    return await db.insert('blocks', block.toMap());
  }

  Future<List<Block>> getBlocks() async {
    Database db = await database;
    List<Map> maps = await db.query('blocks');
    return List.generate(maps.length, (i) {
      return Block.fromMap(maps[i] as Map<String, dynamic>);
    });
  }

  Future<int> updateBlock(Block block) async {
    Database db = await database;
    return await db.update('blocks', block.toMap(),
        where: 'id = ?', whereArgs: [block.id]);
  }

  Future<int> deleteBlock(int id) async {
    Database db = await database;
    return await db.delete('blocks', where: 'id = ?', whereArgs: [id]);
  }
}
