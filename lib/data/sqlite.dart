import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/log_entry.dart';


class Sqlite {
  static Database? _db;

  static Future<void> initDatabase() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'healme_dairy.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE log_entries(
            id TEXT PRIMARY KEY,
            title TEXT,
            descriptions TEXT,
            date TEXT,
            logItem TEXT,
            severity REAL
          )
        ''');
      },
    );
  }
  
  static Future<Database> get database async{
    if(_db != null) return _db!;
    await initDatabase();
    return _db!;
  }

  static Future<void> insertEntry(LogEntry l) async {
    final db = await database;
    await db.insert('log_entries', l.toMap());
  }

  static Future<List<LogEntry>> getEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('log_entries');
    return maps.map((map) => LogEntry.fromMap(map)).toList();
  }

  static Future<void> updateEntry(LogEntry l, String id) async {
    final db = await database;
    await db.update('log_entries', l.toMap(), where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> deleteEntry(String id) async {
    final db = await database;
    await db.delete('log_entries', where: 'id = ?', whereArgs: [id]);
  }
}
