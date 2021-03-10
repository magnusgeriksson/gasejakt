class Huntingday {
  //[Range(1, 999999)]
  String jegerNumber;
  String location;
  DateTime time;
  //[Range(101, 9999, ErrorMessage = "{0} must be between 101 and 9999")]
  int kommunenummer;
  //[Range(1, 99, ErrorMessage = "{0} must be between 1 and 100")]
  int antallJeger;
  int graGas;
  int kanadaGas;
  int kortnebbGas;

  Huntingday(
      {this.jegerNumber = "",
      this.location = "",
      this.antallJeger = 0,
      this.graGas = 0,
      this.kanadaGas = 0,
      this.kortnebbGas = 0});
}