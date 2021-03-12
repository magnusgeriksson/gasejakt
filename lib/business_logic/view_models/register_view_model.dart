import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class RegisterViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  RegisterPresentation _registerPresentation;

  RegisterPresentation get registerPresentation => _registerPresentation;

  void sendData(String gragas, String kortnebbgas, String kandagas, String antalljegere) async {

    var kommune = await _goosehuntService.getSelectedKommune();

    var huntingday = new Huntingday(
      jegerNumber: registerPresentation.jegernummer,
      kommune: kommune,
      graGas: int.tryParse(gragas),
      kanadaGas: int.tryParse(kandagas),
      kortnebbGas: int.tryParse(kortnebbgas),
      antallJegere: int.tryParse(antalljegere)
    );

    var res = await _goosehuntService.registerHuntingday(huntingday);

    notifyListeners();
  }

  Future<void> loadData() async {
    var hunter = await _goosehuntService.getHunter();
    var kommune = await _goosehuntService.getSelectedKommune();

    _prepareRegisterPresentation(hunter, kommune);
    notifyListeners();
  }

  void _prepareRegisterPresentation(Hunter hunter, Kommune kommune) {
    _registerPresentation = RegisterPresentation(hunter.hunterNumber, kommune?.navn ?? "Velg kommune");
  }
}

//Alle felt som skal vises i UI
class RegisterPresentation {
  final String jegernummer;
  final String kommunenavn;

  RegisterPresentation(this.jegernummer, this.kommunenavn);
}