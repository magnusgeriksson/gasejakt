import 'package:flutter/widgets.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/services/storage/storage_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class StorageServiceImpl implements StorageService {
  static final _databasename = 'gasejakt_database.db';
  static final _version = 1;
  static Database _database;
  String path;

  StorageServiceImpl() {
    WidgetsFlutterBinding.ensureInitialized();
  }

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    String script = CreateScriptHunter.script;

    String path = join(await getDatabasesPath(), _databasename);
    return await openDatabase(path, version: _version, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(script);
    });
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
  // Define a function that inserts dogs into the database
  Future<void> insertHunter(Hunter hunter) async {
    final Database db = await database;

    var map = DummyHunter.dummyHunter.toMap();

    var row = await db.insert(
      'hunter_table',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Hunter>> getHunters() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('hunter_table');

    return List.generate(maps.length, (i) {
      return Hunter(
          id: maps[i]['id'],
          hunterNumber: maps[i]['hunterNumber'],
          firstName: maps[i]['firstName'],
          address: maps[i]['address'],
          postalCode: maps[i]['postalCode'],
          postalAddress: maps[i]['postalAddress'],
          phoneNumber: maps[i]['phoneNumber'],
          mailAddress: maps[i]['mailAddress']);
    });
  }
}
