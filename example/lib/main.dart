import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:des_plugin/des_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String key = "iloveyou";
  String data = "我爱你三千遍";

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
            RaisedButton(
              onPressed: (){
                setState(() {
                  DesPlugin.encrypt(key, data).then((result){
                    encrypt = result;
                  });
                });
              },
              child: Text("des加密"),
            ),
            RaisedButton(
              onPressed: (){
                  DesPlugin.decrypt(key, encrypt).then((result){
                    setState(() {
                      decrypt = result;
                    });
                  });
              },
              child: Text("des解密"),
            ),
            Text("加密后的数据:" + encrypt),
            Text("解密后的数据:" + decrypt),
          ],
        ),
      ),
    );
  }
}
