import 'package:gasejakt/business_logic/view_models/profile_viewmodel.dart';
import 'package:gasejakt/business_logic/view_models/register_viewmodel.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service_fake.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  //Services
  serviceLocator
      .registerLazySingleton<GoosehuntService>(() => GoosehuntServiceFake());

  //Viewmodels
  serviceLocator
      .registerLazySingleton<RegisterViewModel>(() => RegisterViewModel());
  serviceLocator
      .registerLazySingleton<ProfileViewmodel>(() => ProfileViewmodel());
}
