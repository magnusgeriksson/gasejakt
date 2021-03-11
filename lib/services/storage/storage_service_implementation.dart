import 'package:flutter/widgets.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/services/storage/storage_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageServiceImpl implements StorageService {
  static final _databasename = 'gasejakt_database.db';
  static final _version = 1;

  String path;
  StorageServiceImpl() {
    WidgetsFlutterBinding.ensureInitialized();
  }
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  //Brukes i Service locator.
  initDatabase() async {
    String path = join(await getDatabasesPath(), _databasename);
    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(CreateScriptHunter.script);
  }

  @override
  Future<Hunter> getSavedHunter() {
    // TODO: implement getSavedHunter
    throw UnimplementedError();
  }

  @override
  void saveHunter() {
    // TODO: implement saveHunter
  }
}
