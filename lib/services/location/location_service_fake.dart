import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/location/location_service.dart';

class LocationServiceFake extends LocationService {
  List<Kommune> kommunelist = [];

  LocationServiceFake() {
    kommunelist.addAll(
        [new Kommune("0004", "Tuborg"), new Kommune("0005", "Trondheim")]);
  }

  @override
  Future<List<Kommune>> getKommuner() async {
    return kommunelist;
  }

  @override
  Future<Kommune> getSelectedKommune() async {
    return kommunelist[0];
  }

  @override
  void setSelectedKommune(String kommunenummer) {
    for (Kommune pres in kommunelist) {
      pres.isSelected = pres.id == kommunenummer;
    }
  }
}
