import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:dart_flutter_web_demo/entities/account.dart';
import 'package:dart_flutter_web_demo/services/account-service.dart';
import 'package:dart_flutter_web_demo/singletons/app-data.dart';

void main() {
  group('fetchAccounts', () {
    test('When 200 returned then success', () async {
      appData.httpClient = MockClient((request) async {
        return Response('{"value": [{"accountid": "1", "name": "2"}]}', 200);
      });

      expect(await fetchAccounts(), isA<List<Account>>());
    });

    test('When not 200 returned then exception', () {
      appData.httpClient = MockClient((request) async {
        return Response('Not Found', 404);
      });

      expect(fetchAccounts(), throwsException);
    });
  });

  group('fetchAccount', () {
    test('When 200 returned then success', () async {
      appData.httpClient = MockClient((request) async {
        return Response('{"accountid": "1", "name": "2"}', 200);
      });

      expect(await fetchAccountJson("1"), isA<String>());
    });

    test('When not 200 returned then exception', () {
      appData.httpClient = MockClient((request) async {
        return Response('Not Found', 404);
      });

      expect(fetchAccountJson("2"), throwsException);
    });
  });
}
