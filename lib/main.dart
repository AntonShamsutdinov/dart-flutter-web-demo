import 'package:flutter/material.dart';

import 'screens/access-token-screen.dart';
import 'screens/account-details-screen.dart';
import 'screens/accounts-screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (settings) {
          final arguments = settings.arguments;
          switch (settings.name) {
            case '/accounts':
              if (arguments is String) {
                return MaterialPageRoute(
                    builder: (context) {
                      return AccountDetailsScreen(accountId: arguments);
                    }
                );
              }
              else
              {
                return MaterialPageRoute(builder: (context) {
                  return AccountsScreen();
                });
              }
            default:
              return MaterialPageRoute(builder: (context) {
                return AccessTokenScreen();
              });
          }
        },
        title: 'Web Assessment',
        theme: ThemeData(primarySwatch: Colors.blueGrey));
  }
}
