package dao;

import util.Token;
import util.User;

import java.sql.*;

/**
 * Created by Administrator on 2017/12/18.
 */
public class UserDao {
    //获取数据库链接
    public static Connection connect(){
        Connection conn = null;
        try {
            //获取数据库连接
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://172.31.75.246:3306/S2015150129?useUnicode=true&characterEncoding=utf-8", "S2015150129", "25666926");
        }catch (Exception e){
            e.printStackTrace();
        }
        return conn;
    }

    //注册操作，向表插入新用户信息
    public static boolean registerCheck(Connection conn,String usr,String pwd,String ip){
        String sql ;
        String token = Token.createToken(usr);
        try{
            PreparedStatement ptmt;
            ResultSet rs = null;
            //查询用户名是否被注册
            sql = "SELECT user_name FROM user WHERE user_name = ?";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1,usr);
            rs=ptmt.executeQuery();
            if(rs.next())
                return false;
            //插入新用户
            sql = "INSERT INTO user(user_name,user_pwd,user_registime,user_regisip,user_token)" +
                    "VALUE (?,password(?),now(),?,?)";
            ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, usr);//用户名
            ptmt.setString(2, pwd);//密码，用password()存储到数据库
            ptmt.setString(3, ip);//注册客户端ip地址
            ptmt.setString(4, token);//用户的token
            ptmt.execute();
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return true;
    }

    //登陆操作，返回用户名密码是否正确
    public static boolean loginCheck(Connection conn,String username,String pwd){
        String sql;
        ResultSet rs = null;
        try{
            sql = "SELECT user_name FROM user " +
                    "WHERE user_name= ? AND user_pwd=password(?)";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, username);//用户名
            ptmt.setString(2, pwd);//密码，用password()存储到数据库
            rs=ptmt.executeQuery();
            return rs.next();
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    //返回该用户的token(每个用户会由用户名和随机数利用SHA1生成固定的token)
    public static String getToken(Connection conn,String usr){
        String sql;
        String token = null;
        ResultSet rs = null;
        try{
            sql="SELECT user_token FROM user WHERE user_name= ?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, usr);//用户名
            rs=ptmt.executeQuery();
            if(rs.next()){
                token = rs.getString("user_token");
            }
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
        return token;
    }

    //查询token是否合法的结果,返回所在的user_id
    public static int isTokenValid(Connection conn,String token){
        String sql;
        ResultSet rs = null;
        int id = 0;
        try{
            sql="SELECT user_id FROM user WHERE user_token=? ";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, token);//用户名
            rs = ptmt.executeQuery();
            while(rs.next()){
                id = rs.getInt("user_id");
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return id;
    }

    //返回用户权限
    public static int getUserRole(Connection conn,int id){
        String sql;
        ResultSet rs = null;
        int role = -1;
        try{
            sql="SELECT user_role FROM user WHERE user_id=?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, id);//用户名
            rs = ptmt.executeQuery();
            while(rs.next()){
                role = Integer.parseInt(rs.getString("user_role"));
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return role;
    }

    //返回用户信息
    public static void getUserInfo(Connection conn, User user, int id){
        String sql;
        ResultSet rs = null;
        try{
            sql="SELECT * FROM user WHERE user_id=?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setInt(1, id);//用户名
            rs = ptmt.executeQuery();
            while(rs.next()){
                user.setInfo(rs.getString("user_name"),
                        rs.getString("user_nickname"),
                        rs.getInt("user_sex"),
                        rs.getString("user_sign"),
                        rs.getString("user_avatar"),
                        rs.getInt("user_accum"),
                        rs.getInt("user_moment_no"),
                        rs.getInt("user_message_no"),
                        rs.getInt("user_status"),
                        rs.getInt("user_role"));
            }
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    //完善资料 更新用户信息
    public static void improveInfo(Connection conn,String nickname,int sex,String avatar,String sign,int id){
        String sql;
        try{
            sql ="UPDATE user SET user_nickname=?,user_sex=?,user_avatar=?,user_sign=?,user_status=1 WHERE user_id=?";
            PreparedStatement ptmt = conn.prepareStatement(sql);
            ptmt.setString(1, nickname);
            ptmt.setInt(2, sex);
            ptmt.setString(3, avatar);
            ptmt.setString(4, sign);
            ptmt.setInt(5, id);
            ptmt.executeUpdate();
            ptmt.close();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
}
