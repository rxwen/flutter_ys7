package com.cspy.flutter_ys7.flutter_ys7;

import android.app.Application;
import android.content.Context;
import android.os.Handler;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.videogo.openapi.EZOpenSDK;
import com.videogo.openapi.EZPlayer;

import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;

public class FlutterYs7View implements PlatformView, MethodChannel.MethodCallHandler {
    @NonNull private final BinaryMessenger messenger;
    private static final String CHANNEL = "cspy/flutter_ys7";
    private Application application;
    private SurfaceView surfaceView;
    private EZPlayer ezPlayer;

    public FlutterYs7View(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, BinaryMessenger messenger, Application application) {
        this.messenger = messenger;
        this.application = application;
        new MethodChannel(messenger,CHANNEL).setMethodCallHandler(this);
        surfaceView = new SurfaceView(context);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        if(call.method.equals("start")) {
            String token = call.argument("token");
            Log.d("h","token = " + token);
            Log.d("h","deviceSerial = " + call.argument("deviceSerial"));
            Log.d("h","verifyCode = " + call.argument("verifyCode"));
            Log.d("h","cameraNo = " + call.argument("cameraNo"));
            EZOpenSDK.getInstance().setAccessToken(token);
            ezPlayer  = EZOpenSDK.getInstance().createPlayer((String)call.argument("deviceSerial") ,(int) call.argument("cameraNo") );
//            player.setHandler();

            ezPlayer.setSurfaceHold(surfaceView.getHolder());
            ezPlayer.setPlayVerifyCode((String)call.argument("verifyCode"));
            ezPlayer.startRealPlay();

        } else if (call.method.equals("end")) {
            ezPlayer.stopRealPlay();
            ezPlayer.release();
        } else if (call.method.equals("init_sdk")) {
            String appKey = call.argument("appKey");
            Log.d("h","appKey = " + appKey);
            result.success(EZOpenSDK.initLib(this.application,appKey));
        } else if (call.method.equals("test")) {
            String token = call.argument("token");
            Log.d("h","test = " + token);
        } else {
          result.notImplemented();
        }
    }

    @Override
    public View getView() {
        return surfaceView;
    }

    @Override
    public void dispose() {

    }
}
