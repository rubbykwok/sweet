package servlets;

import dao.UserDao;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

/**
 * Created by Administrator on 2017/12/18.
 */
public class Register extends HttpServlet{
    public Connection conn = null;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter pw = response.getWriter();

        conn = UserDao.connect();
        //新用户注册
        String usrIP = request.getRemoteAddr();
        String newUsr = request.getParameter("username");
        String newPwd = request.getParameter("password");
        if(usrIP!=null && newPwd!=null){
            if(newPwd.length()>=6 &&UserDao.registerCheck(conn,newUsr,newPwd,usrIP)){
                pw.write("OK");
            }else {
                pw.write("ERR");
            }
        }

        //完善资料
        String nickname = request.getParameter("nickname");
        String sex = request.getParameter("sex");
        String sign = request.getParameter("sign");
        String token = request.getParameter("token");
        int id;
        if(nickname!=null && sex!=null && sign!=null){
            if((id = UserDao.isTokenValid(conn,token)) > 0) {
                int s = sex.equals("1") ? 1 : 0;
                String avatarSrc = "";
                if (s == 1) {
                    avatarSrc = "/assets/avatar/avatar_boy_1.jpg";
                } else if (s == 0) {
                    avatarSrc = "/assets/avatar/avatar_girl_1.jpg";
                }
                UserDao.improveInfo(conn, nickname, s, avatarSrc, sign, id);
                pw.write("OK");
            }else {
                pw.write("ERR");
            }
        }
    }
}
