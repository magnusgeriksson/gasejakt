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
