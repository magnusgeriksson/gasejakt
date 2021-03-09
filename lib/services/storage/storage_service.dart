import 'package:gasejakt/business_logic/models/hunter.dart';

abstract class StorageService {
  Future<Hunter> getSavedHunter();
  void saveHunter();
}
