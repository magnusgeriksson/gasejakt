import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:http/http.dart' as http;

abstract class GoosehuntService {
  Future<http.Response> registerHuntingday(Huntingday huntingday);
  Future<Hunter> getHunter();
  void registerHunter();
}
