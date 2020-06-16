import 'package:X9Quarentena/controllers/denuncia_controller.dart';
import 'package:flutter/material.dart';
import 'package:X9Quarentena/models/usuario_model.dart';

class DenunciaView extends StatefulWidget {
  @override
  _DenunciaViewState createState() => _DenunciaViewState();
}

class _DenunciaViewState extends State<DenunciaView> {

  DenunciaController _denunciaController;
  final GlobalKey<FormState> _formkey = GlobalKey();
  String _tipo;
  Usuario _usuario;

  @override
  void initState() {
    _denunciaController = DenunciaController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    _usuario = ModalRoute.of(context).settings.arguments;

    return Form(
      key: _formkey,
      child:Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 70),

          child: Column(children: <Widget>[

            Text('Tipo de aglomeração:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            
            TextFormField( 
              keyboardType: TextInputType.text,
              validator: (input) {
                if(input.isEmpty){
                  return 'Por favor, digite um tipo.';
                }
              },
              onSaved: (input){
                setState(() {
                  _tipo = input;
                });
              },
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText:('Ex.: (festinha, reunião, show, etc.)'),
              ),
            ),

            SizedBox(height: 30,),

            Text('Opcionais: '),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[

              Icon(Icons.audiotrack),

              Text('Áudio: ', style: TextStyle(fontSize: 18),),

              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

              FlatButton(
                onPressed: (){
                  _denunciaController.gravarAudio(context);
                }, 
                child: Text('Gravar um áudio'), 
                color: Colors.yellow,
              ),

            ],),

            SizedBox(height: 10,),

            FlatButton(
              onPressed: (){
                final formState = _formkey.currentState;
                if(formState.validate()){
                  formState.save();
                  _denunciaController.denunciar(context, _tipo, _usuario);
                }
              }, 
              child: Text('Confirmar Denuncia', style: TextStyle(color: Colors.white),), color: Colors.red,
            ),

          ]),
        ),
      ),
    );

  }
}