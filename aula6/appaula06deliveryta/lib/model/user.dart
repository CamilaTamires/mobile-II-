class User {
  final int? id;
  final String nome;
  final String email;
  final String senha;

  User({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
  });

  // Converte um objeto User para um mapa (para salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
    };
  }

  // Converte um mapa para um objeto User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
    );
  }
}
