import 'package:gasejakt/business_logic/view_models/history_viewmodel.dart';
import 'package:gasejakt/business_logic/view_models/kommune_viewmodel.dart';
import 'package:gasejakt/business_logic/view_models/profile_viewmodel.dart';
import 'package:gasejakt/business_logic/view_models/register_view_model.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service_fake.dart';
import 'package:gasejakt/services/sted/sted_service.dart';
import 'package:gasejakt/services/sted/sted_service_fake.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  //Services
  serviceLocator
      .registerLazySingleton<GoosehuntService>(() => GoosehuntServiceFake());
  serviceLocator.registerLazySingleton<StedService>(() => StedServiceFake());

  //Viewmodels
  serviceLocator
      .registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());
  serviceLocator
      .registerLazySingleton<KommuneViewModel>(() => KommuneViewModel());
  serviceLocator
      .registerLazySingleton<ProfileViewmodel>(() => ProfileViewmodel());
  serviceLocator
      .registerLazySingleton<HistoryViewModel>(() => HistoryViewModel());
}
