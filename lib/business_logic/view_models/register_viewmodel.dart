import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class RegisterViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  void sendData(Huntingday huntingday) async {

    await _goosehuntService.registerHuntingday(huntingday);

  }

  String testString = "Registrer";
}
