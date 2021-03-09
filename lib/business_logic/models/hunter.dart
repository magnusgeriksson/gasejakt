class Hunter {
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
      {this.hunterNumber = "",
      this.firstName = "",
      this.lastName = "",
      this.address = "",
      this.postalCode = "",
      this.postalAddress = "",
      this.phoneNumber = "",
      this.mailAddress = ""});
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
