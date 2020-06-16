import 'package:flutter/material.dart';
import 'package:X9Quarentena/controllers/final_controller.dart';
import 'package:X9Quarentena/models/denuncia_model.dart';
import 'package:X9Quarentena/interfaces/denuncia_interface.dart';
import 'package:X9Quarentena/models/midia_model.dart';

class FinalView extends StatefulWidget {
  @override
  _FinalViewState createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  FinalController _finalController;
  var _denuncia;

  @override
  void initState() {
    _finalController = FinalController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _denuncia = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sua Denuncia'),
      ),

      body: Center(
        child: Column(
          children: <Widget>[

            SizedBox(height: 20,),

            Text('Denúncia realizada por ' + _denuncia.usuario.getNome() + '\n\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),

            Text('Tipo de evento: ' + _denuncia.tipo + '\n\n'),

            Text('Localização:\n'),
            Text('Latitude: ${_denuncia.posicao.latitude}\nLongitude: ${_denuncia.posicao.longitude}' +  '\n\n'),

            Text('Horário: ${_denuncia.horario.hour}:' + (_denuncia.horario.minute < 10 ? '0' : '') +_denuncia.horario.minute.toString() + '\n\n'),

            Text((_denuncia.file != null ? 'Áudio salvo.' : 'Sem áudio acoplado.') + '\n\n'), 

            Text('Denuncia realizada com sucesso.\n\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.green)),
          
            Text('Compartilhar:\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              FlatButton(onPressed:(){ _finalController.compartilharTwitter('Oi');}, child: Text('Twitter'), color: Colors.blue[200],),
              Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
              FlatButton(onPressed: (){_finalController.compartilharZapZap('Oi');}, child: Text('Whatsapp'), color: Colors.green,),
            ],),
          ],
        ),
      )
    );
  }
}

