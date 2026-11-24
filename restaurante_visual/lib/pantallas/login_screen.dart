import 'dart:ui';

import 'package:flutter/material.dart';
import 'pantalla_gerente.dart';
import 'pantalla_mesero.dart';
import 'pantalla_cocina.dart';
import 'carga_masiva.dart';
import '../responsive.dart';
import '../ui/brand.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _codigoController = TextEditingController();

  void _verificarAcceso() {
    String codigo = _codigoController.text.trim();

    if (codigo == "010") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaGerente()),
      );
    } else if (codigo == "01") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaMesero()),
      );
    } else if (codigo == "011") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PantallaCocina()),
      );
    } else if (codigo == "999") {
      // <--- EL PIN SECRETO
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CargaMasiva()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Código incorrecto. Intenta con 01, 010 o 011'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF13B4E9), Color(0xFF0D8CA6)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final logoSize =
                    constraints.maxWidth < Responsive.phoneBreakpoint
                    ? 120.0
                    : 160.0;
                return SingleChildScrollView(
                  padding: Responsive.pagePadding(context),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 36,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 32,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  Brand.logoUrl,
                                  height: logoSize,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) =>
                                      progress == null
                                      ? child
                                      : SizedBox(
                                          height: logoSize,
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.image_not_supported,
                                        size: 80,
                                        color: Colors.white54,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 22),
                              const Text(
                                'La Ostra Del Golfo',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: Color(0x33000000),
                                      blurRadius: 3,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 28),
                              TextField(
                                controller: _codigoController,
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                  hintText: 'Ingresa tu PIN',
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 22),
                              ElevatedButton(
                                onPressed: _verificarAcceso,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Brand.coral,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 14,
                                  ),
                                  elevation: 8,
                                  shadowColor: Brand.coral.withValues(
                                    alpha: 0.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  'ENTRAR',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
