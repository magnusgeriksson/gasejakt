import 'package:gasejakt/business_logic/models/kommune.dart';

//For kommuner og postnr/poststed
abstract class LocationService {
  Future<List<Kommune>> getKommuner();
  Future<Kommune> getSelectedKommune();
  void setSelectedKommune(String kommunenummer);
}
