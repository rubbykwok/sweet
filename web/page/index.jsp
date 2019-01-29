<%@ page import="util.MyCookie" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="dao.UserDao" %>
<%@ page import="util.User" %>
<%@ page import="util.Moment" %>
<%@ page import="dao.MomentDao" %>
<%@ page import="util.ToBase64" %>
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
  <link rel="stylesheet" href="../lib/css/carousel.css">
  <link rel="stylesheet" href="../lib/css/dialog.css">
  <link rel="stylesheet" href="../lib/css/snackbar.css">
  <link rel="stylesheet" href="./css/index.css">
  <link rel="stylesheet" href="./css/asidebar.css">
  <link rel="stylesheet" href="./css/moments.css">
  <link rel="stylesheet" href="./css/filter.css">
  <link rel="stylesheet" href="./css/icon.css">
  <link rel="stylesheet" href="./css/my-dialog.css">
  <link rel="stylesheet" href="./css/nav.css">
  <link rel="stylesheet" href="./css/user.css">
  <link rel="stylesheet" href="./css/msg.css">
  <link rel="stylesheet" href="./css/pagination.css">
  <!-- dev -->

  <!-- prod -->
  <!-- <link rel="stylesheet" href=".css/app.css">   -->
  <!-- prod -->
  <title>甜甜圈</title>
</head>

