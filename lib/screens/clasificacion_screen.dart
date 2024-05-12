import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../widgets/result_dialog.dart';
import '../widgets/widgets.dart';

class ClasificacionScreen extends StatelessWidget {
  final String title;
  final dynamic respuestaAPI;
  final List<Uint8List> archivos;
  final List<String> nombresArchivos;

  const ClasificacionScreen({required this.title, this.respuestaAPI, required this.archivos, required this.nombresArchivos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.home), // Cambiando el ícono a home
          onPressed: () {
            // Navegar a la pantalla principal
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Principal()),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                InstructionsDialog.show(context); // Mostrar el diálogo de instrucciones
                print('Boton 1');
              },
              icon: Icon(Icons.info),
              label: Text('Instrucciones'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                elevation: 0, // No mostrar sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Acción del botón 2
                print('Boton 2');
              },
              icon: Icon(Icons.file_download),
              label: Text('Descargar Plantilla'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                elevation: 0, // No mostrar sombra
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(
            height: 2,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '¡Clasificación exitosa!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón de "Visualizar PDFs"
                  ResultDialog.show(context, respuestaAPI, archivos, nombresArchivos); // Pasa el resultado a ResultDialog
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Visualizar PDFs',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
