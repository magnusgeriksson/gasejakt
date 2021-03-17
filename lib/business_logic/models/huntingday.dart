import 'package:gasejakt/business_logic/models/hunter.dart';

/*
Burde jaktdag kun ha referanse til kommune nr og jegernr eller hele objektet?

 */

class Huntingday {
  int id;

  //[Range(1, 999999)]
  Hunter hunter;

  // String jegerNumber;
  // String location;
  DateTime date;

  //[Range(101, 9999, ErrorMessage = "{0} must be between 101 and 9999")]
  int kommunenr;

  //Hente kommune fra kommunenr eller lagre kommunenavnet på objektet?
  // String kommunenavn;
  // Kommune kommune;

  //[Range(1, 99, ErrorMessage = "{0} must be between 1 and 100")]
  int antallJegere;
  int graGas;
  int kanadaGas;
  int kortnebbGas;

  Huntingday(
      {this.id,
      this.hunter,
      // this.location = "",
      this.antallJegere = 0,
      this.graGas = 0,
      this.kommunenr,
      this.kanadaGas = 0,
      this.kortnebbGas = 0,
      this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hunterNumber': hunter.hunterNumber,
      // 'location': location,
      'date': date.toString(),
      'kommunenr': kommunenr,
      'antallJegere': antallJegere,
      'graGas': graGas,
      'kanadaGas': kanadaGas,
      'kortnebbGas': kortnebbGas,
    };
  }
}

extension CreateScriptHuntingday on Huntingday {
  static final tableName = "huntingday";
  static final colId = "id";
  static final colDate = "date";
  static final colKommunenr = "kommunenr";
  static final colHunterNumber = "hunterNumber";
  static final colAntallJegere = "antallJegere";
  static final colgraGas = "graGas";
  static final colkanadaGas = "kanadaGas";
  static final colkortnebbGas = "kortnebbGas";

  static var script =
      '''CREATE TABLE $tableName($colId INTEGER PRIMARY KEY, $colHunterNumber TEXT, $colDate TEXT, $colAntallJegere INTEGER, $colKommunenr INTEGER, $colgraGas INTEGER, $colkanadaGas INTEGER, $colkortnebbGas INTEGER)''';
}
