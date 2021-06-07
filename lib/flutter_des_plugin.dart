import 'dart:async';

import 'package:flutter/services.dart';

class DesPlugin {
  static const MethodChannel _channel = const MethodChannel('des_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> encrypt(String key, String jsonData) async {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = jsonData;

    return await _channel.invokeMethod('encrypt', data);
  }

  static Future<String> decrypt(String key, String jsonData) async {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = jsonData;

    return await _channel.invokeMethod('decrypt', data);
  }

  static Future<String> threeDecrypt(
      String key, String jsonData, String iv) async {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["key"] = key;
    data["data"] = jsonData;
    data["iv"] = iv;

    return await _channel.invokeMethod('threeDecrypt', data);
  }
}
