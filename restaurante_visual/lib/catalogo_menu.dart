import 'package:flutter/material.dart';

class CategoriaMenu {
  final String nombre;
  final IconData icono;
  final Color color;

  const CategoriaMenu({
    required this.nombre,
    required this.icono,
    required this.color,
  });
}

class ProductoMenu {
  final String categoria;
  final String nombre;
  final double precio;

  const ProductoMenu({
    required this.categoria,
    required this.nombre,
    required this.precio,
  });

  String get clave =>
      'MENU-${CatalogoMenu._normalizar(categoria)}-${CatalogoMenu._normalizar(nombre)}';

  Map<String, dynamic> toFirestore() => {
    'clave': clave,
    'nombre': nombre.toUpperCase(),
    'precio': precio,
    'costo': 0.0,
    'tipo': 'ELAB',
    'categoria': categoria,
  };
}

class CatalogoMenu {
  static const List<CategoriaMenu> categorias = [
    CategoriaMenu(
      nombre: 'COCTELES',
      icono: Icons.local_bar,
      color: Colors.redAccent,
    ),
    CategoriaMenu(
      nombre: 'CAMPECHANAS',
      icono: Icons.set_meal,
      color: Colors.teal,
    ),
    CategoriaMenu(nombre: 'ENSALADAS', icono: Icons.eco, color: Colors.green),
    CategoriaMenu(
      nombre: 'EXTRAS',
      icono: Icons.add_circle,
      color: Colors.grey,
    ),
    CategoriaMenu(
      nombre: 'TOSTADAS',
      icono: Icons.dinner_dining,
      color: Colors.deepOrange,
    ),
    CategoriaMenu(
      nombre: 'ESPECIALIDADES',
      icono: Icons.star,
      color: Colors.amber,
    ),
    CategoriaMenu(
      nombre: 'PLATILLOS',
      icono: Icons.restaurant_menu,
      color: Colors.orange,
    ),
    CategoriaMenu(
      nombre: 'CERVEZAS',
      icono: Icons.sports_bar,
      color: Colors.brown,
    ),
    CategoriaMenu(
      nombre: 'BEBIDAS',
      icono: Icons.local_drink,
      color: Colors.lightBlue,
    ),
  ];

