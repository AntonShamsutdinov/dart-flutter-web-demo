import 'package:flutter/material.dart';
import 'package:dart_flutter_web_demo/singletons/app-data.dart';

class AccessTokenScreen extends StatefulWidget {
  const AccessTokenScreen({Key? key}) : super(key: key);

  @override
  _AccessTokenScreenState createState() => _AccessTokenScreenState();
}

class _AccessTokenScreenState extends State<AccessTokenScreen> {
  final _accessToken = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _accessToken,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Base URI and Access Token'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                      onChanged: (value) => appData.baseUri = value,
                      decoration: InputDecoration(labelText: 'Base URI', hintText: 'example: https://org0a80a794.crm4.dynamics.com'),
                      key: Key('baseUri'),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter Base URI';
                        return null;
                      }),
                  TextFormField(
                      onChanged: (value) => appData.accessToken = value,
                      decoration: InputDecoration(labelText: 'Access Token'),
                      key: Key('accessToken'),
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'Please enter Access Token';
                        return null;
                      }),
                  Divider(),
                  ElevatedButton(
                    child: Text('Save'),
                    onPressed: () {
                      if (_accessToken.currentState!.validate()) {
                        Navigator.pushNamed(
                          context, '/accounts',
                        );
                      }
                    },
                  )
                ],
              ),
            )));
  }
}
