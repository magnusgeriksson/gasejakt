import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:http/http.dart' as http;

abstract class GoosehuntService {
  Future<List<Huntingday>> getRegisteredHuntingdays();
  Future<http.Response> registerHuntingday(Huntingday huntingday);
  Future<Hunter> getHunter();
  Future<bool> registerHunter(Hunter hunter);
  // Future<List<Kommune>> getKommuner();
  Future<Kommune> getKommune(String code);
  Future<Kommune> getSelectedKommune();
  void setSelectedKommune(String kommunenummer);
  Huntingday getHuntingDay();
}
