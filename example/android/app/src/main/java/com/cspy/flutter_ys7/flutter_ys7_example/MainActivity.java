package com.cspy.flutter_ys7.flutter_ys7_example;

import androidx.annotation.NonNull;

import com.cspy.flutter_ys7.flutter_ys7.FlutterYs7ViewFactory;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        flutterEngine.getPlatformViewsController().getRegistry().registerViewFactory("cspy/flutter_ys7/videoView",
                new FlutterYs7ViewFactory(flutterEngine.getDartExecutor().getBinaryMessenger(),getApplication()));
    }
}
