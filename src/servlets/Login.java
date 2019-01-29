package servlets;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import dao.UserDao;
import util.MyCookie;

/**
 * Created by Administrator on 2017/12/18.
 */
public class Login extends HttpServlet{
    public Connection conn = null;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter pw = response.getWriter();

        conn = UserDao.connect();
        //注销
        String logout = request.getParameter("log-out");
        if(logout!=null && logout.equals("Y") ){
            MyCookie.remove(request,response,"token");
            pw.write("OK");
        }
        //登陆
        String username = request.getParameter("username");
        String pwd = request.getParameter("password");
        String auto = request.getParameter("auto-login");
        String token = null;
        Cookie[] cookies=null;
        if(username!=null && pwd!=null){
            if(UserDao.loginCheck(conn,username,pwd)) {
                token = UserDao.getToken(conn, username);
                if (auto != null && auto.equals("Y")) {
                    MyCookie.set(response, "token", token, 3600 * 12 * 7);
                } else {
                    MyCookie.set(response, "token", token, 0);
                }
                pw.write("OK");
            }else{
                pw.write("ERR");
            }
        }
    }

}
