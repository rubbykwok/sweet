package dao;

import util.Comment;
import util.Moment;
import util.Reply;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


/**
 * Created by Administrator on 2017/12/20.
 */
public class MomentDao {
    public static  int insertMoment(Connection conn,int userid,String title,int tagNo,int[] tag,String intro,String material,int stepNo,String ip,String fin,String finImg){
        String sql = null;
        ResultSet rs = null;
        PreparedStatement ptmt;
        int momentid = -1;
        try {
            sql = "INSERT INTO moment(mo_userid,mo_title,mo_introduction,mo_tagno,mo_material,mo_stepno,mo_finishinfo,mo_finishimg,mo_time,mo_ip)" +
                    "VALUE (?,?,?,?,?,?,?,?,now(),?)";
            ptmt = conn.prepareStatement(sql,PreparedStatement.RETURN_GENERATED_KEYS);
            ptmt.setInt(1, userid);
            ptmt.setString(2, title);
            ptmt.setString(3, intro);
            ptmt.setInt(4, tagNo);
            ptmt.setString(5, material);
            ptmt.setInt(6, stepNo);
            ptmt.setString(7, fin);
            ptmt.setString(8, finImg);
            ptmt.setString(9, ip);
            ptmt.execute();
            //插入标签
            rs = ptmt.getGeneratedKeys();
            if (rs.next()){
                momentid = rs.getInt(1);
            }
            for (int i=0 ; i < tagNo;i++){
                sql = "INSERT INTO moment_tag(mo_id,tag_id) VALUE (?,?)";
                ptmt = conn.prepareStatement(sql);
                ptmt.setInt(1,momentid);
                ptmt.setInt(2,tag[i]);
                ptmt.execute();
            }
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return momentid;
    }
    public static void insertStep(Connection conn,int momentId,int stepNo,String img,String stepInfo){
        String sql = null;
        PreparedStatement ptmt;
        try{
            sql = "INSERT INTO moment_step(s_no,mo_id,s_img,s_info)" +
                    "VALUE (?,?,?,?)";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,stepNo);
            ptmt.setInt(2,momentId);
            ptmt.setString(3,img);
            ptmt.setString(4, stepInfo);
            ptmt.execute();
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void getMomentInfo(Connection conn, Moment moment){
        int id = moment.id;
        String sql;
        PreparedStatement ptmt;
        ResultSet rs = null;
        try{
            sql="SELECT * FROM momentView WHERE mo_id=?" ;
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            rs = ptmt.executeQuery();
            while (rs.next()){
                moment.status = rs.getInt("mo_status");
                moment.userName = rs.getString("user_nickname");
                moment.userAvatar = rs.getString("user_avatar");
                moment.title = rs.getString("mo_title");
                moment.date = rs.getString("mo_time");
                moment.tagNo = rs.getInt("mo_tagno");
                moment.introduction = rs.getString("mo_introduction");
                moment.material = rs.getString("mo_material");
                moment.stepNo = rs.getInt("mo_stepno");
                moment.finImg = rs.getString("mo_finishimg");
                moment.finInfo = rs.getString("mo_finishinfo");
                moment.collectionNo = rs.getInt("mo_collection_no");
                moment.commentNo = rs.getInt("mo_comment_no");
            }
            //初始化moment的数组
            moment.tag = new String[moment.tagNo];
            moment.stepImg = new String[moment.stepNo];
            moment.stepInfo = new String[moment.stepNo];
            moment.comments =new Comment[moment.commentNo];
            for(int i=0;i<moment.commentNo;i++){
                moment.comments[i] = new Comment();
            }
            //标签信息
            sql="SELECT * FROM tagView WHERE mo_id=?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            rs = ptmt.executeQuery();
            for (int i =0; rs.next(); i++){
                moment.tag[i] = rs.getString("tag_info");
            }
            //步骤信息
            sql="SELECT * FROM moment_step WHERE mo_id=? ORDER BY s_no";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,id);
            rs = ptmt.executeQuery();
            for (int i = 0; rs.next() ; i++){
                moment.stepInfo[i]=rs.getString("s_info");
                moment.stepImg[i]=rs.getString("s_img");
            }
            moment.setFinImgBase64();//将图片转换成base64格式
            moment.setStepImgBase64();

            //评论信息
            if(moment.commentNo>0) {
                sql = "SELECT * FROM commentView WHERE c_momentid= ?";
                ptmt = conn.prepareStatement(sql);
                ptmt.setInt(1, id);
                rs = ptmt.executeQuery();
                String reSql;
                PreparedStatement rePtmt = null;
                ResultSet reRs;
                for (int i = 0; rs.next(); i++) {
                    moment.comments[i].id = rs.getInt("c_id");
                    moment.comments[i].date = rs.getString("c_time");
                    moment.comments[i].status = rs.getInt("c_status");
                    moment.comments[i].info = rs.getString("c_info");
                    moment.comments[i].userName = rs.getString("user_nickname");
                    moment.comments[i].userImg = rs.getString("user_avatar");
                    moment.comments[i].infoImg = rs.getString("c_img");
                    moment.comments[i].replyNo = rs.getInt("c_replyno");
                    moment.comments[i].likeNo = rs.getInt("c_likeno");
                    moment.comments[i].setImgBase64();
                    //评论的回复信息
                    if(moment.comments[i].replyNo > 0) {
                        moment.comments[i].replies = new Reply[moment.comments[i].replyNo];
                        for (int j = 0; j < moment.comments[i].replyNo; j++) {
                            moment.comments[i].replies[j] = new Reply();
                        }
                        reSql = "SELECT * FROM replyView WHERE re_comid=? AND re_status= 1";
                        rePtmt = conn.prepareStatement(reSql);
                        rePtmt.setInt(1, moment.comments[i].id);
                        reRs = rePtmt.executeQuery();
                        for (int j = 0; reRs.next(); j++) {
                            moment.comments[i].replies[j].status = reRs.getInt("re_status");
                            moment.comments[i].replies[j].info = reRs.getString("re_info");
                            moment.comments[i].replies[j].userName = reRs.getString("user_nickname");
                            moment.comments[i].replies[j].date = reRs.getString("re_time");
                        }
                    }
                }
            }
            ptmt.close();
         }catch (Exception e){
            e.printStackTrace();
        }
    }
    public static void getIndexInfo(Connection conn,Moment[] moments){
        String sql;
        PreparedStatement ptmt = null;
        ResultSet rs = null;
        try{
            sql = "SELECT mo_id,mo_title,mo_time,mo_introduction,mo_tagno,mo_finishimg,mo_collection_no,mo_comment_no,user_nickname,user_avatar FROM momentView WHERE mo_status = 1  ORDER BY mo_time DESC ";
//                    +" ORDER BY mo_time DESC limit "
//                    +(page -1)*8+",8";
            ptmt = conn.prepareStatement(sql);
            rs = ptmt.executeQuery();
            for(int i =0;rs.next(); i++) {
                moments[i].id = rs.getInt("mo_id");
                moments[i].userName = rs.getString("user_nickname");
                moments[i].userAvatar = rs.getString("user_avatar");
                moments[i].title = rs.getString("mo_title");
                moments[i].date = rs.getString("mo_time");
                moments[i].tagNo = rs.getInt("mo_tagno");
                moments[i].introduction = rs.getString("mo_introduction");
                moments[i].finImg = rs.getString("mo_finishimg");
                moments[i].collectionNo = rs.getInt("mo_collection_no");
                moments[i].commentNo = rs.getInt("mo_comment_no");
                moments[i].tag = new String[moments[i].tagNo];
                moments[i].setFinImgBase64();
                //标签信息
                String tsql="SELECT * FROM tagView WHERE mo_id=?";
                PreparedStatement tptmt = conn.prepareStatement(tsql);
                tptmt.setInt(1,moments[i].id);
                ResultSet trs = tptmt.executeQuery();
                for (int j =0; trs.next(); j++){
                    moments[i].tag[j] = trs.getString("tag_info");
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }
    public static int getMomentNo(Connection conn){
        String sql;
        PreparedStatement ptmt = null;
        ResultSet rs;
        int n = 0;
        try {
            sql = "SELECT COUNT(mo_id) FROM moment WHERE mo_status = 1 ";
            ptmt = conn.prepareStatement(sql);
            rs = ptmt.executeQuery();
            while (rs.next()){
                n = rs.getInt("count(mo_id)");
            }
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return n;
    }

    //插入评论
    public static void insertComment(Connection conn,int userid,int momentid, String comment, String img, String ip){
        String sql = null;
        ResultSet rs = null;
        PreparedStatement ptmt;
        try {
            //插入评论
            sql = "INSERT INTO moment_comment(c_momentid,c_userid,c_info,c_img,c_time,c_ip)" +
                    "VALUE (?,?,?,?,now(),?)";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,momentid);
            ptmt.setInt(2,userid);
            ptmt.setString(3,comment);
            ptmt.setString(4, img);
            ptmt.setString(5, ip);
            ptmt.execute();
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    //插入评论回复
    public static void insertReply(Connection conn, int userid, int commentid,String reply,String ip){
        String sql = null;
        ResultSet rs = null;
        PreparedStatement ptmt;
        try {
            //插入评论
            sql = "INSERT INTO moment_com_reply(re_comid,re_userid,re_info,re_time,re_ip)" +
                    "VALUE (?,?,?,now(),?)";
            ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1,commentid);
            ptmt.setInt(2,userid);
            ptmt.setString(3,reply);
            ptmt.setString(4,ip);
            ptmt.execute();
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //搜索
    public static void searchMoment(Connection conn,Moment moment , ResultSet rs){
        try {
            moment.id = rs.getInt("mo_id");
            moment.userName = rs.getString("user_nickname");
            moment.userAvatar = rs.getString("user_avatar");
            moment.title = rs.getString("mo_title");
            moment.date = rs.getString("mo_time");
            moment.tagNo = rs.getInt("mo_tagno");
            moment.introduction = rs.getString("mo_introduction");
            moment.finImg = rs.getString("mo_finishimg");
            moment.collectionNo = rs.getInt("mo_collection_no");
            moment.commentNo = rs.getInt("mo_comment_no");
            moment.tag = new String[moment.tagNo];
            moment.setFinImgBase64();
            //标签信息
            String tsql = "SELECT * FROM tagView WHERE mo_id=?";
            PreparedStatement tptmt = conn.prepareStatement(tsql);
            tptmt.setInt(1, moment.id);
            ResultSet trs = tptmt.executeQuery();
            for (int j = 0; trs.next(); j++) {
                moment.tag[j] = trs.getString("tag_info");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
