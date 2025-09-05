import 'package:exer1/data/student_grade_dao.dart';
import 'package:exer1/models/aluno.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _dao = StudentGradeDao();
  final _nomeCtrl = TextEditingController();
  final _disciplinaCtrl = TextEditingController();
  final _notaCtrl = TextEditingController(); // Novo campo
  final _searchCtrl = TextEditingController();

  StudentGrade? _editing;
  Future<List<StudentGrade>>? _futureGrades;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    setState(() {
      final q = _searchCtrl.text.trim();
      _futureGrades = q.isEmpty ? _dao.getAll() : _dao.searchByStudentName(q);
    });
  }

  void _clearForm() {
    _nomeCtrl.clear();
    _disciplinaCtrl.clear();
    _notaCtrl.clear();
    _editing = null;
  }

  void _edit(StudentGrade grade) {
    setState(() {
      _editing = grade;
      _nomeCtrl.text = grade.nomeAluno;
      _disciplinaCtrl.text = grade.nomeDisciplina;
      _notaCtrl.text = grade.nota.toString();
    });
  }

  Future<void> _save() async {
    final nome = _nomeCtrl.text.trim();
    final disciplina = _disciplinaCtrl.text.trim();
    final notaStr = _notaCtrl.text.trim();

    if (nome.isEmpty || disciplina.isEmpty || notaStr.isEmpty) {
      _snack('Preencha todos os campos');
      return;
    }

    final nota = double.tryParse(notaStr);
    if (nota == null) {
      _snack('Nota precisa ser um número');
      return;
    }

    if (_editing == null) {
      await _dao.insert(StudentGrade(
        nomeAluno: nome,
        nomeDisciplina: disciplina,
        nota: nota,
      ));
      _snack('Nota cadastrada');
    } else {
      await _dao.update(_editing!.copyWith(
        nomeAluno: nome,
        nomeDisciplina: disciplina,
        nota: nota,
      ));
      _snack('Nota atualizada');
    }

    _clearForm();
    _reload();
  }

  Future<void> _delete(int id) async {
    await _dao.delete(id);
    _snack('Registro removido');
    _reload();
  }

  void _cancelEdit() {
    _clearForm();
    _snack('Edição cancelada');
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _disciplinaCtrl.dispose();
    _notaCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = _editing != null;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas - SQFLITE'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                labelText: 'Buscar aluno',
                hintText: 'Ex: João',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  tooltip: 'Limpar busca',
                  onPressed: () {
                    _searchCtrl.clear();
                    _reload();
                  },
                  icon: Icon(Icons.clear),
                ),
              ),
              onChanged: (_) => _reload(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _nomeCtrl,
              decoration: InputDecoration(
                labelText: 'Nome do aluno',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _disciplinaCtrl,
              decoration: InputDecoration(
                labelText: 'Disciplina',
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _notaCtrl,
              decoration: InputDecoration(
                labelText: 'Nota',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _save,
                  icon: Icon(isEditing ? Icons.save : Icons.add),
                  label:
                      Text(isEditing ? 'Salvar alterações' : 'Adicionar nota'),
                ),
              ),
              if (isEditing) ...[
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _cancelEdit,
                    icon: Icon(Icons.close),
                    label: Text('Cancelar'),
                  ),
                )
              ]
            ],
          ),
          Divider(height: 8),
          Expanded(
            child: FutureBuilder<List<StudentGrade>>(
              future: _futureGrades,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                final grades = snapshot.data ?? [];
                if (grades.isEmpty) {
                  return Center(child: Text('Nenhum aluno encontrado'));
                }
                return ListView.builder(
                  itemCount: grades.length,
                  itemBuilder: (context, index) {
                    final grade = grades[index];
                    return ListTile(
                      title: Text(grade.nomeAluno),
                      subtitle: Text(
                          '${grade.nomeDisciplina} - Nota: ${grade.nota.toStringAsFixed(1)}'),
                      leading: CircleAvatar(
                        child: Text((grade.id ?? 0).toString()),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            tooltip: 'Editar',
                            icon: Icon(Icons.edit),
                            onPressed: () => _edit(grade),
                          ),
                          IconButton(
                            tooltip: 'Excluir',
                            onPressed: () => _delete(grade.id!),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
