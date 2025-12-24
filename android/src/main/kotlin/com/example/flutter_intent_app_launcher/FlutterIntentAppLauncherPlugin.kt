package com.example.flutter_intent_app_launcher

import android.app.Activity
import android.content.Intent
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/**
 * FlutterIntentAppLauncherPlugin
 * ActivityAware를 구현하여 현재 Activity Context를 안전하게 가져옵니다.
 */
class FlutterIntentAppLauncherPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  
  private lateinit var channel : MethodChannel
  private var activity : Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_intent_app_launcher")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "openAndroidApp" -> {
        val intentUrl = call.argument<String>("intentUrl")
        if (intentUrl != null) {
          openAndroidApp(intentUrl, result)
        } else {
          result.error("INVALID_ARGUMENT", "intentUrl is null", null)
        }
      }
      "extractAndroidPackageName" -> {
        val intentUrl = call.argument<String>("intentUrl")
        if (intentUrl != null) {
          val packageName = extractAndroidPackageName(intentUrl)
          result.success(packageName)
        } else {
          result.error("INVALID_ARGUMENT", "intentUrl is null", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  // 로직 1: 앱 실행 (Activity Context 사용 -> 자연스러운 전환)
  private fun openAndroidApp(intentUrl: String, result: Result) {
    // activity가 null이면 실행 불가
    val currentActivity = activity
    if (currentActivity == null) {
      result.error("NO_ACTIVITY", "Activity is not available. App is in background or detached.", null)
      return
    }

    try {
      val intent = Intent.parseUri(intentUrl, Intent.URI_INTENT_SCHEME)
      // Activity Context를 쓰므로 FLAG_ACTIVITY_NEW_TASK가 필요 없습니다.
      currentActivity.startActivity(intent)
      result.success(true)
    } catch (e: Exception) {
      // 파싱 실패 또는 앱이 설치되지 않은 경우
      result.success(false)
    }
  }

  // 로직 2: 패키지명 추출
  private fun extractAndroidPackageName(intentUrl: String): String? {
    return try {
      val intent = Intent.parseUri(intentUrl, Intent.URI_INTENT_SCHEME)
      intent.`package`
    } catch (e: Exception) {
      null
    }
  }

  // 3. Activity Lifecycle 관리 (ActivityAware 구현 필수 메서드들)
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    this.activity = binding.activity
  }

  override fun onDetachedFromActivity() {
    this.activity = null
  }

  // 4. Flutter 엔진에서 떨어질 때 (정리)
  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}