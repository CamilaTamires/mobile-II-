import 'package:flutter/material.dart';
import 'package:appaula06deliveryta/data/user_dao.dart';
import 'package:appaula06deliveryta/model/user.dart';
import 'package:appaula06deliveryta/ui/widgets/auth/auth_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final UserDao _userDao = UserDao();

  // Função para cadastrar um novo usuário
  void _register() async {
    final nome = _nomeController.text;
    final email = _emailController.text;
    final senha = _senhaController.text;

    // Verifica se algum campo está vazio
    if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos!')),
      );
      return;
    }

    // Cria um novo usuário
    final user = User(nome: nome, email: email, senha: senha);

    // Tenta inserir o novo usuário no banco
    final userId = await _userDao.insert(user);

    if (userId > 0) {
      // Cadastro bem-sucedido, redireciona para a tela Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen(),
      ));
    } else {
      // Erro no cadastro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar o usuário.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Novo Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _register, // Chama a função de cadastro
              child: Text("Cadastrar"),
            ),
            SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Volta para a tela de login
              },
              child: Text("Já tem uma conta? Faça login"),
            ),
          ],
        ),
      ),
    );
  }
}
