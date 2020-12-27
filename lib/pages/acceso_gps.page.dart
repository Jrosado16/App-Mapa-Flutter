import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class AccesoGpsPage extends StatefulWidget {
  const AccesoGpsPage({Key key}) : super(key: key);

  @override
  _AccesoGpsPageState createState() => _AccesoGpsPageState();
}

class _AccesoGpsPageState extends State<AccesoGpsPage> with WidgetsBindingObserver {

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
      if(await Permission.location.isGranted){
        Navigator.pushReplacementNamed(context, '/loading');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Activar GPS para usar esta aplicacion'),
            FlatButton(
              child: Text('Activar GPS'),
              textColor: Colors.white,
              color: Colors.black,
              shape: StadiumBorder(),
              onPressed: ()async {

                final status = await Permission.location.request();
                accesoGPS(status);

              },
            )
          ],
        ),
      ),
    );
  }

  void accesoGPS(PermissionStatus status){
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, '/mapa');
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
        break;
    }
  }
}