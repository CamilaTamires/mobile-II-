import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  final String qrCode;

  const FormPage({Key? key, required this.qrCode}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController localController = TextEditingController();

  @override
  void dispose() {
    nomeController.dispose();
    localController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String nomeAtivo = nomeController.text;
      String localAtivo = localController.text;
      String qrCode = widget.qrCode;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Chamado aberto para ativo "$nomeAtivo" em "$localAtivo"\nQR Code: $qrCode',
          ),
        ),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abrir Chamado'),
        backgroundColor: const Color(0xFF2E2E2E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'QR Code lido: ${widget.qrCode}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome do Ativo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do ativo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: localController,
                decoration: const InputDecoration(
                  labelText: 'Local do Ativo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o local do ativo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enviar Chamado'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF333333),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
