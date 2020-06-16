import 'package:mobx/mobx.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:permission_handler/permission_handler.dart';

class FinalController = _FinalControllerBase with Store;

abstract class _FinalControllerBase with Store{

  @action
  compartilharTwitter(msg)async {
    var response = await FlutterShareMe().shareToTwitter(
      url:'' ,msg: msg);
    if (response == 'success') {
      print('navigate success');
    }else print('nada');
  }

  @action
  compartilharZapZap(msg)async {
    var response = await FlutterShareMe().shareToWhatsApp(
      msg: msg);
    if (response == 'success') {
      print('navigate success');
    }else print('Qualquer outra coisa');
  }
}