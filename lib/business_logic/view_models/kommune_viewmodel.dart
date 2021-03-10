import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class KommuneViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  List<KommunePresentation> _kommunePresentation;
  //TODO Temp variabel. Fjernes når logikken er flyttet til service
  List<KommunePresentation> _allKommunePresentation;

  List<KommunePresentation> get kommunePresentation => _kommunePresentation;

  void loadData() async {
    final kommuner = await _goosehuntService.getKommuner();
    _prepareKomunePresentation(kommuner);
    notifyListeners();
  }


  void _prepareKomunePresentation(List<Kommune> kommuner){
    List<KommunePresentation> list = [];
    for (Kommune kommune in kommuner) {
      var presentation = new KommunePresentation(kommune.navn, kommune.navn.toUpperCase());
      list.add(presentation);
    }
    _kommunePresentation = list;
    _allKommunePresentation = list;
  }

  void setKommune(int index) {
    //TODO set kommune
    // await _goosehuntService.registerHuntingday(huntingday);

  }

  //TODO søkelogikken skal ligge i servien
  void filterKommuner(String searchString) {
    var formattedString = searchString.toUpperCase();
    _kommunePresentation = _allKommunePresentation.where((kommune) => kommune.searchableName.contains(formattedString)).toList();
    notifyListeners();
  }
}

class KommunePresentation {
  final String navn;
  //TODO Temp variabel. Fjernes når logikken er flyttet til service
  final String searchableName;

  KommunePresentation(this.navn, this.searchableName);
}