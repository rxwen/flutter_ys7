package com.cspy.flutter_ys7.flutter_ys7;

import android.app.Application;
import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;

import com.videogo.openapi.EZOpenSDK;

import org.jetbrains.annotations.NotNull;

import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class FlutterYs7ViewFactory extends PlatformViewFactory implements MethodChannel.MethodCallHandler {
    @NonNull private final BinaryMessenger messenger;
    private Application application;

    public FlutterYs7ViewFactory(@NonNull BinaryMessenger messenger,Application application) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.application = application;

        new MethodChannel(messenger, "cspy/flutter_ys7/plugin").setMethodCallHandler(this);
    }

//    /**
//     * @param createArgsCodec the codec used to decode the args parameter of {@link #create}.
//     * @param messenger
//     */
//    public FlutterYs7ViewFactory(MessageCodec<Object> createArgsCodec, @NonNull BinaryMessenger messenger) {
//        super(createArgsCodec);
//        this.messenger = messenger;
//    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return new FlutterYs7View(context, id, creationParams,this.messenger, this.application);
    }

    @Override
    public void onMethodCall(@NotNull MethodCall call, @NotNull MethodChannel.Result result) {
        if (call.method.equals("init_sdk")) {
            String appKey = call.argument("appKey");
            Log.d("h","appKey = " + appKey);
            result.success(EZOpenSDK.initLib(this.application,appKey));
        } else if (call.method.equals("set_access_token")) {
            String AccessToken = call.argument("accessToken");
            EZOpenSDK.getInstance().setAccessToken(AccessToken);
            result.success(true);
        } else {
            result.notImplemented();
        }
    }
}
