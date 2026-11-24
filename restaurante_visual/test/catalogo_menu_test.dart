import 'package:flutter_test/flutter_test.dart';
import 'package:restaurante_visual/catalogo_menu.dart';

void main() {
  test('el catálogo contiene las categorías y productos del menú nuevo', () {
    expect(CatalogoMenu.categorias.map((categoria) => categoria.nombre), [
      'COCTELES',
      'CAMPECHANAS',
      'ENSALADAS',
      'EXTRAS',
      'TOSTADAS',
      'ESPECIALIDADES',
      'PLATILLOS',
      'CERVEZAS',
      'BEBIDAS',
    ]);
    expect(CatalogoMenu.productos, hasLength(83));

    final categorias = CatalogoMenu.categorias
        .map((categoria) => categoria.nombre)
        .toSet();
    expect(
      CatalogoMenu.productos.every(
        (producto) => categorias.contains(producto.categoria),
      ),
      isTrue,
    );
  });

  test('las variantes tienen claves únicas y conservan sus precios', () {
    final claves = CatalogoMenu.productos
        .map((producto) => producto.clave)
        .toSet();
    expect(claves, hasLength(CatalogoMenu.productos.length));

    final coctelChico = CatalogoMenu.productos.singleWhere(
      (producto) => producto.nombre == 'Camarón Chico',
    );
    expect(coctelChico.categoria, 'COCTELES');
    expect(coctelChico.precio, 90);

    final campechanaGrande = CatalogoMenu.productos.singleWhere(
      (producto) => producto.nombre == 'Camarón - Ostión Grande (120 gr)',
    );
    expect(campechanaGrande.precio, 150);
  });
}
