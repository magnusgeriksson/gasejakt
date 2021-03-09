import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';

abstract class GoosehuntService {
  Future<void> registerHuntingday(Huntingday huntingday);
  Future<Hunter> getHunter();
  void registerHunter();
}
