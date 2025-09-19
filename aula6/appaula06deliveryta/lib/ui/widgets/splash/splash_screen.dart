import 'package:flutter/material.dart';
import 'package:appaula06deliveryta/ui/core/app_colors.dart';
// Removido o import da HomeScreen, pois agora vamos para AuthScreen
import 'package:appaula06deliveryta/ui/widgets/auth/auth_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Stack(
          children: [
            Image.asset('assets/banners/banner_splash.png'),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // Removido: spacing: 32, pois não existe essa propriedade em Column
                children: [
                  Image.asset('assets/logo.png', width: 192),
                  const SizedBox(height: 32), // espaçamento manual
                  Column(
                    children: [
                      const Text(
                        'Um parceiro inovador para sua',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Text(
                        'Melhor experiência culinária',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AuthScreen(),
                              ),
                            );
                          },
                          child: const Text('Bora'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
