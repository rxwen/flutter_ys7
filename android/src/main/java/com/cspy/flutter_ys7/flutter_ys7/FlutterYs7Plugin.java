package com.cspy.flutter_ys7.flutter_ys7;

import android.app.Application;
import android.content.Context;

import androidx.annotation.NonNull;

import org.jetbrains.annotations.NotNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

//public class FlutterYs7Plugin  {
public class FlutterYs7Plugin implements FlutterPlugin {
    //    private Application application;
//    public FlutterYs7Plugin(Application application) {
//        this.application = application;
//    }
//
//
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
//        binding.getPlatformViewRegistry().registerViewFactory("cspy/flutter_ys7/videoView",new FlutterYs7ViewFactory(binding.getBinaryMessenger(),application));
    }


    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }
}
