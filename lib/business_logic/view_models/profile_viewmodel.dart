import 'package:flutter/material.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/service_locator.dart';

class ProfileViewmodel extends ChangeNotifier {
  final GoosehuntService _goosehuntService = serviceLocator<GoosehuntService>();

  Hunter _hunter = Hunter();

  Future<void> loadData() async {
    await _loadHunter();
    print("Hunter hentet i loadData!");
    notifyListeners();
  }

  Future<void> _loadHunter() async {
    _hunter = await _goosehuntService.getHunter();
  }

  //Public
  Hunter get hunter {
    return _hunter;
  }

  void setFirstName(String name) {
    _hunter.firstName = name;
    notifyListeners();
  }

  void setLastName(String name) {
    _hunter.lastName = name;
    notifyListeners();
  }

  void setAddress(String address) {
    _hunter.address = address;
    notifyListeners();
  }

  void setPostalCode(String code) {
    _hunter.postalCode = code;
    notifyListeners();
  }

  void setPostalAddress(String address) {
    _hunter.postalAddress = address;
    notifyListeners();
  }

  void setPhoneNumber(String number) {
    _hunter.phoneNumber = number;
    notifyListeners();
  }

  void setMailAddress(String mail) {
    _hunter.mailAddress = mail;
    notifyListeners();
  }

  void setHuntingNumber(String number) {
    _hunter.hunterNumber = number;
    notifyListeners();
  }

  //Returns true if saving is ok.
  Future<bool> saveHunter() {
    return _goosehuntService.registerHunter(_hunter);
  }
}
