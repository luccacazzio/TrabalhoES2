class Usuario{
  String _nome;

  Usuario(this._nome);

  String getNome(){
    return _nome;
  }
}

class Fabrica{

  static getUsuario(nome){

    return new Usuario(nome);
  }

}