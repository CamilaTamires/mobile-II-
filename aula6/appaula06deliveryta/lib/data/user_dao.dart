import 'app_database.dart';
import 'package:appaula06deliveryta/model/user.dart';

class UserDao {
  final dbProvider = AppDatabase.instance;  // Singleton do AppDatabase

  // Função para inserir um usuário
  Future<int> insert(User user) async {
    final db = await dbProvider.database;
    return await db.insert('users', user.toMap());
  }

  // Função para recuperar todos os usuários
  Future<List<User>> getAllUsers() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }
}
