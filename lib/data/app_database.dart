import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



class AppDatabase {
  // Singleton
  AppDatabase._internal();
  static final AppDatabase instance = AppDatabase._internal();

  static const _dbName = 'aluno.db';
  static const _dbVersion=1;

  Database? _db; 

  Future<Database> get database async{
    if(_db!=null) return _db!;
    _db = await _open();
    return _db!;
  }

  // Função open

  Future<Database> _open()async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath,_dbName);
    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate:(db,version)async{
      await db.execute(
        '''
        CREATE TABLE student_grades (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nomeAluno TEXT NOT NULL,
          nomeDisciplina TEXT NOT NULL,
          nota REAL NOT NULL
        )
        '''
      );

      },
      // Se precisar de migrações futuramente
      // onUpgrade (db, oldV,newV)async
      );

  }
}