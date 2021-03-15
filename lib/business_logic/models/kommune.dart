class Kommune {
  //[Range(1, 999999)]
  String id;
  String navn;
  bool isSelected;

  Kommune(String id, String navn) {
    this.id = id;
    this.navn = navn;
    this.isSelected = false;
  }

  Kommune.fromJson(Map<String, dynamic> json)
      : id = json["kommunenummer"],
        navn = json["kommunenavnNorsk"];
}

// Huntingday(
//     {this.id = ,
//     this.location = "",
//     this.antallJeger = 0,
//     this.graGas = 0,
//     this.kanadaGas = 0,
//     this.kortnebbGas = 0});
