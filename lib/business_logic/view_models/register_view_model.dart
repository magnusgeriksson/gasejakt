import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class RegisterViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  RegisterPresentation _registerPresentation;
  KommunePresentation _kommunePresentation;

  RegisterPresentation get registerPresentation => _registerPresentation;
  KommunePresentation get kommunePresentation => _kommunePresentation;

  void sendData(Huntingday huntingday) async {
    var res = await _goosehuntService.registerHuntingday(huntingday);

    notifyListeners();
  }

  Future<void> loadData() async {
    var hunter = await _goosehuntService.getHunter();
    _prepareRegisterPresentation(hunter);
    var kommune = await _goosehuntService.getSelectedKommune();
    _prepareKommunePresentation(kommune);
    notifyListeners();
  }


  void _prepareKommunePresentation(Kommune kommune){

    final kommunePresentationTemp = new KommunePresentation(kommune.navn);

    _kommunePresentation = kommunePresentationTemp;
  }

  void _prepareRegisterPresentation(Hunter hunter) {
    _registerPresentation = RegisterPresentation(hunter.hunterNumber);
  }
}

class RegisterPresentation {
  final String jegernummer;

  RegisterPresentation(this.jegernummer);
}

class KommunePresentation {
  final String navn;

  KommunePresentation(this.navn);
}