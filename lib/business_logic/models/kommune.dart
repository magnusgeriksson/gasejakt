class Kommune {
  //[Range(1, 999999)]
  int id;
  int nummer;
  int gammeltNummer;
  String navn;
  bool isSelected;


Kommune(int id, int nummer, String navn){
  this.id  = id;
  this.nummer = nummer;
  this.navn = navn;
  this.isSelected = false;
}

  // Huntingday(
  //     {this.id = ,
  //     this.location = "",
  //     this.antallJeger = 0,
  //     this.graGas = 0,
  //     this.kanadaGas = 0,
  //     this.kortnebbGas = 0});
}