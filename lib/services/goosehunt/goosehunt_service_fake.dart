import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:http/http.dart' as http;

class GoosehuntServiceFake implements GoosehuntService {
  var kommune2 = new Kommune(1, 1, "Bærum");
  var kommune3 = new Kommune(2, 2, "Sandefjord");
  var kommune4 = new Kommune(3, 3, "Tuborg");
  var kommune5 = new Kommune(0, 0, "Trondheim");
  List<Kommune> kommunelist = [];

  GoosehuntServiceFake() {
    kommunelist.add(kommune2);
    kommunelist.add(kommune3);
    kommunelist.add(kommune4);
    kommunelist.add(kommune5);
  }

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
    return kommunelist;
  }

  @override
  void setSelectedKommune(int kommunenummer) {
    for (Kommune pres in kommunelist) {
      pres.isSelected = pres.nummer == kommunenummer;
    }
  }

  @override
  Huntingday getHuntingDay() {
    var huntingDay = new Huntingday();
    huntingDay.jegerNumber = DummyHunter.dummyHunter.hunterNumber;
    // huntingDay.kommunenummer = 2;

    return huntingDay;
  }

  @override
  Future<Kommune> getSelectedKommune() async {
    var selectedKommune =
        kommunelist?.firstWhere((kommune) => kommune.isSelected, orElse: () => null) ?? null;
    return selectedKommune;
  }
}
