import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../responsive.dart';
import '../catalogo_menu.dart';

class PantallaProductos extends StatefulWidget {
  const PantallaProductos({super.key});

  @override
  State<PantallaProductos> createState() => _PantallaProductosState();
}

class _PantallaProductosState extends State<PantallaProductos> {
  final TextEditingController _claveController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _costoController = TextEditingController();

  String tipoSeleccionado = 'ELAB';
  String categoriaSeleccionada = CatalogoMenu.categorias.first.nombre;
  String? claveSeleccionada;

  void _limpiarFormulario() {
    setState(() {
      _claveController.clear();
      _nombreController.clear();
      _precioController.clear();
      _costoController.clear();
      tipoSeleccionado = 'ELAB';
      categoriaSeleccionada = CatalogoMenu.categorias.first.nombre;
      claveSeleccionada = null;
    });
  }

  Future<void> _reemplazarMenu() async {
    try {
      final coleccion = FirebaseFirestore.instance.collection('productos');
      final existentes = await coleccion.get();
      const clavesMenuAnterior = {
        'P001',
        'C001',
        'M001',
        'X001',
        'E001',
        'S001',
        'P002',
      };
      final clavesNuevas = CatalogoMenu.productos
          .map((producto) => producto.clave)
          .toSet();
      final porEliminar = existentes.docs.where((documento) {
        final datos = documento.data();
        if (datos['tipo']?.toString() == 'INGREDIEN') return false;
        final tipo = datos['tipo']?.toString();
        final tieneCategoria =
            datos['categoria']?.toString().trim().isNotEmpty ?? false;
        final esProductoMenu =
            tipo == 'ELAB' || tipo == 'NOELAB' || tieneCategoria;
        return (esProductoMenu || clavesMenuAnterior.contains(documento.id)) &&
            !clavesNuevas.contains(documento.id);
      }).toList();

      final confirmado = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Reemplazar menú'),
          content: Text(
            'Se reemplazarán ${porEliminar.length} productos anteriores por '
            '${CatalogoMenu.productos.length} productos del menú nuevo. '
            'Se conservarán ingredientes y registros sin tipo de menú ni '
            'categoría; las recetas y comandas históricas no se modificarán.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Reemplazar'),
            ),
          ],
        ),
      );
      if (confirmado != true) return;

      final operaciones = porEliminar.length + CatalogoMenu.productos.length;
      if (operaciones > 500) {
        throw StateError(
          'El catálogo supera el límite de 500 operaciones por lote. '
          'No se realizaron cambios.',
        );
      }

      final batch = FirebaseFirestore.instance.batch();
      for (final documento in porEliminar) {
        batch.delete(documento.reference);
      }
      for (final producto in CatalogoMenu.productos) {
        batch.set(coleccion.doc(producto.clave), producto.toFirestore());
      }
      await batch.commit();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Menú actualizado correctamente.'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _guardarOModificar() async {
    if (_claveController.text.isEmpty || _nombreController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Llena Clave y Nombre')));
      return;
    }

    final claveDoc = _claveController.text.trim().toUpperCase();
    final datos = {
      'clave': claveDoc,
      'nombre': _nombreController.text.trim().toUpperCase(),
      'precio': double.tryParse(_precioController.text) ?? 0.0,
      'costo': double.tryParse(_costoController.text) ?? 0.0,
      'tipo': tipoSeleccionado,
      'categoria': categoriaSeleccionada,
      'ultima_modificacion': DateTime.now(),
    };

    if (claveSeleccionada == null) {
      datos['fecha_registro'] = DateTime.now();
      await FirebaseFirestore.instance
          .collection('productos')
          .doc(claveDoc)
          .set(datos);
    } else {
      await FirebaseFirestore.instance
          .collection('productos')
          .doc(claveDoc)
          .update(datos);
    }

    _limpiarFormulario();
  }

  Future<void> _eliminarProducto() async {
    if (claveSeleccionada != null) {
      await FirebaseFirestore.instance
          .collection('productos')
          .doc(claveSeleccionada)
          .delete();
      _limpiarFormulario();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: MediaQuery.sizeOf(context).width < Responsive.tabletBreakpoint
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- FORMULARIO IZQUIERDO ---
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Datos del Producto (Menú)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _crearDropdown(
                              'Tipo',
                              ['ELAB', 'NOELAB', 'INGREDIEN'],
                              tipoSeleccionado,
                              (val) => setState(() => tipoSeleccionado = val!),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _crearCampoTexto(
                              'Clave',
                              'Ej. M001',
                              _claveController,
                              activado: claveSeleccionada == null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _crearCampoTexto(
                        'Nombre',
                        'Ej. ARRACHERA',
                        _nombreController,
                      ),
                      const SizedBox(height: 16),
                      _crearDropdown(
                        'Categoría',
                        CatalogoMenu.categorias
                            .map((categoria) => categoria.nombre)
                            .toList(),
                        categoriaSeleccionada,
                        (valor) =>
                            setState(() => categoriaSeleccionada = valor!),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _crearCampoTexto(
                              'Precio (\$)',
                              '0.00',
                              _precioController,
                              isNumber: true,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _crearCampoTexto(
                              'Costo (\$)',
                              '0.00',
                              _costoController,
                              isNumber: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // BOTONES DE ACCIÓN
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: claveSeleccionada == null
                                  ? Colors.green
                                  : Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: _guardarOModificar,
                            icon: Icon(
                              claveSeleccionada == null
                                  ? Icons.save
                                  : Icons.edit,
                            ),
                            label: Text(
                              claveSeleccionada == null
                                  ? 'Guardar'
                                  : 'Modificar',
                            ),
                          ),
                          if (claveSeleccionada != null)
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: _eliminarProducto,
                              icon: const Icon(Icons.delete),
                              label: const Text('Eliminar'),
                            ),
                          TextButton(
                            onPressed: _limpiarFormulario,
                            child: const Text('Limpiar'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Divider(),
                      // BOTÓN MÁGICO
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: _reemplazarMenu,
                          icon: const Icon(Icons.cloud_upload),
                          label: const Text('REEMPLAZAR CON EL MENÚ NUEVO'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // --- TABLA DERECHA: FIREBASE ---
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Card(
              elevation: 4,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Productos del menú',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('productos')
                          .orderBy(FieldPath.documentId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              'Error al cargar productos: ${snapshot.error}',
                            ),
                          );
                        }
                        if (!snapshot.hasData)
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        if (snapshot.data!.docs.isEmpty) {
                          return const Center(
                            child: Text('No hay productos registrados.'),
                          );
                        }

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(
                            headingRowColor: MaterialStateProperty.all(
                              Colors.grey[200],
                            ),
                            showCheckboxColumn: false,
                            columns: const [
                              DataColumn(label: Text('Clave')),
                              DataColumn(label: Text('Nombre')),
                              DataColumn(label: Text('Categoría')),
                              DataColumn(label: Text('Precio')),
                              DataColumn(label: Text('Tipo')),
                            ],
                            rows: snapshot.data!.docs.map((doc) {
                              final d = doc.data() as Map<String, dynamic>;
                              return DataRow(
                                selected: claveSeleccionada == doc.id,
                                onSelectChanged: (_) {
                                  setState(() {
                                    claveSeleccionada = doc.id;
                                    _claveController.text = doc.id;
                                    _nombreController.text = d['nombre'] ?? '';
                                    _precioController.text = d['precio']
                                        .toString();
                                    _costoController.text = d['costo']
                                        .toString();
                                    tipoSeleccionado = d['tipo'] ?? 'ELAB';
                                    categoriaSeleccionada =
                                        CatalogoMenu.categoriaPorNombre(
                                          d['categoria']?.toString() ?? '',
                                        )?.nombre ??
                                        CatalogoMenu.categorias.first.nombre;
                                  });
                                },
                                cells: [
                                  DataCell(Text(doc.id)),
                                  DataCell(Text(d['nombre'] ?? '')),
                                  DataCell(Text(d['categoria'] ?? '')),
                                  DataCell(Text('\$${d['precio']}')),
                                  DataCell(Text(d['tipo'] ?? '')),
                                ],
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _crearCampoTexto(
    String etiqueta,
    String hint,
    TextEditingController controller, {
    bool isNumber = false,
    bool activado = true,
  }) {
    return TextFormField(
      controller: controller,
      enabled: activado,
      keyboardType: isNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      decoration: InputDecoration(
        labelText: etiqueta,
        hintText: hint,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
    );
  }

  Widget _crearDropdown(
    String etiqueta,
    List<String> opciones,
    String valorActual,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: valorActual,
      decoration: InputDecoration(
        labelText: etiqueta,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      items: opciones
          .map(
            (String valor) =>
                DropdownMenuItem<String>(value: valor, child: Text(valor)),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
