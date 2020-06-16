import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:X9Quarentena/models/usuario_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final GlobalKey<FormState> _formkey = GlobalKey();
  Usuario _usuario;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('X9Quarentena')),
      ),

      body: Form(
        key: _formkey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              TextFormField( 
                keyboardType: TextInputType.text,
                onSaved: (input){
                  if(input.isEmpty) input = 'Anônimo';
                  setState(() {
                    _usuario = Fabrica.getUsuario(input);
                  });
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText:('Seu nome se quiser se identificar'),
                ),
                
              ),
              SizedBox(height: 40,),
              FlatButton(
                padding: EdgeInsets.all(10),
                onPressed: (){
                  final formState = _formkey.currentState;
                  formState.save();
                  Navigator.pushNamed(context, '/denunciaView', arguments: _usuario);
                }, 
                child: Text('Quero ser um X9', style: TextStyle(fontSize: 30),),
                color: Colors.yellow,
              ),
            ],
          ),
        ),
      )
    );
  }
}

