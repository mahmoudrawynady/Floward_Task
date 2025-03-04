package com.example.flutter_native

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import java.io.File
import java.io.FileOutputStream

class MainActivity : FlutterActivity() {
    private val CHANNEL = "native_profile_channel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getProfile" -> { // ADD THIS
                    val profile = JSONObject()
                    profile.put("name", "John Doe")
                    profile.put("email", "john.doe@example.com")
                    val profileImagePath = saveProfileImageToInternalStorage(this)
                    profile.put("profile_picture", profileImagePath)
                    result.success(profile.toString())
                }
                else -> result.notImplemented()
            }
        }
    }
    fun saveProfileImageToInternalStorage(context: Context): String {
        val bitmap = BitmapFactory.decodeResource(context.resources, R.drawable.profile_picture) // Ensure you have profile_picture in res/drawable
        val file = File(context.filesDir, "profile_picture.jpg")

        FileOutputStream(file).use { fos ->
            bitmap.compress(Bitmap.CompressFormat.JPEG, 100, fos)
        }

        return file.absolutePath
    }
}
