package util;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONException;
import com.alibaba.fastjson.JSONObject;
import com.iflytek.cloud.speech.*;

/**
 * @author: zsl
 * @date: 2018/07/21 14:36
 */
public class XFUtil {

    static {
        SpeechUtility.createUtility(SpeechConstant.APPID + "=5b528510");
    }

    private static String result = "";

    //听写监听器，语音转文字
    private static RecognizerListener mRecoListener = new RecognizerListener() {
        //听写结果回调接口(返回Json格式结果，用户可参见附录)；
        //一般情况下会通过onResults接口多次返回结果，完整的识别内容是多次结果的累加；
        //关于解析Json的代码可参见MscDemo中JsonParser类；
        //isLast等于true时会话结束。
        public void onResult(RecognizerResult results, boolean isLast) {
//            DebugLog.Log("Result:"+results.getResultString ());
            String result = results.getResultString();
//            System.out.println("原始结果：" + result);
            jsonExtract(result);
        }

        //会话发生错误回调接口
        public void onError(SpeechError error) {
//            error.getPlainDescription(); //获取错误码描述
            error.getErrorDescription(true);
        }

        //开始录音
        public void onBeginOfSpeech() {
            System.out.println("请说话");
        }

        //音量值0~30
        public void onVolumeChanged(int volume) {
        }

        //结束录音
        public void onEndOfSpeech() {
            System.out.println("语音识别结束，识别结果如下");
        }

        //扩展用接口
        public void onEvent(int eventType, int arg1, int arg2, String msg) {
        }
    };

    public static String voiceToWord() {
        //1.创建SpeechRecognizer对象
        SpeechRecognizer mIat = SpeechRecognizer.createRecognizer();
        //2.设置听写参数，详见《MSC Reference Manual》SpeechConstant类
        mIat.setParameter(SpeechConstant.DOMAIN, "iat");
        mIat.setParameter(SpeechConstant.LANGUAGE, "zh_cn");
        mIat.setParameter(SpeechConstant.ACCENT, "mandarin ");
        //3.开始听写
        mIat.startListening(mRecoListener);
        // 因为异步的，没有这个，会直接输出
        while (mIat.isListening()) {

        }
        return result;
    }

    public static void jsonExtract(String json) {
        Object object;
        // 判断是否符合json格式，因为如果不符合，会报错
        try {
            object = JSONObject.parse(json);
        } catch (JSONException e) {
            System.out.println("不符合json格式，" + e.getMessage());
            return;
        }
        JSONObject jsonObject;
        //JSON可能又多个元素
        if (object instanceof JSONArray) {
            JSONArray jsonArray = (JSONArray) object;
            for (int i = 0; i < jsonArray.size(); i++) {
                jsonObject = jsonArray.getJSONObject(i);
                dealJsonObject(jsonObject);
            }
        }
        // 单个元素时
        else if (object instanceof JSONObject) {
            jsonObject = (JSONObject) object;
            dealJsonObject(jsonObject);
        }
    }

    private static void dealJsonObject(JSONObject jsonObject) {
        for (String key : jsonObject.keySet()) {
            String str = jsonObject.getString(key);
            if (key.equals("w")) {
                System.out.print(str);
                return;
            }
            jsonExtract(str);
        }
    }
}