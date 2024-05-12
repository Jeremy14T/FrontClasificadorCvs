import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';


class ResultDialog {
  static void show(BuildContext context, String resultado, List<Uint8List> archivos, List<String> nombresArchivos) {
    print(nombresArchivos);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: _buildDialogContent(context, resultado, archivos, nombresArchivos),
        );
      },
    );
  }

  static Widget _buildDialogContent(BuildContext context, String resultado, List<Uint8List> archivos, List<String> nombresArchivos) {
    // Eliminar corchetes y espacios innecesarios
    resultado = resultado.replaceAll('[', '').replaceAll(']', '').replaceAll(' ', '');

    // Dividir la cadena por la primera aparición de 'archivos_con_categoria'
    List<String> partes = resultado.split('archivos_con_categoria');

    // Lista para almacenar archivos con categoría
    List<String> archivosConCategoria = [];

    // Si se encontró 'archivos_con_categoria', agregar todo lo que viene después
    if (partes.length > 1) {
      // Obtener la parte después de 'archivos_con_categoria'
      String archivosCategoriaParte = partes[1];

      // Buscar la primera aparición de ":" después de 'archivos_con_categoria'
      int inicio = archivosCategoriaParte.indexOf(':');

      // Buscar la primera aparición de "}" después de ":"
      int fin = archivosCategoriaParte.indexOf('}', inicio);

      // Extraer la parte entre ":" y "}"
      String archivosParte = archivosCategoriaParte.substring(inicio + 1, fin);

      // Dividir la parte por ',' para obtener los nombres de archivo
      List<String> archivos = archivosParte.split(',');

      // Agregar los nombres de archivo a la lista final
      archivosConCategoria.addAll(archivos);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Archivos con categoría:",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: archivosConCategoria.map((archivo) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _visualizarArchivo(context, archivos[archivosConCategoria.indexOf(archivo)], archivo);
                        },
                        child: Text(
                          archivo.trim(), // Eliminar espacios adicionales
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.remove_red_eye,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  static void _visualizarArchivo(BuildContext context, Uint8List archivo, String nombreArchivo) {
    // Crea un archivo en memoria
    File file = File('${nombreArchivo}.pdf');
    file.writeAsBytesSync(archivo);

    // Muestra el PDF utilizando el plugin PDF Viewer

  }
}
