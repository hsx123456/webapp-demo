package com.hsx.util;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by xing on 18/4/4.
 * 通用的返回类
 */
public class MsgResponse {
    //状态码 100-成功   200-失败
    private int code;
    //提示信息
    private String msg;
    //用户要返回给浏览器数据
    private Map<String,Object> extend=new HashMap<String, Object>();

    public static MsgResponse success(){
        MsgResponse msgResponse=new MsgResponse();
        msgResponse.setCode(100);
        msgResponse.setMsg("处理成功!");
        return msgResponse;
    }


    public static MsgResponse fail(){
        MsgResponse msgResponse=new MsgResponse();
        msgResponse.setCode(200);
        msgResponse.setMsg("处理失败");
        return msgResponse;
    }


    public MsgResponse add(String key,Object value){
        this.getExtend().put(key,value);
        return this;
    }


    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }
}
