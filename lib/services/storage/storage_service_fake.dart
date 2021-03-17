import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
import 'package:gasejakt/services/storage/storage_service.dart';

class StorageServiceFake implements StorageService {
  @override
  Future<Hunter> getSavedHunter() async {
    return DummyHunter.dummyHunter;
  }

  @override
  Future<void> saveHunter() async {
    return;
  }

  @override
  Future<void> insertHunter(Hunter hunter) {
    // TODO: implement insertHunter
    throw UnimplementedError();
  }

  @override
  Future<List<Hunter>> getHunters() {
    // TODO: implement getHunters
    throw UnimplementedError();
  }

  @override
  Future<List<Huntingday>> getHuntingdays() {
    // TODO: implement getHuntingdays
    throw UnimplementedError();
  }

  @override
  Future<void> insertHuntingday(Huntingday huntingday) {
    // TODO: implement insertHuntingday
    throw UnimplementedError();
  }
}
