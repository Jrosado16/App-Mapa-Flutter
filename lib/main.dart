import 'package:app_mapa/pages/acceso_gps.page.dart';
import 'package:app_mapa/pages/loading.page.dart';
import 'package:app_mapa/pages/mapa.page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
      routes: {
        '/acceso'   : (_) => AccesoGpsPage(), 
        '/loading'  : (_) => LoadingPage(), 
        '/mapa'     : (_) => MapaPage(), 
      },
    );
  }
}