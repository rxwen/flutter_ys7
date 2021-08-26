package com.cspy.flutter_ys7.flutter_ys7;

import android.annotation.SuppressLint;
import android.app.Application;
import android.content.Context;
import android.os.Handler;
import android.os.Message;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.videogo.errorlayer.ErrorInfo;
import com.videogo.openapi.EZConstants;
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
    private EZPlayer ezPlayer = null;

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
            ezPlayer = EZOpenSDK.getInstance().createPlayer((String) call.argument("deviceSerial"), (int) call.argument("cameraNo"));
//            ezPlayer.setHandler(new Ys7ViewHandle());
            surfaceView.getHolder().addCallback(new SurfaceHolder.Callback() {
                @Override
                public void surfaceCreated(@NonNull SurfaceHolder holder) {
                    if (ezPlayer != null) {
                        ezPlayer.setSurfaceHold(holder);
                    }
                }

                @Override
                public void surfaceChanged(@NonNull SurfaceHolder holder, int format, int width, int height) {

                }

                @Override
                public void surfaceDestroyed(@NonNull SurfaceHolder holder) {
                    if (ezPlayer != null) {
                        ezPlayer.setSurfaceHold(null);
                    }
//                    mRealPlaySh = null;

                }
            });
            ezPlayer.setPlayVerifyCode((String) call.argument("verifyCode"));
            ezPlayer.startRealPlay();
            result.success("success");
        } else if (call.method.equals("end")) {
            ezPlayer.stopRealPlay();
            ezPlayer.release();
            result.success("success");
        } else if (call.method.equals("test")) {
            String token = call.argument("token");
            Log.d("h","test = " + token);
            result.success("success");
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
        if(null != ezPlayer) {
            ezPlayer.stopRealPlay();
            ezPlayer.release();
        }
    }

    class Ys7ViewHandle extends Handler {
        @Override
        public void handleMessage(@NonNull Message msg) {
            switch (msg.what) {
                case EZConstants.EZRealPlayConstants.MSG_REALPLAY_PLAY_SUCCESS:
                    Log.d("ys7","播放成功");
                    //播放成功
                    break;
                case EZConstants.EZRealPlayConstants.MSG_REALPLAY_PLAY_FAIL:
                    //播放失败,得到失败信息
                    ErrorInfo errorinfo = (ErrorInfo) msg.obj;
                    //得到播放失败错误码
                    int code = errorinfo.errorCode;
                    //得到播放失败模块错误码
                    String codeStr = errorinfo.moduleCode;
                    //得到播放失败描述
                    String description = errorinfo.description;
                    //得到播放失败解决方方案
                    String sulution = errorinfo.sulution;
                    break;
                case EZConstants.MSG_VIDEO_SIZE_CHANGED:
                    //解析出视频画面分辨率回调
                    try {
                        String temp = (String) msg.obj;
                        String[] strings = temp.split(":");
                        int mVideoWidth = Integer.parseInt(strings[0]);
                        int mVideoHeight = Integer.parseInt(strings[1]);
                        //解析出视频分辨率
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    break;
                default:
                    break;
            }
        }
    }
}
