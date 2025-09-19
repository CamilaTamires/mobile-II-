import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  // Singleton
  AppDatabase._internal();
  static final AppDatabase instance = AppDatabase._internal();

  static const _dbName = 'user.db';  // Nome do banco de dados
  static const _dbVersion = 1;  // Versão do banco de dados

  Database? _db;

  // Acessa o banco de dados
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  // Abre o banco de dados e cria a tabela se necessário
  Future<Database> _open() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL,
          email TEXT NOT NULL,
          senha TEXT NOT NULL
        )
        ''');
      },
    );
  }
}
