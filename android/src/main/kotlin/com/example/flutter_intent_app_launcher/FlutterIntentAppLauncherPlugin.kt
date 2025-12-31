package com.example.flutter_intent_app_launcher

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.net.URISyntaxException

class FlutterIntentAppLauncherPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context


  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_intent_app_launcher")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    val url = call.argument<String>("intentUrl")

    if (intentUrl == null) {
      result.error("INVALID_ARGUMENT", "intentUrl is null", null)
      return
    }

    when (call.method) {
      "getAppUrl" -> {
        try {
          val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
          result.success(intent.dataString) 
        } catch (e: URISyntaxException) {
          result.error("PARSE_ERROR", e.message, null)
        } catch (e: Exception) {
          result.error("UNKNOWN_ERROR", e.message, null)
        }
      }

      "getPackageName" -> {
        try {
          val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
          val packageName = intent.`package`
          
          if (packageName != null) {
            result.success(packageName)
          } else {
            result.success(null) 
          }
        } catch (e: Exception) {
          result.error("PARSE_ERROR", e.message, null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}