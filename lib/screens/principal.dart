import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key});

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
      body: SingleChildScrollView(
        child: _PrincipalBody(),
      ),
    );
  }
}

class _PrincipalBody extends StatefulWidget {
  @override
  __PrincipalBodyState createState() => __PrincipalBodyState();
}

class __PrincipalBodyState extends State<_PrincipalBody> {
  String? _selectedOption;
  String? categoria;
  List<Uint8List> archivos = [];
  List<String> nombresArchivos = [];
  String resultado = '';
  bool _isLoading = false;

  Future<void> seleccionarArchivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        archivos.addAll(result.files.map((file) => file.bytes!).toList());
        nombresArchivos.addAll(result.files.map((file) => file.name).toList());
      });
    }
  }

  void eliminarArchivo(int index) {
    setState(() {
      archivos.removeAt(index);
      nombresArchivos.removeAt(index);
    });
  }

  Future<void> enviarArchivos() async {
    if (categoria == null || archivos.isEmpty) {
      setState(() {
        resultado = 'Selecciona una categoría y al menos un archivo.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      resultado = '';
    });

    try {
      var uri = Uri.parse('http://localhost:5000/clasificar');
      var request = http.MultipartRequest('POST', uri);

      // Mostrar qué categoría se está enviando
      print('Categoría: $categoria');

      request.fields['categoria'] = categoria!;

      for (int i = 0; i < archivos.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes('file', archivos[i], filename: nombresArchivos[i]),
        );
        // Mostrar el nombre del archivo que se está adjuntando
        //print('Archivo adjunto: ${nombresArchivos[i]}');
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
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    categoria = _selectedOption;
    return Column(
      children: <Widget>[
        // Encabezado
        Container(
          height: 100,
          color: Colors.blueAccent,
          child: Center(
            child: Text(
              'Clasificador de CVs de las TICs',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        // Sección de selección de CVs
        Container(
          margin: EdgeInsets.all(20),
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
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                'Organiza grupos de CV´s para identificar las coincidencias más adecuadas con los candidatos más calificados. Recuerda que solo se puede clasificar los cv´s con nuestra plantilla.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: seleccionarArchivos,
                child: Text('Seleccionar CVs en PDF'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blueAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (nombresArchivos.isNotEmpty) // Mostrar solo si hay archivos seleccionados
                Container(
                  height: 100, // Altura fija del contenedor
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(nombresArchivos.length, (index) {
                        return Row(
                          children: [
                            Expanded(
                              child: Text(
                                nombresArchivos[index],
                                style: TextStyle(fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                eliminarArchivo(index);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                ),
            ],
          ),
        ),
        // Sección de selección de puesto
        Container(
          margin: EdgeInsets.all(20),
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
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              const Text('Selecciona el puesto que deseas obtener:'),
              DropdownButton<String>(
                value: _selectedOption,
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem<String>(
                    child: Text('Blockchain'),
                    value: 'Blockchain',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Data Science'),
                    value: 'Data Science',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Database'),
                    value: 'Database',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('DevOps Engineer'),
                    value: 'DevOps Engineer',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Dotnet Developer'),
                    value: 'Dotnet Developer',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Java Developer'),
                    value: 'Java Developer',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Network security Engineer'),
                    value: 'Network security Engineer',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Python Developer'),
                    value: 'Python Developer',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Testing'),
                    value: 'Testing',
                  ),
                  DropdownMenuItem<String>(
                    child: Text('Web Designing'),
                    value: 'Web Designing',
                  ),
                ],
                onChanged: (String? value) {
                  // Actualizar la opción seleccionada
                  setState(() {
                    _selectedOption = value;
                    categoria = value;
                  });
                  // Acción cuando se selecciona un puesto
                  print('Puesto seleccionado: $value');
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        // Sección de clasificación
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () async {
              // Navegar a la pantalla de carga al presionar el botón "Clasificar"
              _isLoading ? null : enviarArchivos();
              //print('=============\nResultado enviado a ClasificacionScreen: $resultado'); // Imprime el resultado enviado

              // Esperar un poco para permitir que se complete la llamada a la API
              //await Future.delayed(Duration(seconds: 2));

              // Luego, navegar a la pantalla ClasificacionScreen
              Navigator.push(
                context,
                      MaterialPageRoute(builder: (context) => Carga(categoria: categoria, archivos: archivos, nombresArchivos: nombresArchivos)), // Navega a la pantalla de carga
                    );
            },
            child: Text('Clasificar!'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        //SizedBox(height: 20),
        //Text(resultado),
      ],
    );
  }
}
