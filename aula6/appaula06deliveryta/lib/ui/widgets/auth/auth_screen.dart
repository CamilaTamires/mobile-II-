import 'package:flutter/material.dart';
import 'package:appaula06deliveryta/ui/widgets/home/home_screen.dart'; // Importa a tela Home
import 'package:appaula06deliveryta/ui/widgets/auth/register_screen.dart'; // Importa a tela de cadastro (RegisterScreen)

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dados fixos para autenticação
  final String fixedEmail = "teste@exemplo.com";
  final String fixedPassword = "123456";

  void _login() {
    if (_emailController.text == fixedEmail && _passwordController.text == fixedPassword) {
      // Se o login for bem-sucedido, redireciona para a tela Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Se o login falhar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email ou senha inválidos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Entrar ou Cadastrar")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de entrada para o email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Campo de entrada para a senha
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            
            // Botão de login
            ElevatedButton(
              onPressed: _login, // Chama a função de login
              child: Text("Entrar"),
            ),
            SizedBox(height: 8),
            
            // Botão de redirecionamento para a tela de cadastro
            TextButton(
              onPressed: () {
                // Redireciona para a tela de cadastro
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text("Cadastrar-se"),
            ),
          ],
        ),
      ),
    );
  }
}
