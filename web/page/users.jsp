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
  <link rel="stylesheet" href="./css/moments.css">
  <link rel="stylesheet" href="./css/icon.css">
  <link rel="stylesheet" href="./css/nav.css">
  <link rel="stylesheet" href="./css/user.css">
  <!-- dev -->

  <!-- prod -->
  <!-- <link rel="stylesheet" href=".css/app.css">   -->
  <!-- prod -->
  <title>用户</title>
</head>

<body>
  <nav id="nav__wrapper">
    <div id="nav">
      <div id="nav__brand">
        <img id="brand" src="../assets/brand.png" alt="甜甜圈" height="64" style="vertical-align:middle">
      </div>
    </div>
  </nav>

  <div id="user" class="container" style="width:768px">
    <header class="flex">
      <img id="user__avatar" src="../assets/avatar2.jpg" alt="用户头像">
      <div id="user__info">
        <p>
          <span id="user__nickname">郭毛毛</span>
          <span id="user__sex">女</span>
        </p>
        <p id="user__point">
          <span class="label">当前积分：</span>
          520
        </p>
        <p id="user__sign">
          <span class="label">个性签名：</span>
          最爱阿土了！
        </p>
      </div>
    </header>
    <section id="others">
      <h3 style="font-weight:500">TA的日志</h3>
      <div class="moment">
        <article class="moment__content">
          <img class="moment__img" src="../assets/1.jpg" alt="图片">
          <div>
            <a class="moment__title" href="article.jsp?id=0613">今天去体检</a>
            <span class="moment__publish-date">2017-11-24</span>
            <p class="moment__desc">小阿小阿红，背着书包上学堂，不怕太阳晒，不怕风雨打</p>
          </div>
        </article>
        <footer class="moment__footer">
          <div class="moment__tags">
            <i class="tag"></i>
            <span class="moment__tag">阿红</span>
            <span class="moment__tag">傻猪</span>
            <span class="moment__tag">piggy</span>
            <span class="moment__tag">阿红</span>
          </div>
          <div class="moment__popularity">
            <span class="moment__com-cnt">评论(63)</span>
            <span class="moment__fav-cnt">收藏(99)</span>
          </div>
        </footer>
      </div>
      <div class="moment">
        <article class="moment__content">
          <img class="moment__img" src="../assets/1.jpg" alt="图片">
          <div>
            <a class="moment__title" href="article.jsp?id=0613">今天去体检</a>
            <span class="moment__publish-date">2017-11-24</span>
            <p class="moment__desc">小阿小阿红，背着书包上学堂，不怕太阳晒，不怕风雨打</p>
          </div>
        </article>
        <footer class="moment__footer">
          <div class="moment__tags">
            <i class="tag"></i>
            <span class="moment__tag">阿红</span>
            <span class="moment__tag">傻猪</span>
            <span class="moment__tag">piggy</span>
            <span class="moment__tag">阿红</span>
          </div>
          <div class="moment__popularity">
            <span class="moment__com-cnt">评论(63)</span>
            <span class="moment__fav-cnt">收藏(99)</span>
          </div>
        </footer>
      </div>
      <div class="moment">
        <article class="moment__content">
          <img class="moment__img" src="../assets/1.jpg" alt="图片">
          <div>
            <a class="moment__title" href="article.jsp?id=0613">今天去体检</a>
            <span class="moment__publish-date">2017-11-24</span>
            <p class="moment__desc">小阿小阿红，背着书包上学堂，不怕太阳晒，不怕风雨打</p>
          </div>
        </article>
        <footer class="moment__footer">
          <div class="moment__tags">
            <i class="tag"></i>
            <span class="moment__tag">阿红</span>
            <span class="moment__tag">傻猪</span>
            <span class="moment__tag">piggy</span>
            <span class="moment__tag">阿红</span>
          </div>
          <div class="moment__popularity">
            <span class="moment__com-cnt">评论(63)</span>
            <span class="moment__fav-cnt">收藏(99)</span>
          </div>
        </footer>
      </div>
    </section>
  </div>
  <script src="../lib/js/shim.js"></script>
  <script src="../lib/js/tool.js"></script>
</body>

</html>