package com.example.material_app

/*
?   Change FlutterActivity to FlutterFragmentActivity in MainActivity.kt
?   Why? Fragments are kinda like sub Activities, FragmentActivity contains
?   all the features that Activity has, with some additional ones. 
*/
    import androidx.annotation.NonNull;
    import io.flutter.embedding.android.FlutterFragmentActivity
    import io.flutter.embedding.engine.FlutterEngine
    import io.flutter.plugins.GeneratedPluginRegistrant

    class MainActivity: FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
            GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
    }

