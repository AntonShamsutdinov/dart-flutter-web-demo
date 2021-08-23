import 'package:flutter/material.dart';
import 'package:dart_flutter_web_demo/singletons/app-data.dart';
import 'package:http/http.dart' as http;

import '../entities/account.dart';
import '../services/account-service.dart';

enum View { Card, List }

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  _AccountsScreenState createState() => new _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  late Future<List<Account>> _futureAccounts;
  List<Account> _accounts = [];
  List<Account> _filteredAccounts = [];
  View _view = View.Card;

  void _filter(String enteredKeyword) {
    List<Account> results = [];
    if (enteredKeyword.isEmpty) {
      results = _accounts;
    } else {
      results = _accounts
          .where((account) =>
              account.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredAccounts = results;
    });
  }

  @override
  void initState() {
    super.initState();
    if (appData.accessToken.isNotEmpty) {
      try {
        _futureAccounts = fetchAccounts();
        _futureAccounts.then((result) {
          setState(() {
            _accounts = result;
            _filteredAccounts = result;
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
          title: Text('Accounts'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              _buildSearchRow(),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: _filteredAccounts.length > 0
                    ? _view == View.Card
                        ? _buildCardList()
                        : _buildList()
                    : Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        ));
  }

  _switchViewTo(View view) {
    setState(() {
      _view = view;
    });
  }

  _buildSearchRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 8,
              child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: OverflowBar(children: [
                    TextField(
                        onChanged: (value) => _filter(value),
                        decoration: InputDecoration(
                            labelText: 'Search',
                            suffixIcon: Icon(Icons.search)))
                  ]))),
          Expanded(
              flex: 1,
              child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.filter_alt, size: 18),
                            ),
                            TextSpan(
                              text: "Filter",
                            ),
                          ],
                        ),
                      ),
                      onTap: () {}))),
          Expanded(
              flex: 1,
              child: Center(
                  child: OverflowBar(children: [
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        child: Icon(Icons.list, size: 18),
                        onTap: () => _switchViewTo(View.List))),
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                        child: Icon(Icons.grid_view, size: 18),
                        onTap: () => _switchViewTo(View.Card)))
              ])))
        ]);
  }

  _buildCardList() {
    return ListView.builder(
        itemCount: _filteredAccounts.length,
        itemBuilder: (context, index) => Card(
              key: ValueKey(_filteredAccounts[index].id),
              color: Colors.grey,
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                child: ListTile(
                  leading: Text(
                    _filteredAccounts[index].name,
                    style: TextStyle(fontSize: 24),
                  ),
                  title: Text('${_filteredAccounts[index].email}'),
                  subtitle: Text('${_filteredAccounts[index].address}'),
                ),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/accounts',
                    arguments: _filteredAccounts[index].id,
                  );
                },
              ),
            ));
  }

  _buildList() {
    return ListView.builder(
        itemCount: _filteredAccounts.length,
        itemBuilder: (context, index) => Text(_filteredAccounts[index].name));
  }
}