  static final List<ProductoMenu> productos = [
    for (final nombre in const [
      'Camarón',
      'Calamar',
      'Caracol',
      'Ostión',
      'Jaiba',
      'Cangrejo',
      'Hueva',
      'Surimi',
      'Ceviche',
    ])
      ..._variantes(
        'COCTELES',
        nombre,
        ['Chico', 'Mediano', 'Grande'],
        [90, 130, 150],
      ),
    ..._variantes(
      'COCTELES',
      'Aguacate',
      ['Chico', 'Mediano', 'Grande'],
      [50, 70, 80],
    ),
    for (final nombre in const [
      'Camarón - Ostión',
      'Camarón - Ceviche',
      'Camarón - Caracol',
      'Camarón - Jaiba',
      'Ostión - Cangrejo',
      'Camarón - Calamar',
      'Camarón - Hueva',
      'Camarón - Surimi',
    ])
      ..._variantes(
        'CAMPECHANAS',
        nombre,
        ['Chico (75 gr)', 'Mediano (100 gr)', 'Grande (120 gr)'],
        [90, 130, 150],
      ),
    ProductoMenu(
      categoria: 'ENSALADAS',
      nombre: 'Camarón o ceviche',
      precio: 130,
    ),
    const ProductoMenu(
      categoria: 'EXTRAS',
      nombre: 'Galleta extra',
      precio: 15,
    ),
    const ProductoMenu(
      categoria: 'EXTRAS',
      nombre: 'Orden de tostadas (3 pzs)',
      precio: 15,
    ),
    const ProductoMenu(
      categoria: 'EXTRAS',
      nombre: 'Orden de aguacate',
      precio: 20,
    ),
    const ProductoMenu(
      categoria: 'TOSTADAS',
      nombre: 'Camarón, ceviche, jaiba o minilla (c/u)',
      precio: 70,
    ),
    ..._variantes(
      'ESPECIALIDADES',
      'Vuelve a la vida',
      ['150 gr', '220 gr'],
      [170, 220],
    ),
    const ProductoMenu(
      categoria: 'ESPECIALIDADES',
      nombre: 'Especial (de 1 a 3 mariscos) 190 gr',
      precio: 250,
    ),
    const ProductoMenu(
      categoria: 'PLATILLOS',
      nombre: 'Tacos dorados de minilla (ord. 3 pzs)',
      precio: 60,
    ),
    const ProductoMenu(
      categoria: 'PLATILLOS',
      nombre: 'Empanadas de minilla (ord. 3 pzs)',
      precio: 60,
    ),
    const ProductoMenu(
      categoria: 'PLATILLOS',
      nombre: 'Empanadas de camarón (ord. 3 pzs)',
      precio: 80,
    ),
    const ProductoMenu(
      categoria: 'PLATILLOS',
      nombre: 'Tamal de camarón (c/u)',
      precio: 40,
    ),
    const ProductoMenu(
      categoria: 'PLATILLOS',
      nombre: 'Aguacate relleno de camarón',
      precio: 100,
    ),
    const ProductoMenu(
      categoria: 'CERVEZAS',
      nombre: 'Corona y Victoria',
      precio: 50,
    ),
    const ProductoMenu(
      categoria: 'CERVEZAS',
      nombre: 'Negra Modelo y Modelo Especial',
      precio: 50,
    ),
    const ProductoMenu(
      categoria: 'CERVEZAS',
      nombre: 'Tarro chelado',
      precio: 15,
    ),
    const ProductoMenu(
      categoria: 'CERVEZAS',
      nombre: 'Tarro michelado',
      precio: 20,
    ),
    const ProductoMenu(
      categoria: 'CERVEZAS',
      nombre: 'Tarro michelado con clamato',
      precio: 25,
    ),
    const ProductoMenu(
      categoria: 'CERVEZAS',
      nombre: 'Clamato preparado',
      precio: 50,
    ),
    const ProductoMenu(categoria: 'BEBIDAS', nombre: 'Refrescos', precio: 40),
    ..._variantes('BEBIDAS', 'Jugo de naranja', ['Chico', 'Grande'], [20, 30]),
    ..._variantes('BEBIDAS', 'Zarzaparrilla', ['Chico', 'Grande'], [15, 20]),
    ..._variantes('BEBIDAS', 'Aguas frescas', ['Chico', 'Grande'], [20, 30]),
    const ProductoMenu(categoria: 'BEBIDAS', nombre: 'Agua Marina', precio: 50),
    ..._variantes(
      'BEBIDAS',
      'Naranjada o limonada',
      ['Natural', 'Preparada'],
      [45, 50],
    ),
  ];

  static CategoriaMenu? categoriaPorNombre(String nombre) {
    for (final categoria in categorias) {
      if (categoria.nombre == nombre) return categoria;
    }
    return null;
  }

  static List<ProductoMenu> _variantes(
    String categoria,
    String nombre,
    List<String> opciones,
    List<double> precios,
  ) {
    if (opciones.length != precios.length) {
      throw ArgumentError('Cada variante debe tener su propio precio.');
    }
    return List.generate(
      opciones.length,
      (index) => ProductoMenu(
        categoria: categoria,
        nombre: '$nombre ${opciones[index]}',
        precio: precios[index],
      ),
    );
  }

  static String _normalizar(String texto) => texto
      .toUpperCase()
      .replaceAll('Á', 'A')
      .replaceAll('É', 'E')
      .replaceAll('Í', 'I')
      .replaceAll('Ó', 'O')
      .replaceAll('Ú', 'U')
      .replaceAll('Ü', 'U')
      .replaceAll('Ñ', 'N')
      .replaceAll(RegExp(r'[^A-Z0-9]+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
}
