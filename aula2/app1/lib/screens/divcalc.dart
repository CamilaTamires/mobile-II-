import 'package:flutter/material.dart';

class TelaDiv extends StatefulWidget {
  const TelaDiv({super.key});

  @override
  State<TelaDiv> createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaDiv> {
  // Cria variaveis para armazenar o que o usuario digita
  final TextEditingController n1 = TextEditingController();
  final TextEditingController n2 = TextEditingController();
  // variavel para Divisão
  double div =0;
  _div(){
    setState(() {
      div = (double.tryParse(n1.text)!)/(double.tryParse(n2.text)!);
    });
  }
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(),
     body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Numero 1',
              border: OutlineInputBorder(),
            ),
            controller: n1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Numero 2',
              border: OutlineInputBorder()
            ),
            controller: n2,
          ),
        ),
        Text('Resultado ${div}',style: TextStyle(fontSize: 18),),
        ElevatedButton(onPressed: _div, child: Text('Calcular'))
      ],
     ),
    );
  }
}