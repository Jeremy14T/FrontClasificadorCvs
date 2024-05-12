import 'dart:async'; // Importa este paquete para utilizar Future
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class Carga extends StatefulWidget {
  final dynamic categoria;
  final List<Uint8List> archivos;
  final List<String> nombresArchivos;

  const Carga({required this.categoria, required this.archivos, required this.nombresArchivos});

  @override
  _CargaState createState() => _CargaState();
}

class _CargaState extends State<Carga> {
  String resultado = '';

  @override
  void initState() {
    super.initState();
    enviarArchivos();

    // Espera 10 segundos antes de navegar a ClasificacionScreen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ClasificacionScreen(title: 'Clasificación exitosa', respuestaAPI: resultado, archivos: widget.archivos, nombresArchivos: widget.nombresArchivos)),
      );
    });
  }

  Future<void> enviarArchivos() async {
    if (widget.categoria == null || widget.archivos.isEmpty) {
      setState(() {
        resultado = 'Selecciona una categoría y al menos un archivo.';
      });
      return;
    }

    setState(() {
      resultado = '';
    });

    try {
      var uri = Uri.parse('http://localhost:5000/clasificar');
      var request = http.MultipartRequest('POST', uri);

      // Mostrar qué categoría se está enviando
      print('Categoría: ${widget.categoria}');

      request.fields['categoria'] = widget.categoria;

      for (int i = 0; i < widget.archivos.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes('file', widget.archivos[i], filename: widget.nombresArchivos[i]),
        );
        // Mostrar el nombre del archivo que se está adjuntando
        print('Archivo adjunto: ${widget.nombresArchivos[i]}');
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        //print('Respuesta de la API: $responseData'); // Imprime la respuesta de la API
        var data = json.decode(responseData);
        setState(() {
          resultado = data.toString();
        });
      } else {
        setState(() {
          resultado = 'Error en la clasificación. Por favor, inténtalo de nuevo más tarde.';
        });
      }
    } catch (e) {
      setState(() {
        resultado = 'Error: $e. Por favor, revisa tu conexión a internet e inténtalo de nuevo.';
      });
    } finally {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0, // No mostrar sombra
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Clasificando CV\'s',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/dance.gif', // Reemplaza 'assets/dance.gif' con la ruta de tu imagen
                  width: 200, // Ancho deseado para la imagen
                  height: 200, // Altura deseada para la imagen
                ),
                SizedBox(
                  width: 150, // Ancho deseado para el icono de carga
                  height: 150, // Altura deseada para el icono de carga
                  child: CircularProgressIndicator(
                    strokeWidth: 8, // Grosor deseado para el indicador de progreso
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent), // Color deseado para el indicador de progreso
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              "Ten paciencia, estamos encontrando coincidencias :D",
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


