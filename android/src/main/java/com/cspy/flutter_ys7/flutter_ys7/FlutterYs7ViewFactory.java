package com.cspy.flutter_ys7.flutter_ys7;

import android.app.Application;
import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class FlutterYs7ViewFactory extends PlatformViewFactory {
    @NonNull private final BinaryMessenger messenger;
    private Application application;

    public FlutterYs7ViewFactory(@NonNull BinaryMessenger messenger,Application application) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.application = application;
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
}
