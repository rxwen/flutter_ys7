//
//  EZPlayerView.swift
//  Runner
//
//  Created by py on 2021/8/21.
//

import Foundation
import Flutter
import UIKit
import EZOpenSDKFramework

class EZUIPlayerView: NSObject, FlutterPlatformView, EZPlayerDelegate  {
    private var _view: UIView
    private var messenger: FlutterBinaryMessenger
    var player: EZPlayer

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger: FlutterBinaryMessenger){
        _view = UIView()
        self.messenger = binaryMessenger
        self.player = EZOpenSDK.createPlayer(withDeviceSerial: "123", cameraNo: 1)
        super.init()
        createNativeView(view: _view)
        initMethodChannel()
        player.destoryPlayer()
    }

    func initMethodChannel(){
        let batteryChannel = FlutterMethodChannel(name: "cspy/flutter_ys7", binaryMessenger: messenger)
        batteryChannel.setMethodCallHandler(self.callMessage)
    }

    func view() -> UIView {

        return _view;
    }

    func createNativeView(view _view: UIView){
        _view.backgroundColor = UIColor.blue
        let nativeLabel = UILabel()
        nativeLabel.text = "Native text from iOS"
        nativeLabel.textColor = UIColor.white
        nativeLabel.textAlignment = .center
        nativeLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 48.0)
        _view.addSubview(nativeLabel)
    }

    func callMessage (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void {
      // Note: this method is invoked on the UI thread.
      // Handle battery messages.
        if call.method == "start" {
            let data:Optional<Dictionary> = call.arguments as! Dictionary<String, Any>

            print(data)
            print(type(of:data))

            EZOpenSDK.setAccessToken(data?["token"] as! String)

            player = EZOpenSDK.createPlayer(withDeviceSerial: data?["deviceSerial"] as! String, cameraNo: data?["cameraNo"] as! Int)
//            player.delegate = self


            let verifyCode = data?["verifyCode"] as? String
            if(verifyCode != nil) {
                player.setPlayVerifyCode(data?["verifyCode"] as! String)
            } else {
                print("verifyCode is null !!!")
            }

            player.setPlayerView(_view)
            player.startRealPlay()
            result("开始播放")
        } else if call.method == "end" {
            player.stopRealPlay()
            player.destoryPlayer()
            result("停止播放")
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
