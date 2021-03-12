import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';
import 'package:intl/intl.dart';

class HistoryViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  List<HistoryPresentation> _historyPresentation;

  List<HistoryPresentation> get registerPresentation => _historyPresentation;

  Future<void> loadData() async {
    var huntingdays = await _goosehuntService.getRegisteredHuntingdays();

    _prepareRegisterPresentation(huntingdays);
    notifyListeners();
  }

  void _prepareRegisterPresentation(List<Huntingday> huntingdays) {
    List<HistoryPresentation> tempList = [];

    for (Huntingday huntingday in huntingdays) {
      tempList.add(HistoryPresentation(
          huntingday.jegerNumber,
          huntingday?.kommune?.navn,
          DateFormat('yyyy-MM-dd – kk:mm').format(huntingday.date).toString(),
          huntingday.antallJegere.toString(),
          gragas: huntingday.graGas.toString(),
          kanadaGas: huntingday.kanadaGas.toString(),
          kortnebbgas: huntingday.kortnebbGas.toString()));
    }

    _historyPresentation = tempList;
  }
}

//Alle felt som skal vises i UI
class HistoryPresentation {
  final String jegernummer;
  final String kommunenavn;
  final String date;
  final String antallJegere;
  final String gragas;
  final String kortnebbgas;
  final String kanadaGas;

  HistoryPresentation(
      this.jegernummer, this.kommunenavn, this.date, this.antallJegere,
      {this.gragas = "0", this.kortnebbgas = "0", this.kanadaGas = "0"});
}
