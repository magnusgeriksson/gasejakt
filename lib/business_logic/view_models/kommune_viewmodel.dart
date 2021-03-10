import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class KommuneViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  KommunePresentation _selectedKommune;

  KommunePresentation get selectedKommune => _selectedKommune;

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
      if (kommune.isSelected) {
        _selectedKommune = new KommunePresentation(kommune.navn,
            kommune.navn.toUpperCase(), kommune.isSelected, kommune.nummer);
      }

      var presentation = new KommunePresentation(kommune.navn,
          kommune.navn.toUpperCase(), kommune.isSelected, kommune.nummer);
      list.add(presentation);
    }
    _kommunePresentation = list;
    _allKommunePresentation = list;
  }

  void setKommune(int index) {
    _goosehuntService.setSelectedKommune(_selectedKommune.kommunenummer);

    //TODO TEMP set selected kommune. Dette vil bare fungere i UI, valgt kommune blir ikke med videre.
    for(KommunePresentation pres in _allKommunePresentation){
      pres.isSelected = false;
    }
    for(KommunePresentation pres in _kommunePresentation){
      pres.isSelected = pres == _kommunePresentation[index];
    }

    _selectedKommune = _kommunePresentation[index];

    notifyListeners();
  }

  //TODO søkelogikken skal ligge i servicen
  void filterKommuner(String searchString) {
    var formattedString = searchString.toUpperCase();
    _kommunePresentation = _allKommunePresentation.where((kommune) => kommune.searchableName.contains(formattedString)).toList();
    notifyListeners();
  }
}

class KommunePresentation {
  final String navn;
  final int kommunenummer;

  //TODO Temp variabel. Fjernes når logikken er flyttet til service
  final String searchableName;
  bool isSelected;

  KommunePresentation(
      this.navn, this.searchableName, this.isSelected, this.kommunenummer);
}