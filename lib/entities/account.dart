class Account {
  final String id;
  final String name;

  String? address;
  String? email;
  String? number;
  int? stateCode;
  String? address1stateOrProvince;
  String? address2stateOrProvince;

  Account({
    required this.id,
    required this.name,
    this.address,
    this.email,
    this.number,
    this.stateCode,
    this.address1stateOrProvince,
    this.address2stateOrProvince
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['accountid'],
      number: json['accountnumber'],
      address: json['address1_composite'],
      email: json['emailaddress1'],
      name: json['name'],
      address1stateOrProvince: json['address1_stateorprovince'],
      address2stateOrProvince: json['address2_stateorprovince'],
      stateCode: json['statecode']
    );
  }
}