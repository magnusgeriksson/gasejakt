import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/storage/storage_service_implementation.dart';
import 'package:http/http.dart' as http;

import '../service_locator.dart';

class GoosehuntServiceFake implements GoosehuntService {
  final StorageServiceImpl _storageService =
      serviceLocator<StorageServiceImpl>();

  List<Kommune> kommunelist = [];
  List<Huntingday> registrerteJaktdager = [];

  GoosehuntServiceFake() {
    final baerum = new Kommune(1, 1, "Bærum");
    final sandefjord = new Kommune(2, 2, "Sandefjord");

    kommunelist.addAll([
      baerum,
      sandefjord,
      new Kommune(3, 3, "Tuborg"),
      new Kommune(0, 0, "Trondheim")
    ]);

    registrerteJaktdager.addAll([
      new Huntingday(
          hunter: DummyHunter.dummyHunter,
          antallJegere: 1,
          graGas: 2,
          kommunenr: 2),
      new Huntingday(
          hunter: DummyHunter.dummyHunter,
          antallJegere: 4,
          kanadaGas: 2,
          kortnebbGas: 1,
          kommunenr: 1)
    ]);
  }

  @override
  Future<http.Response> registerHuntingday(Huntingday huntingday) async {

    await _storageService.insertHuntingday(huntingday);

    // registrerteJaktdager.add(huntingday);


    return new http.Response("body", 200);
  }

  //Kun en hunter skal være lagret i basen
  @override
  Future<Hunter> getHunter() async {
    final hunters = await _storageService.getHunters();
    final hunter = hunters[0];

    return hunter == null ? new Hunter() : hunter;

    return DummyHunter.dummyHunter;
  }

  //Register, save or insert. Bestem navngivning
  @override
  Future<bool> registerHunter(Hunter hunter) async {
    //TODO Handle error
    await _storageService
        .insertHunter(hunter)
        .catchError((error, stackTrace) => {});
    return true;
  }

  @override
  Future<List<Kommune>> getKommuner() async {
    return kommunelist;
  }

  //TODO Gjøres i db
  @override
  void setSelectedKommune(int kommunenummer) {
    for (Kommune pres in kommunelist) {
      pres.isSelected = pres.nummer == kommunenummer;
    }
  }

  @override
  Huntingday getHuntingDay() {
    var huntingDay = new Huntingday();
    huntingDay.hunter = DummyHunter.dummyHunter;

    return huntingDay;
  }

  @override
  Future<Kommune> getSelectedKommune() async {
    var selectedKommune =
        kommunelist?.firstWhere((kommune) => kommune.isSelected, orElse: () => null) ?? null;
    return selectedKommune;
  }

  @override
  Future<Kommune> getKommune(int code) async {
    if (code == 7071) {
      return Kommune(0, 7071, "Trondheim");
    } else
      return Kommune(1, 0000, "Ukjent");
  }

  @override
  Future<List<Huntingday>> getRegisteredHuntingdays() async {
    var huntingdays = await _storageService.getHuntingdays();


    // return registrerteJaktdager;
    return huntingdays;
  }
}
