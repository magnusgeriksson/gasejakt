import 'package:gasejakt/business_logic/models/kommune.dart';
import 'package:gasejakt/services/sted/sted_service.dart';

class StedServiceFake extends StedService {
  List<Kommune> kommunelist = [];

  StedServiceFake() {
    kommunelist.addAll(
        [new Kommune("0004", "Tuborg"), new Kommune("0005", "Trondheim")]);
  }

  @override
  Future<List<Kommune>> getKommuner() async {
    return kommunelist;
  }
}
