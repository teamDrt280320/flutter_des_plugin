import 'package:flutter/material.dart';
import 'package:flutter_des_plugin/flutter_des_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String key = "iloveyou";
  String data = "Data";

  String encrypt = "";
  String decrypt = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  DesPlugin.encrypt(key, data).then((result) {
                    encrypt = result;
                  });
                });
              },
              child: Text("des Encrypt"),
            ),
            TextButton(
              onPressed: () {
                DesPlugin.decrypt(key, encrypt).then((result) {
                  setState(() {
                    decrypt = result;
                  });
                });
              },
              child: Text("Des"),
            ),
            Text("Encrypt: " + encrypt),
            Text("Decrypt: " + decrypt),
          ],
        ),
      ),
    );
  }
}
