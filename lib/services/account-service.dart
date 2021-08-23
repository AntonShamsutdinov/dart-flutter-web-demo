import 'dart:convert';
import 'dart:io';
import 'package:dart_flutter_web_demo/singletons/app-data.dart';

import '../entities/account.dart';

final String dynamicsApiPath = '/api/data/v9.2';

Future<List<Account>> fetchAccounts() async {
  final response = await appData.httpClient.get(
      Uri.parse(appData.baseUri + dynamicsApiPath + '/accounts'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + appData.accessToken,
      });

  if (response.statusCode >= 200 && response.statusCode < 300) {
    var jsonArray = jsonDecode(response.body)['value'];
    List<Account> result = List<Account>.from(
        jsonArray.map((account) => Account.fromJson(account)));
    return result;
  } else {
    throw Exception('Failed to load accounts');
  }
}

Future<String> fetchAccountJson(String accountId) async {
  final response = await appData.httpClient.get(
      Uri.parse(appData.baseUri + dynamicsApiPath + '/accounts(' + accountId + ')'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ' + appData.accessToken,
      });

  if (response.statusCode >= 200 && response.statusCode < 300) {
    return response.body;
  } else {
    throw Exception('Failed to load account');
  }
}