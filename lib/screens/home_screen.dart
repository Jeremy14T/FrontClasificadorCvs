import 'package:flutter/material.dart';
import '../router/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/widgets.dart';
import 'screens.dart'; // Importa el archivo de la alerta

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final menuOptions = AppRoutes.menuOptions;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0, // No mostrar sombra
        title: Text(
          'Componentes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Acción del botón 1
                print('Boton 1');
              },
              icon: Icon(Icons.info),
              label: Text('Instrucciones'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
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
                foregroundColor: Colors.white,
                backgroundColor: Colors.blueAccent,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, i) {
                if (i < menuOptions.length) {
                  // Mostrar elementos de la lista de opciones
                  return ListTile(
                    leading: Icon(menuOptions[i].icon, color: AppTheme.primary),
                    title: Text(menuOptions[i].name),
                    onTap: () {
                      // Verificar si el botón presionado es "Alert Error"
                      if (menuOptions[i].name == 'Alert Error') {
                        // Mostrar la alerta de error
                        ErrorDialog.show(context);
                      } else if (menuOptions[i].name == 'Instrucciones') {
                        // Mostrar la ventana de instrucciones
                        InstructionsDialog.show(context);
                      } else {
                        // Navegar a la ruta correspondiente
                        Navigator.pushNamed(context, menuOptions[i].route);
                      }
                    },
                  );
                } else {
                  // No mostrar nada para el índice adicional del botón
                  return SizedBox.shrink();
                }
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: menuOptions.length, // No se incluye el botón adicional aquí
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Mostrar la alerta de error
                ErrorDialog.show(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                backgroundColor: Colors.red, // Color del botón
                textStyle: TextStyle(fontSize: 16), // Tamaño del texto del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados del botón
                ),
              ),
              child: Text(
                'Mostrar Alerta de Error',
                style: TextStyle(color: Colors.white), // Color del texto del botón
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Mostrar las instrucciones
                InstructionsDialog.show(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                backgroundColor: Colors.blue, // Color del botón
                textStyle: TextStyle(fontSize: 16), // Tamaño del texto del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Bordes redondeados del botón
                ),
              ),
              child: Text(
                'Mostrar Instrucciones',
                style: TextStyle(color: Colors.white), // Color del texto del botón
              ),
            ),
          ),
        ],
      ),
    );
  }
}
