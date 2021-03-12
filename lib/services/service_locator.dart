import 'package:gasejakt/business_logic/view_models/history_viewmodel.dart';
import 'package:gasejakt/business_logic/view_models/kommune_viewmodel.dart';
import 'package:gasejakt/business_logic/view_models/profile_viewmodel.dart';
import 'package:gasejakt/business_logic/view_models/register_view_model.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service.dart';
import 'package:gasejakt/services/goosehunt/goosehunt_service_fake.dart';
import 'package:gasejakt/services/storage/storage_service_implementation.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  //Services
  serviceLocator
      .registerLazySingleton<GoosehuntService>(() => GoosehuntServiceFake());

  serviceLocator.registerLazySingletonAsync(
      () async => StorageServiceImpl().initDatabase());

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
/**
 * https://pub.dev/packages/get_it
 * https://educity.app/flutter/the-right-way-to-use-sqlite-in-flutter-apps-using-sqflite-package-with-examples
 * https://suragch.medium.com/simple-sqflite-database-example-in-flutter-e56a5aaa3f91
 * https://github.com/tekartik/sqflite/blob/master/sqflite/doc/opening_db.md
 */
