import 'package:exer1/data/app_database.dart';
import 'package:exer1/models/aluno.dart';
import 'package:sqflite/sqflite.dart';

class StudentGradeDao {
  static const table = 'student_grades';

  Future<int> insert(StudentGrade studentGrade) async {
    final db = await AppDatabase.instance.database;
    return db.insert(
      table,
      studentGrade.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<StudentGrade>> getAll() async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(table, orderBy: 'id DESC');
    return maps.map((m) => StudentGrade.fromMap(m)).toList();
  }

  Future<int> update(StudentGrade studentGrade) async {
    final db = await AppDatabase.instance.database;
    return db.update(
      table,
      studentGrade.toMap(),
      where: 'id = ?',
      whereArgs: [studentGrade.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await AppDatabase.instance.database;
    return db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<StudentGrade>> searchByStudentName(String query) async {
    final db = await AppDatabase.instance.database;
    final maps = await db.query(
      table,
      where: 'nomeAluno LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'nomeAluno ASC',
    );
    return maps.map((m) => StudentGrade.fromMap(m)).toList();
  }
}
