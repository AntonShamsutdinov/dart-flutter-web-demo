import 'dart:convert';

import 'package:test/test.dart';
import 'package:dart_flutter_web_demo/entities/account.dart';

void main() {
  test('Json to Account should be correct', () {
    final json = {
      'accountid': 'test',
      'accountnumber': null,
      'name': 'Coffee Shop',
      'address1_composite': 'Houston, TX',
      'emailaddress1': 'john@doe.com',
      'address1_stateorprovince': 'TX',
      'address2_stateorprovince': null,
      'statecode': 1
    };

    final account = Account.fromJson(json);

    expect(account.id, json['accountid']);
    expect(account.number, json['accountnumber']);
    expect(account.address1stateOrProvince, json['address1_stateorprovince']);
    expect(account.stateCode, json['statecode']);
  });
}