<%@ page import="java.sql.Connection" %>
<%@ page import="dao.UserDao" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.Moment" %>
<%@ page import="dao.MomentDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
  <meta http-equiv="X-UA-Compatible" content="ie=edge, chrome=1">
  <meta name="description" content="">
  <meta name="keywords" content="">
  <meta name="author" content="">
  <meta name="copyright" content="">
  <link rel="shortcut icon" href="../assets/favicon.ico" type="image/x-icon">
  <!-- dev -->
  <link rel="stylesheet" href="../lib/css/normalize.css">
  <link rel="stylesheet" href="../lib/css/animate.css">
  <link rel="stylesheet" href="../lib/css/dialog.css">
  <link rel="stylesheet" href="./css/index.css">
  <link rel="stylesheet" href="./css/moments.css">
  <link rel="stylesheet" href="./css/filter.css">
  <link rel="stylesheet" href="./css/icon.css">
  <link rel="stylesheet" href="./css/nav.css">
  <link rel="stylesheet" href="./css/result.css">
  <!-- dev -->

  <!-- prod -->
  <!-- <link rel="stylesheet" href=".css/app.css">   -->
  <!-- prod -->
  <title>搜索结果</title>
</head>

<body>
  <!-- brand-bar begin-->
  <nav id="nav__wrapper">
    <div id="nav">
      <div id="nav__brand">
        <a href="index.jsp" style="text-decoration: none;">
          <img id="brand" src="../assets/brand.png" alt="甜甜圈" height="64" style="vertical-align:middle">
        </a>
      </div>
    </div>
  </nav>
  <!-- brand-bar end -->
<%
   request.setCharacterEncoding("utf-8");
   String key = request.getParameter("content");

%>
  <div class="container">
    <section class="main__wrapper main__wrapper--active">
      <header id="search__wrapper">
        <form action="">
          <input name="content" type="text" id="search__input">
          <button id="search__btn">
            <span>搜索</span>
            <i class="search"></i>
          </button>
        </form>
      </header>

      <section class="moment-list">

        <%
          Connection conn = UserDao.connect();
          if(key!=null){
            String sql;
            PreparedStatement ptmt = null;
            ResultSet rs;
            key = new String(key.getBytes("ISO-8859-1"), "UTF-8");
            try {
              sql = "SELECT * FROM momentView " +
                      "WHERE mo_status = 1 AND (mo_title LIKE ? " +
                      "OR mo_introduction LIKE ?) ";
              ptmt = conn.prepareStatement(sql);
              ptmt.setString(1,"%"+key+"%");
              ptmt.setString(2,"%"+key+"%");
              rs = ptmt.executeQuery();

              while (rs.next()){
                Moment moment = new Moment();
                MomentDao.searchMoment(conn,moment,rs);
        %>

        <div class="moment">
          <img class="moment__author-avatar" src="<%=moment.userAvatar%>" alt="作者头像">
          <section class="moment__detail">
            <div class="moment__arrow-bottom"></div>
            <div class="moment__arrow-top"></div>
            <header class="moment__header">
              <div>
                <a class="moment__title" href="article.jsp?id=<%=moment.id%>"><%=moment.title%></a>
                <span class="moment__publish-date"><%=moment.date%></span>
              </div>
              <div class="moment__fav-icon">
                <i class="heart"></i>
              </div>
            </header>
            <article class="moment__content">
              <img class="moment__img" src="<%=moment.finImgBase64%>" alt="图片">
              <p class="moment__desc"><%=moment.introduction%></p>
            </article>
            <footer class="moment__footer">
              <div class="moment__tags">
                <i class="tag"></i>
                <%
                  for(int j = 0;j<moment.tagNo;j++){
                %>
                <span class="moment__tag"><%=moment.tag[j]%></span>
                <%
                  }
                %>
              </div>
              <div class="moment__popularity">
                <span class="moment__com-cnt">评论(<%=moment.commentNo%>)</span>
                <span class="moment__fav-cnt">收藏(<%=moment.collectionNo%>)</span>
              </div>
            </footer>
          </section>
        </div>
        <%
              }
              ptmt.close();
            }catch (Exception e){
              e.printStackTrace();
            }
          }
        %>

      </section>
    </section>
  </div>

  <script src="../lib/js/shim.js"></script>
  <script src="../lib/js/tool.js"></script>
</body>

</html>