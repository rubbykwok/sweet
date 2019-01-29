package util;

public class Comment {
    public int id;
    public String info;
    public String userName;
    public String userImg;
    public String infoImg;
    public int replyNo;
    public Reply[] replies;
    public int likeNo;
    public String date;
    public int status;
    public String comImgBase64;
    public void setImgBase64() {
        comImgBase64 = ToBase64.getImageStr(infoImg);
    }
}
