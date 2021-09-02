package com.cspy.flutter_ys7.flutter_ys7;

public class Ys7ToFlutterEntity {
    private String code;
    private String Data;
    private long callBackFuncId;

    public Ys7ToFlutterEntity(String code, String data) {
        this.code = code;
        Data = data;
    }

    public long getCallBackFuncId() {
        return callBackFuncId;
    }

    public void setCallBackFuncId(long callBackFuncId) {
        this.callBackFuncId = callBackFuncId;
    }
}
