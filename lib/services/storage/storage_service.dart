import 'package:gasejakt/business_logic/models/hunter.dart';

abstract class StorageService {
  Future<Hunter> getSavedHunter();
  Future<void> insertHunter(Hunter hunter);
  Future<List<Hunter>> getHunters();
}
