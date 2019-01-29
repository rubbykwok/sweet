package servlets;

import dao.MomentDao;
import dao.UserDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.Random;

@MultipartConfig
public class Moment extends HttpServlet {
    public Connection conn = null;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request,response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        conn = UserDao.connect();
        //ip地址
        String ip = request.getRemoteAddr();
        //token
        String token = request.getParameter("token");
        //标题
        String title = request.getParameter("title");
        //标签
        String[] tagstr = request.getParameterValues("tag");
        //所需材料
        String  material = request.getParameter("material");
        //简介
        String introduction = request.getParameter("introduction");
        //步骤
        String stepStr = request.getParameter("step-no");
        int stepNo = 0;
        if(stepStr!=null){
            stepNo = Integer.parseInt(stepStr);
        }

        Random random = new Random();
        String rootSrc = "e:\\homework\\moment\\";//根目录路径
        int momentId = -1;

        //成品
        String finish = request.getParameter("finish-info");
        Part finishImg = request.getPart("finish-img");

        if(token!=null && title!=null && tagstr!=null && material!=null && stepStr!=null && finish!=null && finishImg!=null ) {
            int userid = UserDao.isTokenValid(conn, token);
            int tagNo = tagstr.length;
            //标签数组
            int[] tag = new int[tagNo];
            for (int i = 0; i < tagNo; i++) {
                tag[i] = Integer.parseInt(tagstr[i]);
            }

            //成品
            String finImgName ="fin_" + random.nextInt() + ".jpg";//图片名

            File imgFile = new File(rootSrc + finImgName);
            while (imgFile.exists()) {
                finImgName = "fin_" + random.nextInt() + ".jpg";
                imgFile = new File(rootSrc + finImgName);
            }
            imgFile.createNewFile();
            finishImg.write(rootSrc + finImgName);
            //插入数据
            momentId = MomentDao.insertMoment(conn, userid, title, tagNo, tag, introduction, material, stepNo, ip, finish, rootSrc+finImgName);

            //插入步骤信息
            for (int i = 1; i <= stepNo; i++) {
                Part stepImg = request.getPart("step" + i + "-file");
                String stepInfo = request.getParameter("step" + i + "-content");
                String stepImgName = "noImg";
                //步骤图片
                if (stepImg != null) {
                    //步骤图片
                    stepImgName = "step_" + random.nextInt() + ".jpg";
                    File stepFile = new File(rootSrc + stepImgName);
                    while (stepFile.exists()) {
                        stepImgName = "step_" + random.nextInt() + ".jpg";
                        stepFile = new File(rootSrc + stepImgName);
                    }
                    stepFile.createNewFile();
                    stepImg.write(rootSrc + stepImgName);
                }
                //步骤说明
                if (stepInfo != null) {
                    MomentDao.insertStep(conn, momentId, i, rootSrc + stepImgName, stepInfo);
                }
            }
            response.sendRedirect("/page/article.jsp?id=" + momentId);
            return;
        }

        //评论
        String comment = request.getParameter("comment-content");
        Part commentImg = request.getPart("comment-img");
        String moIdStr = request.getParameter("mo-id");
        if(comment!=null && commentImg!=null && moIdStr!= null){
            int momentid = Integer.parseInt(moIdStr);
            int userid = UserDao.isTokenValid(conn, token);
            String imgName = "com_" + random.nextInt() + ".jpg";//图片名
            File imgFile = new File(rootSrc + imgName);
            while (imgFile.exists()) {
                imgName = "com_" + random.nextInt() + ".jpg";
                imgFile = new File(rootSrc + imgName);
            }
            imgFile.createNewFile();
            commentImg.write(rootSrc + imgName);
            MomentDao.insertComment(conn,userid,momentid,comment,rootSrc+imgName,ip);
            response.sendRedirect("/page/article.jsp?id=" + momentid);
            return;
        }
        //回复评论
        String reply = request.getParameter("reply");
        String comIdStr = request.getParameter("com-id");
        if(reply !=null && comIdStr !=null){
            int momentid = Integer.parseInt(moIdStr);
            int commentid = Integer.parseInt(comIdStr);
            int userid = UserDao.isTokenValid(conn,token);
            MomentDao.insertReply(conn,userid,commentid,reply,ip);
            response.sendRedirect("/page/article.jsp?id=" + momentid);
            return;
        }

    }

}
