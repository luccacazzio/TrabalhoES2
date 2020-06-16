import 'package:X9Quarentena/models/midia_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:X9Quarentena/models/usuario_model.dart';

abstract class Denuncia{

  String tipo;
  Usuario usuario;
  Position posicao;
  DateTime horario;
  
  void confirmaDenuncia();

}