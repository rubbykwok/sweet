package util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class MyCookie {

    public static void set(HttpServletResponse response,String key, String value, int time){
        Cookie ck = new Cookie(key,value);
        if(time>0) {
            ck.setMaxAge(time);
        }
        response.addCookie(ck);
    }
    public static String get(HttpServletRequest request,String key){
        Cookie[] cookies=request.getCookies();
        String value;
        // 遍历数组,获得具体的Cookie
        if(cookies != null) {
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                if (cookie.getName().equals(key)) {
                    value = cookie.getValue();//账号
                    return value;
                }
            }
        }
        return "";
    }
    public static void remove(HttpServletRequest request,HttpServletResponse response,String key){
        Cookie[] cookies = request.getCookies();
        if(cookies!=null){
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                if(cookie.getName().equals(key)){
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
        }
    }
}
