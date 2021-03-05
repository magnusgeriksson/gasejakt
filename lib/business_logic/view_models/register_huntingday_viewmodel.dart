import 'package:flutter/material.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class RegisterHuntingdayViewModel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  String testString = "Registrer";
}
