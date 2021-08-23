import 'package:flutter/material.dart';
import 'package:dart_flutter_web_demo/singletons/app-data.dart';
import 'package:http/http.dart' as http;

import '../services/account-service.dart';

class AccountDetailsScreen extends StatefulWidget {
  final String accountId;

  const AccountDetailsScreen({Key? key, required this.accountId}) : super(key: key);

  @override
  _AccountsDetailsScreenState createState() =>
      new _AccountsDetailsScreenState();
}

class _AccountsDetailsScreenState extends State<AccountDetailsScreen> {
  late Future<String> _futureAccount;
  String _account = '';

  @override
  void initState() {
    super.initState();
    if (appData.accessToken.isNotEmpty && widget.accountId.isNotEmpty) {
      try {
        _futureAccount = fetchAccountJson(widget.accountId);
        _futureAccount.then((result) {
          setState(() {
            _account = result;
          });
        });
      } catch (e) {
        Navigator.pop(context);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Details'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Text(_account),
              SizedBox(
                height: 20,
              )
            ])));
  }
}
