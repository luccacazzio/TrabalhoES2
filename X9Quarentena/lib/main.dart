import 'package:X9Quarentena/views/denuncia_view.dart';
import 'package:X9Quarentena/views/home_view.dart';
import 'package:X9Quarentena/views/final_view.dart';
import 'package:flutter/material.dart';


/***************************************************************
 * 
 *            Projeto de Engenharia de Softare.
 * 
 * Aplicativo de denúncia de aglomerações durante a quarentena.
 * 
 * Design Patterns: 
 *  Criacional: Factory Method em usuario_model.dart.
 *  Estrutural: Decorator em denuncia_model.dart.
 *  Comportamental: State em alguns lugares como denuncia_controller.dart.
 * 
 * Padrões Grasp: Alta coesão, Controlador e Criador.
 * 
 * Linguagem: Dart
 * 
 * Frameworks: Flutter e MobX
 * 
 * Bibliotecas: geolocator, image_picker, audio_recorder, path_provider, permission_handler e flutter_share_me.
 **************************************************************/


 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,   
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      routes: {
        '/': (context) => HomeView(),
        '/denunciaView': (context) => DenunciaView(),
        '/finalView': (context) => FinalView(),
      },

      initialRoute: '/',
    );
  }
}

