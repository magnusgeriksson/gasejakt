import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class RegisterViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  RegisterPresentation _registerPresentation;
  List<KommunePresentation> _kommunePresentation;

  RegisterPresentation get registerPresentation => _registerPresentation;
  List<KommunePresentation> get kommunePresentation => _kommunePresentation;

  void sendData(Huntingday huntingday) async {
    var res = await _goosehuntService.registerHuntingday(huntingday);

    notifyListeners();
  }

  Future<void> loadData() async {
    var hunter = await _goosehuntService.getHunter();
    _prepareRegisterPresentation(hunter);
    var kommuner = await _goosehuntService.getKommuner();
    _prepareKomunePresentation(kommuner);
    notifyListeners();
  }


  void _prepareKomunePresentation(List<Kommune> kommuner){
    List<KommunePresentation> list = [];
    for (Kommune kommune in kommuner) {
      // String code = rate.quoteCurrency;
      // bool isFavorite = _getFavoriteStatus(code);
      var presentation = new KommunePresentation(kommune.navn);
      list.add(presentation);
    }
    _kommunePresentation = list;
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