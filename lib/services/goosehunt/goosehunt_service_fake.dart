import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:http/http.dart' as http;

class GoosehuntServiceFake implements GoosehuntService {
//Dummykommuner
//   var kommune2 = new Kommune(1, 1, "Bærum");
//   var kommune3 = new Kommune(2, 2, "Sandefjord");
//   var kommune4 = new Kommune(3, 3, "Tuborg");
//   var kommune5 = new Kommune(0, 0, "Trondheim");

  List<Kommune> kommunelist = [];
  List<Huntingday> registrerteJaktdager = [];

  GoosehuntServiceFake() {
    final baerum = new Kommune("0001", "Bærum");
    final sandefjord = new Kommune("0002", "Sandefjord");

    kommunelist.addAll([
      baerum,
      sandefjord,
      new Kommune("0004", "Tuborg"),
      new Kommune("0005", "Trondheim")
    ]);

    registrerteJaktdager.addAll([
      new Huntingday(
          jegerNumber: DummyHunter.dummyHunter.hunterNumber,
          antallJegere: 1,
          graGas: 2,
          kommune: baerum),
      new Huntingday(
          jegerNumber: DummyHunter.dummyHunter.hunterNumber,
          antallJegere: 4,
          kanadaGas: 2,
          kortnebbGas: 1,
          kommune: sandefjord)
    ]);
  }

  @override
  Future<http.Response> registerHuntingday(Huntingday huntingday) async {
    registrerteJaktdager.add(huntingday);

    return new http.Response("body", 200);
  }

  @override
  Future<Hunter> getHunter() async {
    return DummyHunter.dummyHunter;
  }

  @override
  Future<bool> registerHunter(Hunter hunter) async {
    return true;
  }

  @override
  Future<List<Kommune>> getKommuner() async {
    return kommunelist;
  }

  //TODO Gjøres i db
  @override
  void setSelectedKommune(String kommunenummer) {
    for (Kommune pres in kommunelist) {
      pres.isSelected = pres.id == kommunenummer;
    }
  }

  @override
  Huntingday getHuntingDay() {
    var huntingDay = new Huntingday();
    huntingDay.jegerNumber = DummyHunter.dummyHunter.hunterNumber;

    return huntingDay;
  }

  @override
  Future<Kommune> getSelectedKommune() async {
    var selectedKommune = kommunelist
            ?.firstWhere((kommune) => kommune.isSelected, orElse: () => null) ??
        null;
    return selectedKommune;
  }

  //TODO: Bytt til getPoststed!
  @override
  Future<Kommune> getKommune(String code) async {
    if (code == "7071") {
      return Kommune("7071", "Trondheim");
    } else
      return Kommune("0000", "Ukjent");
  }

  @override
  Future<List<Huntingday>> getRegisteredHuntingdays() async {
    return registrerteJaktdager;
  }
}
