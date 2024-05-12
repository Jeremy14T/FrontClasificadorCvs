import 'package:flutter/material.dart';

class InstructionsDialog {
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
              color: Colors.blueAccent, // Color de fondo azul
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0), // Esquinas redondeadas solo arriba
                topRight: Radius.circular(16.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Instrucciones",
                  style: TextStyle(
                    color: Colors.white, // Color del título blanco
                    fontSize: 20.0, // Tamaño del texto del título
                    fontWeight: FontWeight.bold, // Texto en negrita
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
              children: [
                const Text(
                  "Paso 1: Seleccionar CV’s (verifique que se encuentren en formato pdf y que su archivo no este corrupto) \n\n Paso 2: Seleccione el cargo que desea clasificar/ordenar \n\nPaso 3:Presione clic en el botón “Clasificar” y espere a que el algoritmo haga su trabajo \n\nPaso 4:Su clasificación se realizo con éxito!, de clic en el botón visualizar PDF’s y compruebe que los resultados",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0, // Tamaño del texto de las instrucciones
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
