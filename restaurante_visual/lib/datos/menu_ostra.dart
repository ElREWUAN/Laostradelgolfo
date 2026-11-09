/// Menú de "La Ostra del Golfo" (Una tradición en Xalapa, desde 1961).
///
/// Cada tamaño se guarda como un producto independiente, así el carrito,
/// las comandas, las recetas y el inventario funcionan sin cambios.
/// Cada producto tiene: clave, nombre, categoria, precio, costo y tipo.
///
/// NOTA: 'costo' queda en 0.0 porque el menú impreso no lo trae.
/// Se puede capturar después desde la pantalla de Productos.
library;

const String catCocteles = 'COCTELES';
const String catCampechanas = 'CAMPECHANAS';
const String catEnsaladas = 'ENSALADAS';
const String catExtras = 'EXTRAS';
const String catTostadas = 'TOSTADAS';
const String catEspecialidades = 'ESPECIALIDADES';
const String catPlatillos = 'PLATILLOS';
const String catCervezas = 'CERVEZAS';
const String catBebidas = 'BEBIDAS';

/// Lista de categorías, en el orden del menú impreso.
const List<String> categoriasOstra = [
  catCocteles,
  catCampechanas,
  catEnsaladas,
  catExtras,
  catTostadas,
  catEspecialidades,
  catPlatillos,
  catCervezas,
  catBebidas,
];

Map<String, dynamic> _p(
  String clave,
  String nombre,
  String categoria,
  double precio, {
  String tipo = 'ELAB',
}) => {
  'clave': clave,
  'nombre': nombre,
  'categoria': categoria,
  'precio': precio,
  'costo': 0.0,
  'tipo': tipo,
};

