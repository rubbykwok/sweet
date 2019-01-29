package util;

public class Moment {
    public int id;
    public int status;
    public String userName;
    public String userAvatar;
    public String title;
    public String date;
    public int tagNo;
    public String[] tag;
    public String introduction;
    public String material;
    public int stepNo;
    public String[] stepImg;
    public String[] stepInfo;
    public String finImg;
    public String finInfo;
    public int collectionNo;
    public int commentNo;
    public Comment[] comments;
    public String finImgBase64;
    public String[] stepImgBase64;
    public Moment(){
        id = -1;
    }
    public void setFinImgBase64(){
        finImgBase64 = ToBase64.getImageStr(finImg);
    }
    public void setStepImgBase64(){
        stepImgBase64 = new String[stepNo];
        for (int i =0 ;i<stepNo;i++){
            stepImgBase64[i] = ToBase64.getImageStr(stepImg[i]);
        }
    }
}
