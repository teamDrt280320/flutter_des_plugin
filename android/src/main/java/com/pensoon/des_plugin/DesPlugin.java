package com.pensoon.des_plugin;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * DesPlugin
 */
public class DesPlugin implements MethodCallHandler {
    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "des_plugin");
        channel.setMethodCallHandler(new DesPlugin());
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "encrypt":
                try {
                    result.success(DesCryptUtils.encrypt(call.argument("key").toString(), call.argument("data").toString()));
                } catch (Exception e) {
                    e.printStackTrace();
                    result.error(e.getMessage(),"",null);
                }
                break;
            case "decrypt":
                try {
                    result.success(DesCryptUtils.decrypt(call.argument("key").toString(), call.argument("data").toString()));
                } catch (Exception e) {
                    e.printStackTrace();
                    result.error(e.getMessage(),"",null);
                }
                break;
            case "threeEncrypt":
                break;
            case "threeDecrypt":
                try {
                    result.success(DesCryptUtils.decode(call.argument("key").toString(), call.argument("data").toString() ,
                            call.argument("iv").toString()));
                } catch (Exception e) {
                    e.printStackTrace();
                    result.error(e.getMessage(),"",null);
                }
                break;
            default:
                result.notImplemented();
                break;
        }

    }
}