List<Map<String, dynamic>> construirMenuOstra() {
  final menu = <Map<String, dynamic>>[];

  // ---------------- COCTELES (Ch / Med / Grd) ----------------
  const cocteles = <String, String>{
    'CAMARON': 'CAMARÓN',
    'CALAMAR': 'CALAMAR',
    'CARACOL': 'CARACOL',
    'OSTION': 'OSTIÓN',
    'JAIBA': 'JAIBA',
    'CANGREJO': 'CANGREJO',
    'HUEVA': 'HUEVA',
    'SURIMI': 'SURIMI',
    'CEVICHE': 'CEVICHE',
  };
  cocteles.forEach((k, nombre) {
    menu.add(_p('CT-$k-CH', 'CÓCTEL DE $nombre CH', catCocteles, 90));
    menu.add(_p('CT-$k-MD', 'CÓCTEL DE $nombre MED', catCocteles, 130));
    menu.add(_p('CT-$k-GR', 'CÓCTEL DE $nombre GRD', catCocteles, 150));
  });
  menu.add(_p('CT-AGUACATE-CH', 'CÓCTEL DE AGUACATE CH', catCocteles, 50));
  menu.add(_p('CT-AGUACATE-MD', 'CÓCTEL DE AGUACATE MED', catCocteles, 70));
  menu.add(_p('CT-AGUACATE-GR', 'CÓCTEL DE AGUACATE GRD', catCocteles, 80));

  // ---------------- CAMPECHANAS (75 gr / 100 gr / 120 gr) ----------------
  const campechanas = <String, String>{
    'CAMARON-OSTION': 'CAMARÓN-OSTIÓN',
    'CAMARON-CEVICHE': 'CAMARÓN-CEVICHE',
    'CAMARON-CARACOL': 'CAMARÓN-CARACOL',
    'CAMARON-JAIBA': 'CAMARÓN-JAIBA',
    'OSTION-CANGREJO': 'OSTIÓN-CANGREJO',
    'CAMARON-CALAMAR': 'CAMARÓN-CALAMAR',
    'CAMARON-HUEVA': 'CAMARÓN-HUEVA',
    'CAMARON-SURIMI': 'CAMARÓN-SURIMI',
  };
  campechanas.forEach((k, nombre) {
    menu.add(_p('CP-$k-CH', 'CAMPECHANA $nombre CH (75 GR)', catCampechanas, 90));
    menu.add(_p('CP-$k-MD', 'CAMPECHANA $nombre MED (100 GR)', catCampechanas, 130));
    menu.add(_p('CP-$k-GR', 'CAMPECHANA $nombre GRD (120 GR)', catCampechanas, 150));
  });

  // ---------------- ENSALADAS ----------------
  menu.add(_p('EN-CAMARON', 'ENSALADA DE CAMARÓN', catEnsaladas, 130));
  menu.add(_p('EN-CEVICHE', 'ENSALADA DE CEVICHE', catEnsaladas, 130));

  // ---------------- EXTRAS ----------------
  menu.add(_p('EX-GALLETA', 'GALLETA EXTRA', catExtras, 15));
  menu.add(_p('EX-TOSTADAS', 'ORD. TOSTADAS (3 PZS)', catExtras, 15));
  menu.add(_p('EX-AGUACATE', 'ORD. DE AGUACATE', catExtras, 20));

  // ---------------- TOSTADAS ($70 c/u) ----------------
  menu.add(_p('TO-CAMARON', 'TOSTADA DE CAMARÓN', catTostadas, 70));
  menu.add(_p('TO-CEVICHE', 'TOSTADA DE CEVICHE', catTostadas, 70));
  menu.add(_p('TO-JAIBA', 'TOSTADA DE JAIBA', catTostadas, 70));
  menu.add(_p('TO-MINILLA', 'TOSTADA DE MINILLA', catTostadas, 70));

  // ---------------- ESPECIALIDADES ----------------
  menu.add(_p('ES-VLV-150', 'VUELVE A LA VIDA (150 GR)', catEspecialidades, 170));
  menu.add(_p('ES-VLV-220', 'VUELVE A LA VIDA (220 GR)', catEspecialidades, 220));
  menu.add(_p('ES-ESPECIAL', 'ESPECIAL DE 1 A 3 MARISCOS (190 GR)', catEspecialidades, 250));

  // ---------------- PLATILLOS ----------------
  // OJO: en la foto del menú la lista de platillos está cortada abajo.
  // Agregar aquí los que falten.
  menu.add(_p('PL-TACOS-MINILLA', 'TACOS DORADOS DE MINILLA (ORD. 3 PZS)', catPlatillos, 60));
  menu.add(_p('PL-EMP-MINILLA', 'EMPANADAS DE MINILLA (ORD. 3 PZS)', catPlatillos, 60));
  menu.add(_p('PL-EMP-CAMARON', 'EMPANADAS DE CAMARÓN (ORD. 3 PZS)', catPlatillos, 80));
  menu.add(_p('PL-TAMAL-CAMARON', 'TAMAL DE CAMARÓN', catPlatillos, 40));
  menu.add(_p('PL-AGUACATE-REL', 'AGUACATE RELLENO DE CAMARÓN', catPlatillos, 100));

  // ---------------- CERVEZAS ----------------
  menu.add(_p('CE-CORONA', 'CORONA', catCervezas, 50, tipo: 'NOELAB'));
  menu.add(_p('CE-VICTORIA', 'VICTORIA', catCervezas, 50, tipo: 'NOELAB'));
  menu.add(_p('CE-NEGRA-MODELO', 'NEGRA MODELO', catCervezas, 50, tipo: 'NOELAB'));
  menu.add(_p('CE-MODELO-ESPECIAL', 'MODELO ESPECIAL', catCervezas, 50, tipo: 'NOELAB'));
  menu.add(_p('CE-TARRO-CHELADO', 'TARRO CHELADO', catCervezas, 15));
  menu.add(_p('CE-TARRO-MICHELADO', 'TARRO MICHELADO', catCervezas, 20));
  menu.add(_p('CE-TARRO-MICH-CLAMATO', 'TARRO MICHELADO CON CLAMATO', catCervezas, 25));
  menu.add(_p('CE-CLAMATO-PREP', 'CLAMATO PREPARADO', catCervezas, 50));

  // ---------------- BEBIDAS ----------------
  menu.add(_p('BE-REFRESCO', 'REFRESCO', catBebidas, 40, tipo: 'NOELAB'));
  menu.add(_p('BE-JUGO-NARANJA-CH', 'JUGO DE NARANJA CH', catBebidas, 20));
  menu.add(_p('BE-JUGO-NARANJA-GR', 'JUGO DE NARANJA GRD', catBebidas, 30));
  menu.add(_p('BE-ZARZA-CH', 'ZARZAPARRILLA CH', catBebidas, 15, tipo: 'NOELAB'));
  menu.add(_p('BE-ZARZA-GR', 'ZARZAPARRILLA GRD', catBebidas, 20, tipo: 'NOELAB'));
  menu.add(_p('BE-AGUAS-CH', 'AGUAS FRESCAS CH', catBebidas, 20));
  menu.add(_p('BE-AGUAS-GR', 'AGUAS FRESCAS GRD', catBebidas, 30));
  menu.add(_p('BE-AGUA-MARINA', 'AGUA MARINA', catBebidas, 50));
  menu.add(_p('BE-NARANJADA-NAT', 'NARANJADA O LIMONADA NATURAL', catBebidas, 45));
  menu.add(_p('BE-NARANJADA-PREP', 'NARANJADA O LIMONADA PREPARADA', catBebidas, 50));

  return menu;
}
