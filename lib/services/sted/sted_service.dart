import 'package:gasejakt/business_logic/models/kommune.dart';

//For kommuner og postnr/poststed
abstract class StedService {
  Future<List<Kommune>> getKommuner();
}
