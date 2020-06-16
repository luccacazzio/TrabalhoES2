import 'package:X9Quarentena/models/denuncia_model.dart';
import 'package:X9Quarentena/interfaces/denuncia_interface.dart';
import 'package:file/file.dart';

class Midia extends DenunciaDecorator{

  File file;

  Midia(Denuncia denuncia, this.file) : super(denuncia);

  @override
  void confirmaDenuncia() {
    super.confirmaDenuncia();
    print(file);
  }
  
}