import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRoutes {

  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    // TODO: borrar home
    // MenuOption(route: 'home', name: 'Home Screen', screen: const HomeScreen(), icon: Icons.home_max_sharp ),
    // MenuOption(route: 'listview1', name: 'Listview tipo 1', screen: const Listview1Screen(), icon: Icons.list_alt ),
    // MenuOption(route: 'listview2', name: 'Listview tipo 2', screen: const Listview2Screen(), icon: Icons.list ),
    MenuOption(route: 'principal', name: 'Pantalla Principal', screen: const Principal(), icon: Icons.add_alert_outlined ),
    MenuOption(route: 'cangando', name: 'Pantalla Carga', screen: const Carga(categoria: null, archivos: [], nombresArchivos: [],), icon: Icons.supervised_user_circle_outlined ),
    MenuOption(route: 'clasificado', name: 'Pantalla Clasificion exitosa', screen: ClasificacionScreen(title: '', respuestaAPI: null, archivos: [], nombresArchivos: [],), icon: Icons.credit_card ),
    // MenuOption(route: 'inputs', name: 'Text Inputs', screen: const InputsScreen(), icon: Icons.input_rounded ),
    // MenuOption(route: 'slider', name: 'Slider && Checks', screen: const SliderScreen(), icon: Icons.slow_motion_video_rounded),
    // MenuOption(route: 'listviewbuilder', name: 'InfiniteScrol & Pull to refresh', screen: const ListViewBuilderScreen(), icon: Icons.build_circle_outlined ),
  ];


  static Map<String, Widget Function(BuildContext)> getAppRoutes() {

    Map<String, Widget Function(BuildContext)> appRoutes = {};
    appRoutes.addAll({ 'home' : ( BuildContext context ) => const Principal() });

    for (final option in menuOptions ) {
      appRoutes.addAll({ option.route : ( BuildContext context ) => option.screen });
    }

    return appRoutes;
  }

  // static Map<String, Widget Function(BuildContext)> routes = {
  //   'home'     : ( BuildContext context ) => const HomeScreen(),
  //   'listview1': ( BuildContext context ) => const Listview1Screen(),
  //   'listview2': ( BuildContext context ) => const Listview2Screen(),
  //   'alert'    : ( BuildContext context ) => const AlertScreen(),
  //   'card'     : ( BuildContext context ) => const CardScreen(),
  // };

  static Route<dynamic> onGenerateRoute( RouteSettings settings) {        
      return MaterialPageRoute(
          builder: (context) => const Principal(),
      );
  }

}