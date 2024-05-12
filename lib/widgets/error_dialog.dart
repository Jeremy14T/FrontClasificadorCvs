import 'package:flutter/material.dart';

class ErrorDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
          ),
          elevation: 0, // Sin sombra
          backgroundColor: Colors.transparent, // Fondo transparente
          child: _buildDialogContent(context),
        );
      },
    );
  }

  static Widget _buildDialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0), // Bordes redondeados
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Sombra suave
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // Desplazamiento de la sombra
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
              color: Colors.red, // Color de fondo azul
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0), // Esquinas redondeadas solo arriba
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Text(
              "Ha ocurrido un error!",
              style: TextStyle(
                color: Colors.white, // Color del título blanco
                fontSize: 20.0, // Tamaño del texto del título
                fontWeight: FontWeight.bold, // Texto en negrita
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Favor de revisar las instrucciones o condiciones de funcionamiento.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87, // Color del texto negro
                fontSize: 16.0, // Tamaño del texto del contenido
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: Text(
              "Entendido",
              style: TextStyle(
                color: Colors.blueAccent, // Color del botón azul
                fontSize: 18.0, // Tamaño del texto del botón
                fontWeight: FontWeight.bold, // Texto en negrita
              ),
            ),
          ),
        ],
      ),
    );
  }
}
