class StudentGrade {
  final int? id; // Adicionado
  final String nomeAluno;
  final String nomeDisciplina;
  final double nota;

  StudentGrade({
    this.id, // Adicionado
    required this.nomeAluno,
    required this.nomeDisciplina,
    required this.nota,
  });

  StudentGrade copyWith({
    int? id,
    String? nomeAluno,
    String? nomeDisciplina,
    double? nota,
  }) {
    return StudentGrade(
      id: id ?? this.id,
      nomeAluno: nomeAluno ?? this.nomeAluno,
      nomeDisciplina: nomeDisciplina ?? this.nomeDisciplina,
      nota: nota ?? this.nota,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Adicionado
      'nomeAluno': nomeAluno,
      'nomeDisciplina': nomeDisciplina,
      'nota': nota,
    };
  }

  factory StudentGrade.fromMap(Map<String, dynamic> map) {
    return StudentGrade(
      id: map['id'] as int?, // Adicionado
      nomeAluno: map['nomeAluno'] as String,
      nomeDisciplina: map['nomeDisciplina'] as String,
      nota: (map['nota'] as num).toDouble(),
    );
  }
}
