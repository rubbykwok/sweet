package util;

public class User {
    public boolean isLogin;
    private String username;
    private String nickname;
    private String sex;
    private String sign;
    private String avatar;
    private int accum;
    private int momentNo;
    private int messageNo;
    private int status;
    private int role;//1普通用户 0管理员
    public User(){
       isLogin = false;
       nickname = "未填写";
       sex = "";
       accum = 0;
       avatar = "/assets/avatar/avatar_0.jpg";
       sign = "未填写";
       role = 1;
    }
    public void setInfo(String un,String nn, int s ,String sg,String ava,int ac,int mn, int msn,int sta,int ro){
        username = un;
        accum = ac ;
        momentNo = mn;
        messageNo = msn;
        status = sta;
        role = ro;
        if(status == 1) {
            nickname = nn;
            sex = (s == 0) ? "女" : "男";
            sign = sg;
            avatar = ava;
        }

    }
    public String getNickname(){
        return nickname;
    }
    public String getSex(){
        return sex;
    }
    public String getSign(){
        return sign;
    }
    public String getAvatar(){
        return avatar;
    }
    public int getAccum(){
        return accum;
    }
    public int getStatus(){
        return status;
    }
    public int getRole(){
        return role;
    }
    public int getMomentNo(){
        return momentNo;
    }
    public int getMessageNo(){
        return messageNo;
    }
}
