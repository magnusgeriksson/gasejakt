import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:http/http.dart' as http;

class GoosehuntServiceFake implements GoosehuntService {
  @override
  Future<http.Response> registerHuntingday(Huntingday huntingday) async {
    return new http.Response("body", 200);
  }

  @override
  Future<Hunter> getHunter() async {
    return DummyHunter.dummyHunter;
  }

  @override
  Future<void> registerHunter() async {
    return;
  }
}
