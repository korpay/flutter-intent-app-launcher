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
    val intentUrl = call.argument<String>("intentUrl")

    if (intentUrl == null) {
      result.error("INVALID_ARGUMENT", "intentUrl is null", null)
      return
    }

    when (call.method) {
      "openAndroidApp" -> {
        openAndroidApp(intentUrl, result)
      }
      "extractAndroidPackageName" -> {
        extractAndroidPackageName(intentUrl, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }


  private fun openAndroidApp(url: String, result: Result) {
    try {
      val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
      
      intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)

      if (intent.resolveActivity(context.packageManager) != null) {
          context.startActivity(intent)
          result.success(true)
      } else {
          result.success(false) 
      }
    } catch (e: Exception) {
      result.error("EXECUTION_ERROR", e.message, null)
    }
  }

  private fun extractAndroidPackageName(url: String, result: Result) {
    try {
      val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
      val packageName = intent.`package`
      
      result.success(packageName)
    } catch (e: URISyntaxException) {
      result.error("PARSE_ERROR", "Invalid Intent URL", null)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}