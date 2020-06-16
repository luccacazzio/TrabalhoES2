import 'dart:io' as io;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
import 'package:X9Quarentena/models/denuncia_model.dart';
import 'package:X9Quarentena/interfaces/denuncia_interface.dart';
import 'dart:math';
import 'package:audio_recorder/audio_recorder.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:X9Quarentena/models/midia_model.dart';
import 'package:X9Quarentena/models/usuario_model.dart';

class DenunciaController = _DenunciaControllerBase with Store;

abstract class _DenunciaControllerBase with Store{

  Recording _recording = new Recording();
  bool _isRecording = false;
  File _file;
  Midia _midia;

  @action
  denunciar(BuildContext context, String tipo, Usuario usuario) async{

    Denuncia _denuncia;

    try{

      //Pegar a localização
      Geolocator _geolocator = Geolocator()..forceAndroidLocationManager = true;
      GeolocationStatus _geolocationStatus  = await _geolocator.checkGeolocationPermissionStatus();
      
      if(_geolocationStatus != GeolocationStatus.disabled){
        
        Position _position = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
        //Pegar data e hora
        DateTime _horario = DateTime.now();
      
        _denuncia = DenunciaBase(tipo, usuario, _position, _horario);

        //Pegar video e audio se tiver
        if(_file != null){
          _midia = Midia(_denuncia, _file);
          _midia.confirmaDenuncia();
          //Muda de tela
          Navigator.popAndPushNamed(context, '/finalView', arguments: _midia);

        }else{
          _denuncia.confirmaDenuncia();
          //Muda de tela
          Navigator.popAndPushNamed(context, '/finalView', arguments: _denuncia);
        }

      }else throw Exception;

    }catch(e){

      await showDialog(context: context, builder: (context){
        return AlertDialog(title: Text('Localização desativada', style: TextStyle(fontSize: 18),), actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Text('ok', style: TextStyle(fontSize: 18),)
          ),
        ],);
      });
      print(e);
    }

  }

  @action
  Future<void> gravarAudio(BuildContext context) async {
    
    showModalBottomSheet(context: context, builder: (context){

      return StatefulBuilder(

        builder: (BuildContext context, StateSetter setState2){

          return Column(children: <Widget>[
            
            Row(mainAxisAlignment: MainAxisAlignment.center ,children: <Widget>[

              FlatButton(
                onPressed: _isRecording ? null : ()async{

                  try{

                    if(await Permission.microphone.request().isGranted && await Permission.storage.request().isGranted){
                      
                      await AudioRecorder.start(audioOutputFormat: AudioOutputFormat.AAC);
                    }
                    bool isRecording = await AudioRecorder.isRecording;

                    setState2((){
                      _recording = new Recording(duration: new Duration(), path: "");
                      _isRecording = isRecording;
                    });
                  
                  }catch(e){
                    print(e);
                  }

                }, 
                child: Text('Começar'),
                color: _isRecording ? Colors.white : Colors.green,
              ),

              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),

              FlatButton(
                onPressed: _isRecording ? (){_stop(context, setState2);} : null, 
                child: Text('Parar'),
                color: _isRecording ? Colors.red : Colors.white,
              ),

            ],),

          ],);
        }
      );
      
    });
  }

  _stop(context, setState2) async{

    var recording = await AudioRecorder.stop();
    bool isRecording = await AudioRecorder.isRecording;
    File file = LocalFileSystem().file(recording.path);
    setState2(() {
      _recording = recording;
      _isRecording = isRecording;
      _file = file;
    });

    await showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Audio salvo.', style: TextStyle(fontSize: 18),), actions: <Widget>[
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          child: Text('ok', style: TextStyle(fontSize: 18),)
        ),
      ],);
    });

  }

}