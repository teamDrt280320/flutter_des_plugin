package com.teamdrt.flutter_des_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/**
 * DesPlugin
 */
class DesPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "encrypt" -> try {
                result.success(
                    DesCryptUtils.encrypt(
                        call.argument<Any>("key").toString(),
                        call.argument<Any>("data").toString()
                    )
                )
            } catch (e: Exception) {
                e.printStackTrace()
                result.error(e.message, e.localizedMessage, e.message)
            }
            "decrypt" -> try {
                result.success(
                    DesCryptUtils.decrypt(
                        call.argument<Any>("key").toString(),
                        call.argument<Any>("data").toString()
                    )
                )
            } catch (e: Exception) {
                e.printStackTrace()
                result.error(e.message, e.localizedMessage, e.message)
            }
            "threeEncrypt" -> {
            }
            "threeDecrypt" -> try {
                result.success(
                    DesCryptUtils.decode(
                        call.argument<Any>("key").toString(), call.argument<Any>("data").toString(),
                        call.argument<Any>("iv").toString()
                    )
                )
            } catch (e: Exception) {
                e.printStackTrace()
                result.error(e.message, e.localizedMessage, e.message)
            }
            else -> result.notImplemented()
        }
    }

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "des_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}