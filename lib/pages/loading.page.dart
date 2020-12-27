import 'package:app_mapa/helpers/navigation.helper.dart';
import 'package:app_mapa/pages/acceso_gps.page.dart';
import 'package:app_mapa/pages/mapa.page.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    if(state == AppLifecycleState.resumed ){
      if(await Geolocator.isLocationServiceEnabled()){
        Navigator.pushReplacement(context, navegarfadeIn(context, MapaPage()));

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsYLocation(context),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return Center(
              child: Text(snapshot.data),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2,),
            );
          }
        },
      ),
    );
  }

  Future checkGpsYLocation(BuildContext context) async {

    final permisoGPS = await Permission.location.isGranted;
    final activoGPS  = await Geolocator.isLocationServiceEnabled();

    print(activoGPS);

    if(permisoGPS && activoGPS){
      Navigator.pushReplacement(context, navegarfadeIn(context, MapaPage()));
    }else if(!permisoGPS){
      Navigator.pushReplacement(context, navegarfadeIn(context, AccesoGpsPage()));
    }else{
      return 'Active el GPS';
    }

    // await Future.delayed(Duration(milliseconds: 1000));

  }
}