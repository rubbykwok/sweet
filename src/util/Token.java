package util;

import java.security.MessageDigest;


public class Token {
    private static String tokenName = "token";
    private static String tokenValue;
    private static MessageDigest messageDigest = null;

    /**
     * 对传入字符串进行加密
     * @param str  传入字符串
     * @return 加密后字符串
     */
    private static String stringSHA1(String str) {
        try {
            messageDigest = MessageDigest.getInstance("SHA1");
        } catch (Exception e) {
            System.out.println("messageDigest failed");
            e.printStackTrace();
        }
        byte[] bytes = messageDigest.digest(str.getBytes());
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < bytes.length; i++) {
            String s = Integer.toHexString(0xff & bytes[i]);

            if (s.length() == 1) {
                sb.append("0" + s);
            } else {
                sb.append(s);
            }
        }
        return sb.toString();
    }

    public static String createToken(String usr){
        return stringSHA1(usr+ Math.random()%100);
    }
}
