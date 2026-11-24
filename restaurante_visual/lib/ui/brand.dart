import 'package:flutter/material.dart';

class Brand {
  static const logoUrl = 'https://i.ibb.co/4w3b9qyd/logo-nuevo.jpg';

  static const navy = Color(0xFF0D8CA6);
  static const navyLight = Color(0xFF13B4E9);
  static const teal = Color(0xFF0D8CA6);
  static const aqua = Color(0xFF13B4E9);
  static const coral = Color(0xFFF26B04);
  static const cream = Color(0xFFFFFBF5);
  static const background = Color(0xFFF0FAFC);
  static const ink = Color(0xFF263238);
  static const muted = Color(0xFF607D8B);
  static const success = Color(0xFF16803C);
  static const danger = Color(0xFFB42318);

  static const radius = 16.0;

  static BoxDecoration panel({Color color = Colors.white}) => BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: const Color(0xFFE4E7EC)),
    boxShadow: const [
      BoxShadow(color: Color(0x12000000), blurRadius: 12, offset: Offset(0, 4)),
    ],
  );

  static ButtonStyle primaryButton() => ElevatedButton.styleFrom(
    backgroundColor: teal,
    foregroundColor: Colors.white,
    minimumSize: const Size(0, 48),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
