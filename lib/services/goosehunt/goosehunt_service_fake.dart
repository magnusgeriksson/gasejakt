import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
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

  @override
  Future<List<Kommune>> getKommuner() async {
    List<Kommune> kommunelist = [];

    var kommune1 = new Kommune(0, 0, "Trondheim");
    var kommune2 = new Kommune(1, 1, "Bærum");
    var kommune3 = new Kommune(2, 2, "Sandefjord");

    kommunelist.add(kommune1);
    kommunelist.add(kommune2);
    kommunelist.add(kommune3);

    return kommunelist;
  }
}
