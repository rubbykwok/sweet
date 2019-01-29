<%@ page import="dao.UserDao" %>
<%@ page import="util.User" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="util.MyCookie" %>
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
  <link rel="stylesheet" href="../lib/css/snackbar.css">
  <link rel="stylesheet" href="../lib/css/normalize.css">
  <link rel="stylesheet" href="../lib/css/animate.css">
  <link rel="stylesheet" href="./css/index.css">
  <link rel="stylesheet" href="./css/icon.css">
  <link rel="stylesheet" href="./css/nav.css">
  <link rel="stylesheet" href="./css/article.css">
  <!-- dev -->

  <!-- prod -->
  <!-- <link rel="stylesheet" href=".css/app.css">   -->
  <!-- prod -->
  <title>文章详情</title>
</head>

<body>
  <%
    String momentIdStr = request.getParameter("id");
    Moment moment = new Moment();
    if(momentIdStr != null){
       moment.id= Integer.parseInt(momentIdStr);
    }else {
        response.sendRedirect("err.jsp");
    }
    String token = MyCookie.get(request,"token");
    Connection conn = UserDao.connect();
    User user = new User();
    int userId;
    if(token!=null && (userId =UserDao.isTokenValid(conn,token)) > 0){
      user.isLogin = true;
      UserDao.getUserInfo(conn,user,userId);
    }
    MomentDao.getMomentInfo(conn,moment);
    if(moment.status == 0)
      response.sendRedirect("err.jsp");
  %>
  <nav id="nav__wrapper">
    <div id="nav">
      <div id="nav__brand">
        <a href="index.jsp" style="text-decoration: none;">
        <img id="brand" src="../assets/brand.png" alt="甜甜圈" height="64" style="vertical-align:middle">
        </a>
      </div>
    </div>
  </nav>
  <div class="container">
    <section id="article">
      <header id="info">
        <div id="info__op">
          <%
            if(user.getRole() == 0){
          %>
          <a id="op__del" href="javascript:void(0)">删除此篇文章</a>
          <%
            }
          %>
          <i id="op__fav" class="heart"></i>
        </div>

        <div class="flex">
          <img id="info__img" src="<%=moment.finImgBase64%>">
          <div id="info__text">
            <p style="overflow: hidden;">
              <span id="info__title"><%=moment.title%></span>
              <span id="info__date"><%=moment.date%></span>
            </p>
            <p>
              <img id="info__avatar" src="<%=moment.userAvatar%>" alt="头像" width="36">
              <span id="info__author-name"><%=moment.userName%></span>
            </p>
            <p id="info__abstract">
              <%=moment.introduction%>
            </p>
          </div>
        </div>
        <div id="info__tags">
          <i class="tag"></i>
          <%
            for(int i = 0;i<moment.tagNo;i++){
          %>
          <span class="info__tag"><%=moment.tag[i]%></span>
          <%
            }
          %>
        </div>
      </header>
      <article id="material">
        <header class="label">所需材料</header>
        <p class="material__desc"><%=moment.material%></p>
      </article>
      <article id="step">
        <header class="label">做法步骤</header>
        <%
          for(int i = 0; i< moment.stepNo ; i++){
        %>
        <section class="step-n">
          <h3>第<%=i+1%>步</h3>
          <div class="flex">
            <img class="step__img" src="<%=moment.stepImgBase64[i]%>" alt="" width="140">
            <p class="step__desc"><%=moment.stepInfo[i]%></p>
          </div>
        </section>
        <%
          }
        %>
      </article>

      <article id="finished">
        <header class="label">成品</header>
        <img src="<%=moment.finImgBase64%>" alt="成品" style="width: 100%; margin-top: 20px;">
        <p class="finished__desc"><%=moment.finInfo%></p>
      </article>
      <footer id="op">
        <button id="fav">
          <span>收藏</span>
          <i class="heart"></i>
        </button>
        <button id="make-comment">
          <span>评论</span>
        </button>
      </footer>
    </section>
    <section id="input-comment__wrapper">

      <form action="/moment" method="post" enctype="multipart/form-data">
        <div class="flex">
          <div id="comment__upload-wrapper">
            <input type="file" name="comment-img" id="comment__file" accept="image/*">
            <button id="comment__upload-btn">
              <i class="upload"></i>
              <span>上传文件</span>
            </button>
            <div id="comment__upload-preview" class="hid">
              <button id="comment__upload-cancel">
                <i class="cancel"></i>
              </button>
            </div>
          </div>
          <textarea name="comment-content" id="comment__input" cols="30" rows="10"></textarea>
        </div>
        <input type="hidden" name="mo-id" value="<%=moment.id%>">
        <input type="hidden" name="token" value="<%=token%>">
        <button id="comment__submit">评论</button>
      </form>

    </section>
    <h2 style="font-weight:500">评论</h2>
    <section id="comments-list">
      <%
        for(int i = 0; i < moment.commentNo ; i++){
      %>
      <div class="comment">
        <div class="flex">
          <img class="comment__avatar" src="<%=moment.comments[i].userImg%>" alt="头像" width="64">
          <div class="flex comment__content">
            <img class="content__img" src="<%=moment.comments[i].comImgBase64%>">
            <div class="content__text" >
              <%=moment.comments[i].info%>
            </div>
          </div>
        </div>
        <div class="comment__op">
          <a class="comment__op-reply" href="javascript:void(0)" onclick="showReply(this)">回复</a>
          <a class="comment__op-fav" href="javascript:void(0)">
            <span style="vertical-align: middle">点赞</span><i class="thumb-up"></i>
          </a>
        </div>
          <form class="flex reply__wrapper hid" method="post" action="/moment" enctype="multipart/form-data" >
            <input type="text" name="reply" class="reply__content">
            <input type="hidden" name="com-id" value="<%=moment.comments[i].id%>">
            <input type="hidden" name="token" value="<%=token%>">
            <input type="hidden" name="mo-id" value="<%=moment.id%>">
            <button class="reply__btn">回复</button>
          </form>
      </div>
      <%
        if(moment.comments[i].replyNo > 0){
      %>
      <p id="reply-op">回复内容：</p>
      <div class="comment__replies">
        <%
          for(int j = 0; j <moment.comments[i].replyNo ; j++){
        %>
        <div class="comment__reply">
          <div class="flex flex-start">
            <p class="comment__reply-nickname"><%=moment.comments[i].replies[j].userName%>: </p>
            <p class="comment__reply-content">
              <%=moment.comments[i].replies[j].info%>
            </p>
          </div>
          <div class="comment__reply-time">
            <%=moment.comments[i].replies[j].date%>
          </div>
        </div>
        <%
          }//for(replyNo)
        %>
      </div>
      <%
          }//for(commentNo)
        }//if(replyNo>0)
      %>
    </section>
  </div>
  <script src="../lib/js/shim.js"></script>
  <script src="../lib/js/tool.js"></script>
  <script src="./article.js"></script>
  <script src="../lib/js/dialog.js"></script>
  <script src="../lib/js/snackbar.js"></script>
</body>

</html>