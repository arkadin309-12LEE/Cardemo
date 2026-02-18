import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cardemo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT,
        front_image TEXT,
        deck_id INTEGER,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (deck_id) REFERENCES decks (id)
      )
    ''');

    await db.execute('''
      CREATE TABLE decks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        cover_image TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertCard(Map<String, dynamic> card) async {
    final db = await database;
    return await db.insert('cards', card);
  }

  Future<List<Map<String, dynamic>>> getAllCards() async {
    final db = await database;
    return await db.query('cards', orderBy: 'created_at DESC');
  }

  Future<Map<String, dynamic>?> getCard(int id) async {
    final db = await database;
    final result = await db.query(
      'cards',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> updateCard(int id, Map<String, dynamic> card) async {
    final db = await database;
    return await db.update(
      'cards',
      card,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCard(int id) async {
    final db = await database;
    return await db.delete(
      'cards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> searchCards(String keyword) async {
    final db = await database;
    return await db.query(
      'cards',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
      orderBy: 'created_at DESC',
    );
  }

  Future<int> insertDeck(Map<String, dynamic> deck) async {
    final db = await database;
    return await db.insert('decks', deck);
  }

  Future<List<Map<String, dynamic>>> getAllDecks() async {
    final db = await database;
    return await db.query('decks', orderBy: 'created_at DESC');
  }

  Future<int> updateDeck(int id, Map<String, dynamic> deck) async {
    final db = await database;
    return await db.update(
      'decks',
      deck,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteDeck(int id) async {
    final db = await database;
    return await db.delete(
      'decks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
