import 'package:gasejakt/business_logic/models/kommune.dart';

class Huntingday {
  //[Range(1, 999999)]
  String jegerNumber;
  String location;
  DateTime date;

  //[Range(101, 9999, ErrorMessage = "{0} must be between 101 and 9999")]
  // int kommunenummer;
  //Hente kommune fra kommunenr eller lagre kommunenavnet på objektet?
  // String kommunenavn;
  Kommune kommune;

  //[Range(1, 99, ErrorMessage = "{0} must be between 1 and 100")]
  int antallJegere;
  int graGas;
  int kanadaGas;
  int kortnebbGas;

  Huntingday(
      {this.jegerNumber = "",
      this.location = "",
      this.antallJegere = 0,
      this.graGas = 0,
      this.kommune,
      this.kanadaGas = 0,
      this.kortnebbGas = 0})
      : this.date = DateTime.now();
}