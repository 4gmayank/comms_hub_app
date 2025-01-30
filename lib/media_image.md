trello-gallery plugin
ios training: 
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />



import android.content.pm.PackageManager
import android.database.Cursor
import android.net.Uri
import android.provider.MediaStore
import android.util.Log
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val REQUEST_CODE_STORAGE_PERMISSION = 100

    private val CHANNEL = "com.example.media"  // Define a channel name
    private var toast: Toast? = null  // Keep a reference to the Toast object

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d("TAG", "This is a debug message")
        // Create a MethodChannel to handle the toast
        flutterEngine.dartExecutor.let {
            MethodChannel(it, CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "gallery") {
                    if (ContextCompat.checkSelfPermission(this, android.Manifest.permission.READ_EXTERNAL_STORAGE)
                        != PackageManager.PERMISSION_GRANTED) {
                        // Request permission
                        ActivityCompat.requestPermissions(this,
                            arrayOf(android.Manifest.permission.READ_EXTERNAL_STORAGE),
                            REQUEST_CODE_STORAGE_PERMISSION)
                    } else {
                        // If permission is granted, fetch images
                        val imageList = mutableListOf<String>()
                        val projection = arrayOf(MediaStore.Images.Media.DATA)
                        val uri: Uri = MediaStore.Images.Media.EXTERNAL_CONTENT_URI
                        val cursor: Cursor? = contentResolver.query(uri, projection, null, null, null)

                        cursor?.use {
                            val columnIndex = it.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
                            while (it.moveToNext()) {
                                val imagePath = it.getString(columnIndex)
                                imageList.add(imagePath)
                            }
                            result.success(imageList)
                        }

                    }
//                    val message =
//                        call.argument<String>("message")  // Get the message from the Flutter side
//                    message?.let {
//                        // Show toast message on Android
//                        Toast.makeText(applicationContext, it, Toast.LENGTH_SHORT).show()
//                        result.success(null)  // Return success to Flutter side
//                    }
                    Log.d("TAG", "This is a debug message")
                } else if (call.method == "showToast") {
                    toast?.cancel()
                    val message = call.argument<String>("message")  // Get the message from the Flutter side
                    message?.let {
                       toast = Toast.makeText(applicationContext, it, Toast.LENGTH_SHORT)
                        toast?.show()
                        result.success(null)  // Return success to Flutter side
                    }
                } else {
                    Log.d("TAG", "This is a debug message")
                    result.notImplemented()  // If the method is not implemented
                }
            }
        }
    }
}





  static const platform = MethodChannel('com.example.media'); // Channel name should match with native code

  static Future<void> showToast() async {
    try {
      print('Config.showToast');
      await platform.invokeMethod('showToast', {'message': 'Brother, Click Attachment send Media!'});
    } on PlatformException catch (e) {
      print('Config.showToast');
      print("Failed to show toast: ${e.message}");
    }
  }
  static Future<void> loadMediaList() async {
    try {
      print('Config.showToast');
      var files = await platform.invokeMethod('gallery', {'message': 'Brother, Click Attachment send Media!'});
      print(files.toString());
      print(files.length);
    } on PlatformException catch (e) {
      print('Config.showToast');
      print("Failed to show toast: ${e.message}");
    }
  }
