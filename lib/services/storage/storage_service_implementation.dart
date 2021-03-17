import 'package:flutter/widgets.dart';
import 'package:gasejakt/business_logic/models/hunter.dart';
import 'package:gasejakt/business_logic/models/huntingday.dart';
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
    String huntindayDbScript = CreateScriptHuntingday.script;

    String path = join(await getDatabasesPath(), _databasename);
    return await openDatabase(path, version: _version, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(script);
      await db.execute(huntindayDbScript);
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

    //Ikke fjern. For testing
    // var map = DummyHunter.dummyHunter.toMap();
    var map = hunter.toMap();

    var row = await db
        .insert(
      'hunter_table',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .catchError((error, stack) {
      return Future.value(null);
    });

    return Future.value();
  }

  @override
  Future<void> insertHuntingday(Huntingday huntingday) async {
    final Database db = await database;

    //Ikke fjern. For testing
    // var map = DummyHunter.dummyHunter.toMap();
    var map = huntingday.toMap();

    var row = await db
        .insert(
      'huntingday',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    )
        .catchError((error, stack) {
      return Future.value(null);
    });

    return Future.value();
  }

  @override
  Future<List<Huntingday>> getHuntingdays() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('huntingday');

    final hunter = await getHunters();

    return List.generate(maps.length, (i) {
      return Huntingday(
          id: maps[i]['id'],
          //TODO INCLUDE hunter
          hunter: hunter[0],
          date: DateTime.tryParse(maps[i]['date']),
          antallJegere: maps[i]['antallJegere'],
          graGas: maps[i]['graGas'],
          kanadaGas: maps[i]['kanadaGas'],
          kortnebbGas: maps[i]['kortnebbGas'],
          //TODO include kommune
          kommunenr:  maps[i]['kommunenr']);
    });
  }

  @override
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
