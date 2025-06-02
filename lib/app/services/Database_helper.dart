import 'package:get/get.dart';
import 'package:notes_app/app/models/notes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper extends GetxService {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), "my_notes.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE note(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          content TEXT NOT NULL,
          createdAt TEXT NOT NULL,
          updatedAt TEXT NOT NULL
        )
      ''');
    } catch (e) {
      Get.snackbar("Error Occurred", "The Error is  $e");
    }
  }

  Future<int> insertNote(Notes notes) async {
    final db = await database;
    return await db.insert("note", notes.toJson());
  }

  Future<List<Notes>> getNotes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("note");
    return List.generate(maps.length, (index) => Notes.fromJson(maps[index]));
  }

  Future<int> deleteNote(int id) async {
    final db = await database;
    return await db.delete("note", where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateNote(Notes notes) async {
    final db = await database;
    return await db.update(
      "note",
      notes.toJson(),
      where: 'id = ?',
      whereArgs: [notes.id],
    );
  }

  Future close() async {
    final db = await database;
    await db.close();
  }
}
