import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:dart_flutter_web_demo/main.dart';
import 'package:dart_flutter_web_demo/singletons/app-data.dart';

void main() {
  const MethodChannel channel = MethodChannel('package:dart_flutter_web_demo/services/account-service.dart');

  setUpAll((){
    appData.httpClient = MockClient((request) async {
      return Response('{"value": [{"accountid": "1", "name": "Super mega account"}]}', 200);
    });
  });

  testWidgets('When no Access Token is entered then error message',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    final resultsFinder = find.text('Please enter Access Token');

    expect(resultsFinder, findsOneWidget);
  });

  testWidgets(
      'When Access Token is entered and Accounts displayed then success',
      (WidgetTester tester) async {

    await tester.pumpWidget(MyApp());

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('baseUri')), '123');
    await tester.enterText(find.byKey(Key('accessToken')), '123');
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    final resultsFinder = find.text('Super mega account');

    expect(resultsFinder, findsOneWidget);
  });
}
