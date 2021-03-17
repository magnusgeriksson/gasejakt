import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';

abstract class StorageService {
  Future<Hunter> getSavedHunter();
  Future<void> insertHunter(Hunter hunter);
  Future<List<Hunter>> getHunters();
  Future<List<Huntingday>> getHuntingdays();
  Future<void> insertHuntingday(Huntingday huntingday);
}
