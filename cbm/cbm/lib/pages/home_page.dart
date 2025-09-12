import 'package:flutter/material.dart';
import 'qr_scanner_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF2E2E2E),
      body: Center(
        child: Container(
          width: screenSize.width * 0.85,
          height: screenSize.height * 0.6,
          decoration: BoxDecoration(
            color: const Color(0xFFE0E0E0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 5,
                right: 5,
                child: IconButton(
                  icon: const Icon(
                    Icons.exit_to_app,
                    color: Colors.black54,
                    size: 30,
                  ),
                  onPressed: () {
                    // Deslogar e voltar para login
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ),
              Positioned(
                bottom: 80,
                left: -58,
                child: Image.asset(
                  'assets/roboHome.png',
                  width: 199,
                ),
              ),
              Positioned(
                top: 25,
                left: 63,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/balaoHome.png',
                      width: 250,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        'Bem vindo Andre',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const QrScannerPage(),
                            ),
                          );
                          if (result != null) {
                            // Aqui você pode redirecionar para o formulário
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Código lido: $result')),
                            );
                            // Por exemplo: Navigator.push para a FormPage passando o result
                          }
                        },
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        label: const Text('Abrir Chamado'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF333333),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implementar ação para Chamado Urgente
                        },
                        icon: const Icon(Icons.warning, color: Colors.white),
                        label: const Text('Chamado Urgente'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF333333),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
