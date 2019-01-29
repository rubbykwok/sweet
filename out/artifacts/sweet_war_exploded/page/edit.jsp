<%@ page import="java.sql.Connection" %>
<%@ page import="dao.UserDao" %>
<%@ page import="util.User" %>
<%@ page import="util.MyCookie" %>
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
  <link rel="stylesheet" href="./css/index.css">
  <link rel="stylesheet" href="./css/icon.css">
  <link rel="stylesheet" href="./css/nav.css">
  <link rel="stylesheet" href="./css/filter.css">
  <link rel="stylesheet" href="./css/edit.css">

  <!-- dev -->

  <!-- prod -->
  <!-- <link rel="stylesheet" href=".css/app.css">   -->
  <!-- prod -->
  <title>写日志</title>
</head>

<body>
<%
    String token = MyCookie.get(request,"token");
    Connection conn = UserDao.connect();
    User user = new User();
    int userId;
    if(token!=null && (userId = UserDao.isTokenValid(conn,token)) > 0){
        user.isLogin = true;
        UserDao.getUserInfo(conn,user,userId);
    }else{
        response.sendRedirect("index.jsp?login=false");
    }
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

  <div class="container" style="width:768px">
    <form action="/moment" enctype="multipart/form-data" method="post" id="edit-form">
      <div class="input-wrapper">
        <label for="title">标题</label>
        <input type="text" name="title" id="title">
      </div>
      <p class="tips" id="title-tip">请输入标题</p>
      <div class="input-wrapper">
        <label for="tag-wrapper">标签</label>
        <div id="tag-wrapper" class="filter">
          <div>
            <input name="tag" id="country__chinese" type="checkbox" value="1">
            <label for="country__chinese">中式甜品</label>
            <input name="tag" id="country__west" type="checkbox" value="2">
            <label for="country__west">西式甜品</label>
            <input name="tag" id="country__japan" type="checkbox" value="3">
            <label for="country__japan">日式甜品</label>
            <input name="tag" id="taste__matcha" type="checkbox" value="4">
            <label for="taste__matcha">抹茶</label>
            <input name="tag" id="taste__fruit" type="checkbox" value="5">
            <label for="taste__fruit">水果</label>
            <input name="tag" id="taste__choco" type="checkbox" value="6">
            <label for="taste__choco">巧克力</label>
            <input name="tag" id="taste__cheese" type="checkbox" value="7">
            <label for="taste__cheese">芝士</label>
            <input name="tag" id="type__cake" type="checkbox" value="8">
            <label for="type__cake">蛋糕</label>
            <input name="tag" id="type__drink" type="checkbox" value="9">
            <label for="type__drink">饮品</label>
          </div>
          <div style="margin-top: 10px;">
            <input name="tag" id="type__tart" type="checkbox" value="10">
            <label for="type__tart">挞</label>
            <input name="tag" id="type__bread" type="checkbox" value="11">
            <label for="type__bread">面包</label>
            <input name="tag" id="type__biscuit" type="checkbox" value="12">
            <label for="type__biscuit">饼干</label>
            <input name="tag" id="type__jelly" type="checkbox" value="13">
            <label for="type__jelly">布丁</label>
            <input name="tag" id="type__ice-cream" type="checkbox" value="14">
            <label for="type__ice-cream">冰淇淋</label>
          </div>

        </div>
      </div>
      <div class="input-wrapper">
        <label for="abstract">简介</label>
        <textarea name="introduction" id="abstract" cols="30" rows="10"></textarea>
      </div>
        <p class="tips" id="introduction-tip">简介不能为空</p>
      <div class="input-wrapper">
        <label for="material">所需材料</label>
        <textarea name="material" id="material" cols="30" rows="10"></textarea>
      </div>
        <p class="tips" id="material-tip">请填写所需要的材料</p>
      <div class="input-wrapper">
        <label for="step">制作步骤</label>
        <div id="step">
          <div style="width:100%; text-align:right">
            <button id="step__add">
              <i class="add"></i>
              <span>添加步骤</span>
            </button>
          </div>
          <div class="step-n" data-step="1">
            <p class="label">第 1 步</p>
            <div class="flex">
              <input type="file" name="step1-file" class="step__file">
              <div class="step__upload-btn" title="点击添加图片"></div>
              <div class="step__upload-preview hid">
                <button class="step__upload-cancel">
                  <i class="cancel"></i>
                </button>
              </div>
              <textarea name="step1-content" cols="30" rows="10" class="step__content"></textarea>
            </div>
          </div>
        </div>
      </div>
      <input type="hidden" name="step-no" id="step-no" value="">
      <input type="hidden" name="token" value="<%=token%>">
      <div class="input-wrapper" id="end">
        <label for="end">成品</label>
        <div class="flex" style="margin-top:20px">
          <input type="file" name="finish-img" class="step__file">
          <div class="step__upload-btn" title="点击添加图片" style="margin: 0"></div>
          <div class="step__upload-preview hid" style="margin: 0">
            <button class="step__upload-cancel">
              <i class="cancel"></i>
            </button>
          </div>
          <textarea name="finish-info" cols="30" rows="10" class="step__content" style="width: 70%"></textarea>
            <p class="tips" id="finish-tip">介绍一下你的作品吧~</p>
            <p class="tips" id="img-tip">需要上传作品图作为封面图哦~</p>
        </div>
      </div>
      <button id="edit-finish" onclick="complete()" >确定</button>
    </form>
  </div>
  <script type="text/template" id="step__template">
    <div class="step-n" data-step="1">
      <p class="label">第 1 步</p>
      <div class="flex">
        <input type="file" name="step1-file" class="step__file">
        <div class="step__upload-btn" title="点击添加图片"></div>
        <div class="step__upload-preview hid">
          <button class="step__upload-cancel">
           <i class="cancel"></i>
         </button>
       </div>
       <textarea name="step1-content" cols="30" rows="10" class="step__content"></textarea>
     </div>
  </div>
  </script>
  <script src="../lib/js/shim.js"></script>
  <script src="../lib/js/tool.js"></script>
  <script src="./edit.js"></script>
</body>

</html>