class Hunter {
  int id;
  String hunterNumber;
  String firstName;
  String lastName;
  String address;
  String postalCode;
  String postalAddress;
  String phoneNumber;
  String mailAddress;

  // Hunter(this.hunterNumber, this.firstName, this.lastName, this.address,
  //     this.postalCode, this.postalAddress, this.phoneNumber, this.mailAddress);
  Hunter(
      {this.id = 0,
      this.hunterNumber = "",
      this.firstName = "",
      this.lastName = "",
      this.address = "",
      this.postalCode = "",
      this.postalAddress = "",
      this.phoneNumber = "",
      this.mailAddress = ""});

  @override
  String toString() {
    return "$hunterNumber\n$firstName\n$lastName\n$address\n$postalCode\n$postalAddress\n$phoneNumber\n$mailAddress";
  }
}

extension DummyHunter on Hunter {
  static var dummyHunter = Hunter(
      hunterNumber: "123455",
      firstName: "Tore",
      lastName: "Tang",
      address: "Stavanger",
      postalCode: "7000",
      postalAddress: "Trondheim",
      phoneNumber: "99999999",
      mailAddress: "tore@tang.no");
}

extension CreateScriptHunter on Hunter {
  static final tableName = "hunter_table";
  static final colId = "id";
  static final colHunterNumber = "hunterNumber";
  static final colFirstName = "firstName";
  static final colLastName = "lastName";
  static final colAddress = "address";
  static final colPostalCode = "postalCode";
  static final colPostalAddress = "postalAddress";
  static final colPhoneNumber = "phoneNumber";
  static final colMailAddress = "mailAddress";

  static var script = '''
    CREATE TABLE $tableName (
      $colId INTEGER PRIMARY KEY, 
      $colHunterNumber TEXT NOT NULL,
      $colFirstName TEXT NOT NULL,
      $colLastName TEXT NOT NULL,
      $colAddress TEXT NOT NULL,
      $colPostalCode TEXT NOT NULL,
      $colPostalAddress TEXT NOT NULL,
      $colPhoneNumber TEXT NOT NULL,
      $colMailAddress TEXT NOT NULL,
    )
    ''';
}
