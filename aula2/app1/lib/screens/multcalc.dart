import 'package:flutter/material.dart';

class TelaMulti extends StatefulWidget {
  const TelaMulti({super.key});

  @override
  State<TelaMulti> createState() => _TelaCalculadoraState();
}

class _TelaCalculadoraState extends State<TelaMulti> {
  // Cria variaveis para armazenar o que o usuario digita
  final TextEditingController n1 = TextEditingController();
  final TextEditingController n2 = TextEditingController();
  // variavel para multiplicaçãa
  double multi =0;
  __mult(){
    setState(() {
      multi = (double.tryParse(n1.text)!)*(double.tryParse(n2.text)!);
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
        Text('Resultado ${multi}',style: TextStyle(fontSize: 18),),
        ElevatedButton(onPressed: __mult, child: Text('Calcular'))
      ],
     ),
    );
  }
}