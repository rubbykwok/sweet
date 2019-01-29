
//  监听路由变化
(function () {
  let hash = window.location.hash.split('/')[1];
  !hash && (hash = 'home');
  $('.main__wrapper--active')[0].removeClass('main__wrapper--active');
  $(`#${hash}`).addClass('main__wrapper--active');
  $(`a[data-target="${hash}"]`).click();
})();

window.onhashchange = function ({ newURL, oldURL }) {
  let hash = Tool.getPath(newURL);
  hash === '/' && (hash = 'home');
  hash = hash.replace(/\//g, '');
  $('.main__wrapper--active')[0].removeClass('main__wrapper--active');
  $('#' + hash).addClass('main__wrapper--active');
};

//  search
(function () {
  $('#nav__search-text').on('keydown', (e) => {
    if (e.keyCode === 13) {
      window.location.href = 'result.jsp?content=' + e.target.value;
    }
  })
})();

// login & register

  let loginTpl = $('#login__template').text.trim().parseToDOM();
  let regTpl = $('#register__temlate').text.trim().parseToDOM();

  let lDialog = new Dialog(loginTpl);  //  loginDialog
  let rDialog = new Dialog(regTpl);  //  registerDialog
  let lCallback = () => {
    lDialog.show();
  };
  let rCallback = () => {
    rDialog.show();
  };

  $('#show-login-dialog') && $('#show-login-dialog').on('click', lCallback);
  $('#reg__to-login').on('click', lCallback);
  $('#login__to-reg').on('click', rCallback);

/**
 * 调用impDialog.show()方法，显示完善信息弹框
 */
let impDialog = (function () {
  let tpl = $('#improve-data__template').text.trim().parseToDOM();
  return new Dialog(tpl);
})();

function check(ele,tip){
    if(ele.value.trim() == ''){
        show(tip);
        return false;
    }else {
        hide(tip);
        return true;
    }
}

function loginCheck() {
    var username = $('#login__u-n');
    var userTip = $('#user-tip');
    var password = $('#login__pwd');
    var pwTip = $('#pw-tip');
    var loginTip = $('#login-tip');
    if(check(username,userTip)&&check(password,pwTip)){
        return true;
    }else {
        hide(loginTip);
        return false;
    }
}

function rpwdCheck() {
    var password = $('#reg__pwd').value;
    var password2 = $('#reg__ensure-pwd').value;
    var pwdTip = $('#pwd-tip');
    var lenTip = $('#length-tip');
    var confTip = $('#confirm-tip');
    if(password.trim() == ''){
        show(pwdTip);
        return false;
    }else if(password.length<6){
        hide(pwdTip)
        show(lenTip);
        return false;
    }else if(password != password2){
        hide(lenTip)
        show(confTip);
        return false;
    }else {
        hide(pwdTip);
        hide(lenTip);
        hide(confTip);
        return true;
    }
}
function regCheck() {
    var username = $('#reg__u-n');
    var usrTip = $('#usr-tip');
    var repeatTip = $('#repeat-tip');
    if(check(username,usrTip)&&rpwdCheck()){
        return true;
    }else {
        hide(repeatTip);
        return false;
    }
}
function impCheck() {
    var nickname = $('#imp__nick-name');
    var nickTip = $('#nick-tip');
    var sign = $('#imp__sign');
    var signTip = $('#sign-tip');
    if(check(nickname,nickTip)&&check(sign,signTip)){
        return true;
    }else {
        return false;
    }
}
function ajaxLogout() {
    var params = new URLSearchParams();
    params.append('log-out', 'Y');
    axios.post('../login',params)
        .then(function (response) {
            if(response.data == 'OK'){
                location.reload();
            }
            console.log(response);
        })
        .catch(function (error) {
            console.log(error);
        });
}

function ajaxLogin() {
    var loginTip = $('#login-tip');
    if(loginCheck()) {
        var params = new URLSearchParams();
        params.append('username',  $('#login__u-n').value);
        params.append('password',  $('#login__pwd').value);
        if($('#login__is-rmb-me').checked == true)
            params.append('auto-login', 'Y');
        else
            params.append('auto-login', 'N');
        axios.post('../login',params)
            .then(function (response) {
                if(response.data == 'OK'){
                    location.reload();
                }
                else if(response.data == 'ERR'){
                    show(loginTip);
                }
                console.log(response);
            })
            .catch(function (error) {
                console.log(error);
            });
    }
}
function ajaxRegister() {
    var repeatTip = $('#repeat-tip');
    if(regCheck()) {
        var params = new URLSearchParams();
        params.append('username',  $('#reg__u-n').value);
        params.append('password',  $('#reg__pwd').value);
        axios.post('../register',params)
            .then(function (response) {
                if (response.data == 'OK') {
                    rDialog.hide();
                    Tips.show('注册成功');
                    lDialog.show();
                }else {
                    show(repeatTip);
                }
                console.log(response);
            })
            .catch(function (error) {
                console.log(error);
            });
    }
}
function ajaxImprove() {
    if(impCheck()){
        var params = new URLSearchParams();
        params.append('nickname',  $('#imp__nick-name').value);
        params.append('sign',  $('#imp__sign').value);
        params.append('sex', $('#imp__sex').value);
        params.append('token',cookies.get("token"));
        axios.post('../register',params)
            .then(function (response) {
                if (response.data == 'OK') {
                    location.reload();
                }
                console.log(response);
            })
            .catch(function (error) {
                console.log(error);
            });
    }
}