<body>
  <%
    String token = MyCookie.get(request,"token");
    String pagestr = request.getParameter("page");
    Connection conn = UserDao.connect();
    User user = new User();
    int userId;
    if(token!=null && (userId = UserDao.isTokenValid(conn,token)) > 0){
        user.isLogin = true;
        UserDao.getUserInfo(conn,user,userId);
    }
    int maxPage = 8;
    int currentPage = 1;//当前页数默认1
    if(pagestr!=null){
      currentPage =Integer.parseInt(pagestr);
    }

  %>
  <!-- 顶部导航栏 begin-->
  <nav id="nav__wrapper">
    <div id="nav">
      <div id="nav__brand">
        <img id="brand" src="../assets/brand.png" alt="甜甜圈" height="64" style="vertical-align:middle">
      </div>
      <ul id="nav__menu">
        <li class="nav__menu-item">
          <a class="text--active" href="#/home" data-target="home">主页</a>
          <div class="arrow animated fadeIn arrow--active"></div>
        </li>
        <li class="nav__menu-item">
          <a href="#/tutorials" data-target="tutorials">教程</a>
          <div class="arrow animated fadeIn"></div>
        </li>
        <li class="nav__menu-item">
          <a href="#/user" data-target="user">个人中心</a>
          <div class="arrow animated fadeIn"></div>
        </li>
      </ul>
      <div id="nav__search">
        <i class="search icon"></i>
        <input type="text" id="nav__search-text" placeholder="Search...">
      </div>
    </div>
  </nav>
  <!-- 顶部导航栏 end -->


  <div class="container">
    <!-- 主页 begin-->
    <section id="home" class="main__wrapper animated fadeIn main__wrapper--active">
      <!-- 轮播 begin-->
      <div id="carousel">

        <div class="carousel__item animated fadeIn carousel__item--active">
          <a href="article.jsp?id=9">
            <img class="carousel__image" src="<%=ToBase64.getImageStr("e:\\homework\\moment\\fin_330201514.jpg")%>" alt="玫瑰双重乳酪杯子蛋糕">
          </a>
        </div>
        <div class="carousel__item animated fadeIn">
          <a href="article.jsp?id=10">
            <img class="carousel__image" src="<%=ToBase64.getImageStr("e:\\homework\\moment\\fin_1721628742.jpg")%>" alt="PH大师的马卡龙">
          </a>
        </div>
        <div class="carousel__item animated fadeIn">
          <a href="article.jsp?id=1">
            <img class="carousel__image" src="<%=ToBase64.getImageStr("e:/homework/moment/fin_-425653365.jpg")%>" alt="渐变抹茶慕斯蛋糕">
          </a>
        </div>

        <div id="carousel__footer">
          <button class="carousel__btn carousel__btn--active"></button>
          <button class="carousel__btn"></button>
          <button class="carousel__btn"></button>
        </div>
      </div>
      <!-- 轮播 end-->

      <section class="moment-list">
        <%
          int total = MomentDao.getMomentNo(conn);//需要展示的教程总数
          //Moment[] moments = new Moment[maxPage];
          Moment[] moments = new Moment[total];
          for(int i =0 ; i<total ; i++){
              moments[i] = new Moment();
          }
          MomentDao.getIndexInfo(conn,moments);

          for(int i = 0 ; i < total ;i++){
        %>
        <div class="moment">
          <img class="moment__author-avatar" src="<%=moments[i].userAvatar%>" alt="作者头像">
          <section class="moment__detail">
            <div class="moment__arrow-bottom"></div>
            <div class="moment__arrow-top"></div>
            <header class="moment__header">
              <div>
                <a class="moment__title" href="article.jsp?id=<%=moments[i].id%>"><%=moments[i].title%></a>
                <span class="moment__publish-date"><%=moments[i].date%></span>
              </div>
              <div class="moment__fav-icon">
                <i class="heart"></i>
              </div>
            </header>
            <article class="moment__content">
              <img class="moment__img" src="<%=moments[i].finImgBase64%>" alt="图片">
              <p class="moment__desc"><%=moments[i].introduction%></p>
            </article>
            <footer class="moment__footer">
              <div class="moment__tags">
                <i class="tag"></i>
                <%
                  for(int j = 0;j<moments[i].tagNo;j++){
                %>
                <span class="moment__tag"><%=moments[i].tag[j]%></span>
                <%
                  }
                %>
              </div>
              <div class="moment__popularity">
                <span class="moment__com-cnt">评论(<%=moments[i].commentNo%>)</span>
                <span class="moment__fav-cnt">收藏(<%=moments[i].collectionNo%>)</span>
              </div>
            </footer>
          </section>
        </div>
        <%
          }
        %>

        <%--<script src="./pagination.min.js"></script>--%>
        <%--<script>--%>
            <%--new Pagination(document.querySelector('.moment-list'), function (page) {--%>
                <%--window.location.href = "index.jsp?page="+page;--%>
            <%--},<%=currentPage%>,1, <%=total/8+1%>, 6, true);--%>
        <%--</script>--%>

      </section>
    </section>
    <!-- 主页 end -->

    <!-- 教程 begin -->
    <section id="tutorials" class="main__wrapper animated fadeIn">
      <header class="filter">
        <form action="#">
          <section class="filter__country">
            按国家：
            <input name="tag" id="country__any" type="checkbox"><label for="country__any">不限</label>
            <input name="tag" id="country__chinese" type="checkbox"><label for="country__chinese">中式甜品</label>
            <input name="tag" id="country__west" type="checkbox"><label for="country__west">西式甜品</label>
            <input name="tag" id="country__japan" type="checkbox"><label for="country__japan">日式甜品</label>
            <input name="tag" id="country__else" type="checkbox"><label for="country__else">其它</label>
          </section>
          <section class="filter__taste">
            按口味：
            <input name="tag" id="taste__any" type="checkbox"><label for="taste__any">不限</label>
            <input name="tag" id="taste__matcha" type="checkbox"><label for="taste__matcha">抹茶</label>
            <input name="tag" id="taste__fruit" type="checkbox"><label for="taste__fruit">水果</label>
            <input name="tag" id="taste__choco" type="checkbox"><label for="taste__choco">巧克力</label>
            <input name="tag" id="taste__cheese" type="checkbox"><label for="taste__cheese">芝士</label>
            <input name="tag" id="taste__else" type="checkbox"><label for="taste__else">其它</label>
          </section>
          <section class="filter__type">
            按类别：
            <input name="tag" id="type__any" type="checkbox"><label for="type__any">不限</label>
            <input name="tag" id="type__cake" type="checkbox"><label for="type__cake">蛋糕</label>
            <input name="tag" id="type__drink" type="checkbox"><label for="type__drink">饮品</label>
            <input name="tag" id="type__tart" type="checkbox"><label for="type__tart">挞</label>
            <input name="tag" id="type__bread" type="checkbox"><label for="type__bread">面包</label>
            <input name="tag" id="type__biscuit" type="checkbox"><label for="type__biscuit">饼干</label>
            <input name="tag" id="type__jelly" type="checkbox"><label for="type__jelly">布丁</label>
            <input name="tag" id="type__ice-cream" type="checkbox"><label for="type__ice-cream">冰淇淋</label>
            <input name="tag" id="type__else" type="checkbox"><label for="type__else">其它</label>

          </section>
          <button id="filter__submit">确定</button>
        </form>
      </header>
      <section class="moment-list">
        <%
          for(int i = 0 ; i < total ;i++){
        %>
        <div class="moment">
          <img class="moment__author-avatar" src="<%=moments[i].userAvatar%>" alt="作者头像">
          <section class="moment__detail">
            <div class="moment__arrow-bottom"></div>
            <div class="moment__arrow-top"></div>
            <header class="moment__header">
              <div>
                <a class="moment__title" href="article.jsp?id=<%=moments[i].id%>"><%=moments[i].title%></a>
                <span class="moment__publish-date"><%=moments[i].date%></span>
              </div>
              <div class="moment__fav-icon">
                <i class="heart"></i>
              </div>
            </header>
            <article class="moment__content">
              <img class="moment__img" src="<%=moments[i].finImgBase64%>" alt="图片">
              <p class="moment__desc"><%=moments[i].introduction%></p>
            </article>
            <footer class="moment__footer">
              <div class="moment__tags">
                <i class="tag"></i>
                <%
                  for(int j = 0;j<moments[i].tagNo;j++){
                %>
                <span class="moment__tag"><%=moments[i].tag[j]%></span>
                <%
                  }
                %>
              </div>
              <div class="moment__popularity">
                <span class="moment__com-cnt">评论(<%=moments[i].commentNo%>)</span>
                <span class="moment__fav-cnt">收藏(<%=moments[i].collectionNo%>)</span>
              </div>
            </footer>
          </section>
        </div>
        <%
          }
        %>
      </section>
    </section>
    <!-- 教程 end -->

    <section id="user" class="main__wrapper animated fadeIn">
      <header class="flex">
        <img id="user__avatar" src="<%=user.getAvatar()%>" alt="用户头像">
        <div id="user__info">
          <p>
            <span id="user__nickname"><%=user.getNickname()%></span>
            <span id="user__sex"><%=user.getSex()%></span>
          </p>
          <p id="user__point">
            <span class="label">当前积分：</span>
            <%=user.getAccum()%>
          </p>
          <p id="user__sign">
            <span class="label">个性签名：</span>
            <%=user.getSign()%>
          </p>
        </div>
      </header>
      <!-- 个人主页 -->
      <section id="mine">
        <div id="tabs">
          <a href="javascript:void(0)" id="tab__my-moments" class="tab--active" data-target="my-moments">我的日志</a>
          <a href="javascript:void(0)" id="tab__my-collections" data-target="my-collections">收藏夹</a>
        </div>

        <%
          if(user.isLogin){
        %>
        <!-- 我的日志 -->
        <div id="my-moments" class="content content--active">
          <%
            for(int i = 0; i < -1; i++ ){
          %>
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
          <%
            }
          %>
        </div>

        <!-- 收藏夹 -->
        <div id="my-collections" class="content">
          <%
            for(int i = 0; i < -1; i++ ){
          %>
          <div class="moment">
            <article class="moment__content">
              <img class="moment__img" src="../assets/1.jpg" alt="图片">
              <div>
                <a class="moment__title" href="article.jsp?id=0613">今天去体检</a>
                <span class="moment__publish-date">2017-11-24</span>
                <p class="moment__desc">小阿小阿红，背着书包上学堂，不怕太阳晒，不怕风雨打.</p>
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
          <%
            }
          %>
        </div>
        <%
          }
        %>
      </section>

    </section>

    <!-- 我的消息 -->
    <section id="msg" class="main__wrapper animated fadeIn">
      <%
        if(user.isLogin){
            for(int i = 0;i<user.getMessageNo();i++){
      %>
      <div class="relpy__wrapper">
        <p class="reply__title">
          <span class="replier">阿土</span>
          回复了《 <a class="moment-title" href="article.jsp">12.13 半年已过</a> 》
          <span class="reply__date">2017-12-12 18:45</span>
        </p>
        <p class="reply__content">
          阿红， 你这是在刁难我胖虎！
        </p>
      </div>
      <%
          }//for(messageNo)
        }//if(isLogin)
      %>
    </section>

    <aside id="aside__bar-right">
      <ul id="aside__menu">
        <%
          if(user.isLogin){
        %>
        <li class="my__info" class="after-login hid">
          <img class="my__avatar" src="<%=user.getAvatar()%>" alt="头像" width="48" height="48">
          <div>
            <p class="nick-name"><%=user.getNickname()%></p>
            <p>我的积分:
              <span id="ponint"><%=user.getAccum()%></span>
            </p>
          </div>
          <button id="log-out-btn" onclick="ajaxLogout()">注销</button>

        </li>
        <%
          }else{
        %>
        <li class="my__info" class="before-login">
          <img class="my__avatar" src="/assets/avatar/avatar_0.jpg" alt="头像" width="48" height="48">
          <div>
            <p class="nick-name">游客</p>
            <button id="show-login-dialog">登陆</button>
          </div>
        </li>
        <%
          }
        %>
        <li id="my__write-moment">
          <a href="edit.jsp">写日志</a>
        </li>
        <li id="my__moment">
          <a href="#/user">我的日志</a>
        </li>
        <li id="my__msg">
          <a href="#/msg">我的消息</a>
          <span class="remind-point"></span>
        </li>
      </ul>
    </aside>
  </div>

  <script id="login__template" type="text/template">
    <div id="login__wrapper" >
      <p id="login__t">登录</p>
      <div class="input-wrapper">
        <i class="user"></i>
        <input id="login__u-n" type="text" placeholder="用户名">
      </div>
      <p class="tips" id="user-tip">请输入用户名</p>
      <div class="input-wrapper">
        <i class="password"></i>
        <input id="login__pwd" type="password" placeholder="密码">
      </div>
      <p class="tips" id="pw-tip">请输入密码</p>
      <div id="login__rmb-me">
        <input  type="checkbox" id="login__is-rmb-me">
        <label for="login__is-rmb-me">记住我</label>
      </div>
      <div class="input-wrapper">
        <button id="login__btn" onclick="ajaxLogin()">登录</button>
      </div>
      <p id="login-tip" class="tips">您输入的用户名或密码不正确</p>
      <a href="javascript:void(0)" id="login__to-reg">还没有账号? 点击注册</a>
    </div>
  </script>

  <script id="register__temlate" type="text/template">
    <div id="reg__wrapper">
      <p id="reg__t">注册</p>
      <div class="input-wrapper">
        <input id="reg__u-n" type="text" placeholder="用户名">
      </div>
      <p class="tips" id="usr-tip">请设置用户名</p>
      <p class="tips" id="repeat-tip">该用户名已被注册</p>
      <div class="input-wrapper">
        <input id="reg__pwd" type="password" placeholder="密码">
      </div>
      <p class="tips" id="pwd-tip">请输入密码</p>
      <p class="tips" id="length-tip">密码长度需大于6</p>
      <div class="input-wrapper">
        <input id="reg__ensure-pwd" type="password" placeholder="确认密码">
      </div>
      <p class="tips" id="confirm-tip">两次输入密码不一致</p>
      <div class="input-wrapper">
        <button id="reg__btn" onclick="ajaxRegister()">注册</button>
      </div>
      <a href="javascript:void(0)" id="reg__to-login">已有账号? 点击登陆</a>
    </div>
  </script>

  <script id="improve-data__template" type="text/template">
    <div id="imp__wrapper" >
      <p id="imp__t">完善资料</p>
      <div class="input-wrapper">
        <input id="imp__nick-name" type="text" placeholder="昵称">
      </div>
      <p class="tips" id="nick-tip">昵称不能为空</p>
      <div class="input-wrapper">
        <select name="sex" id="imp__sex">
          <option value="1">男</option>
          <option value="0">女</option>
        </select>
      </div>
      <div class="input-wrapper">
        <textarea name="sign" id="imp__sign" cols="30" rows="10" placeholder="个性签名"></textarea>
      </div>
      <p class="tips" id="sign-tip">一句话也简单介绍一下自己嘛~</p>
      <div class="input-wrapper">
        <button id="imp__btn" onclick="ajaxImprove()">完成</button>
      </div>
    </div>
  </script>
  <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
  <script src="../lib/js/shim.js"></script>
  <script src="../lib/js/tool.js"></script>
  <script src="../lib/js/tab.js"></script>
  <script src="../lib/js/dialog.js"></script>
  <script src="../lib/js/carousel.js"></script>
  <script src="../lib/js/snackbar.js"></script>
  <script src="./app.js"></script>
  <%
    if(user.isLogin&&user.getStatus()==0){
      out.print("<script>impDialog.show()</script>");//显示完善资料窗口
    }
    String login = request.getParameter("login");
    if(login!=null && login.equals("false")){
      out.print("<script>Tips.show('写日志需先登陆')</script>");
    }
  %>
</body>

</html>