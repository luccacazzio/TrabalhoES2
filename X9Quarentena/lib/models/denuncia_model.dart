import 'package:X9Quarentena/interfaces/denuncia_interface.dart';
import 'package:X9Quarentena/models/midia_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:file/file.dart';
import 'package:X9Quarentena/models/usuario_model.dart';

class DenunciaBase implements Denuncia{

  @override
  DateTime horario;

  @override
  Usuario usuario;

  @override
  Position posicao;

  @override
  String tipo;

  File file;

  DenunciaBase(this.tipo, this.usuario, this.posicao, this.horario);

  @override
  void confirmaDenuncia(){
    print(tipo);
    print(horario);
    print(usuario);
    print(posicao);
  }

}

class DenunciaDecorator implements Denuncia{

  Denuncia _denuncia;

  DenunciaDecorator(Denuncia denuncia){
    _denuncia = denuncia;
    tipo = denuncia.tipo;
    horario = denuncia.horario;
    posicao = denuncia.posicao;
    usuario = denuncia.usuario;
  }
  
  @override
  void confirmaDenuncia() {
    this._denuncia.confirmaDenuncia();
  }

  @override
  DateTime horario;

  @override
  Usuario usuario;

  @override
  Position posicao;

  @override
  String tipo;

}