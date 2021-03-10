import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';

class GoosehuntServiceFake implements GoosehuntService {
  @override
  Future<void> registerHuntingday() async {
    return;
  }

  @override
  Future<Hunter> getHunter() async {
    return DummyHunter.dummyHunter;
  }

  @override
  Future<bool> registerHunter(Hunter hunter) async {
    print(hunter.toString() + "is being saved");
    return true;
  }
}
