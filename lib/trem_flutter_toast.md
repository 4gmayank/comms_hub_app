package com.demo.bottomfeat.bottom_feature_app

import android.util.Log
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){



    private val CHANNEL = "com.example.toast"  // Define a channel name

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d("TAG", "This is a debug message")
        // Create a MethodChannel to handle the toast
        flutterEngine.dartExecutor.let {
            MethodChannel(it, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "showToast") {
                    Log.d("TAG", "This is a debug message")
                    val message = call.argument<String>("message")  // Get the message from the Flutter side
                    message?.let {
                        // Show toast message on Android
                        Toast.makeText(applicationContext, it, Toast.LENGTH_SHORT).show()
                        result.success(null)  // Return success to Flutter side
                    }
                    Log.d("TAG", "This is a debug message")
                } else {
                    Log.d("TAG", "This is a debug message")
                    result.notImplemented()  // If the method is not implemented
                }
            }
        }
    }
}


import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {


  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)


     let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: AppDelegate.CHANNEL, binaryMessenger: controller.binaryMessenger)

    channel.setMethodCallHandler { (call, result) in
        if call.method == "showToast" {
            if let message = call.arguments as? String {
                let toast = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
                controller.present(toast, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    toast.dismiss(animated: true, completion: nil)
                }
                result(nil)
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
import 'package:flutter/services.dart';

class Config{
  static const platform = MethodChannel('com.example.toast'); // Channel name should match with native code

  static Future<void> showToast() async {
    try {
      print('Config.showToast');
      await platform.invokeMethod('showToast', {'message': 'Hello, this is a native toast!'});
    } on PlatformException catch (e) {
      print('Config.showToast');
      print("Failed to show toast: ${e.message}");
    }
  }

}
