import 'dart:io'; // Necessário para trabalhar com arquivos (File)
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Importa o pacote que adicionamos

class FormularioPage extends StatefulWidget {
  final String assetId;
  const FormularioPage({super.key, required this.assetId});

  @override
  State<FormularioPage> createState() => _FormularioPageState();
}

class _FormularioPageState extends State<FormularioPage> {
  final _formKey = GlobalKey<FormState>();

  final _salaController = TextEditingController();
  final _equipamentoController = TextEditingController();
  final _numSerieController = TextEditingController();
  final _obsController = TextEditingController();

  bool _isLoading = true;

  // NOVO: Variável para armazenar o arquivo da imagem capturada
  XFile? _imageFile;

  @override
  void initState() {
    super.initState();
    _fetchAssetData();
  }

  Future<void> _fetchAssetData() async {
    // ... (seu código existente para buscar dados)
    await Future.delayed(const Duration(seconds: 2));
    if (widget.assetId == 'ID') {
      _salaController.text = 'Localização';
      _equipamentoController.text = 'Nome Ativo';
      _numSerieController.text = 'NKZ-12345';
    } else {
      _salaController.text = 'Laboratório B';
      _equipamentoController.text = 'Projetor Epson';
      _numSerieController.text = 'EPS-98765';
    }
    setState(() {
      _isLoading = false;
    });
  }

  // NOVO: Função para abrir a câmera e capturar a foto
  Future<void> _tirarFoto() async {
    final ImagePicker picker = ImagePicker();
    // Abre a câmera para o usuário tirar uma foto
    final XFile? foto = await picker.pickImage(source: ImageSource.camera);

    // Se o usuário tirou uma foto (não cancelou), atualizamos o estado
    if (foto != null) {
      setState(() {
        _imageFile = foto;
      });
    }
  }

  @override
  void dispose() {
    // ... (seu código de dispose existente)
    _salaController.dispose();
    _equipamentoController.dispose();
    _numSerieController.dispose();
    _obsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ... (seu Scaffold e Container principal existentes)
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E2E),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          top: 40,
                          right: -62,
                          child: Image.asset('assets/roboForms.png', width: 150),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // ... (seu código do balão e TextFields existentes)
                            Align(
                              alignment: const Alignment(0.4, 0),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset('assets/balaoForms.png', width: 250, height: 200, fit: BoxFit.contain),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 35.0),
                                    child: Text('Confirme os Dados', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(label: 'Sala', controller: _salaController, readOnly: true),
                            const SizedBox(height: 15),
                            _buildTextField(label: 'Equipamento', controller: _equipamentoController, readOnly: true),
                            const SizedBox(height: 15),
                            _buildTextField(label: 'Num - Série', controller: _numSerieController, readOnly: true),
                            const SizedBox(height: 15),
                            _buildTextField(
                              label: 'Obs.',
                              controller: _obsController,
                              hint: 'Descreva o problema',
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Por favor, descreva o problema.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),

                            // NOVO: Widget para mostrar a pré-visualização da imagem
                            if (_imageFile != null) ...[
                              const Text(
                                'Foto Anexada:',
                                style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  File(_imageFile!.path), // Converte XFile para File
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],

                            // NOVO: Botão para tirar a foto
                            OutlinedButton.icon(
                              onPressed: _tirarFoto,
                              icon: const Icon(Icons.camera_alt, color: Color(0xFF333333)),
                              label: const Text(
                                'ANEXAR FOTO',
                                style: TextStyle(color: Color(0xFF333333)),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF333333)),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                            ),
                            const SizedBox(height: 10),

                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // No futuro, aqui você enviará os dados E a imagem
                                  if (_imageFile != null) {
                                    // print("Enviando formulário com a imagem: ${_imageFile!.path}");
                                  } else {
                                    // print("Enviando formulário sem imagem.");
                                  }
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF333333),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('CONFIRMAR CHAMADO', style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  // ... (seu widget _buildTextField existente, sem alterações)
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hint,
    int maxLines = 1,
    bool readOnly = false,
    String? Function(String?)? validator,
  }) {
    // ...
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          readOnly: readOnly,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: readOnly ? const Color(0xFFF0F0F0) : Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: Colors.grey)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0), borderSide: const BorderSide(color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}