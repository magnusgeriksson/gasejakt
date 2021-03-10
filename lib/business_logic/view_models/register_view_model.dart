import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class RegisterViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  RegisterPresentation _registerPresentation;

  RegisterPresentation get registerPresentation => _registerPresentation;

  void sendData(Huntingday huntingday) async {
    var res = await _goosehuntService.registerHuntingday(huntingday);

    notifyListeners();
  }

  void getKommuner() async {

  }

  Future<void> loadData() async {
    var hunter = await _goosehuntService.getHunter();
    _prepareRegisterPresentation(hunter);

    notifyListeners();
  }

  void _prepareRegisterPresentation(Hunter hunter) {
    _registerPresentation = RegisterPresentation(hunter.hunterNumber);
  }
}

class RegisterPresentation {
  final String jegernummer;

  RegisterPresentation(this.jegernummer);
}
