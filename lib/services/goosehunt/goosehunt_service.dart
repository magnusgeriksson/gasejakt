import 'package:gasejakt/business_logic/models/hunter.dart';

abstract class GoosehuntService {
  void registerHuntingday();
  Future<Hunter> getHunter();
  void registerHunter();
}
