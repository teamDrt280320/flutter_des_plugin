import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:des_plugin/des_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('des_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DesPlugin.platformVersion, '42');
  });
}
