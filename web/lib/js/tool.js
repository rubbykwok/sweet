let Tool = {
  isMobile() {
    let reg = /^1[34578]\d{9}$/;
    return reg.test(str);
  },
  /**
 * @method  回到顶部
 * @param {object}    ele         dom对象，滚动的容器
 * @param {Number}    durations   滚动持续时间
 * @param {function}  callback    到达顶部的回调函数 
 */
  backTop(ele, durations, callback = undefined) {
    const scrollTop = ele.scrollTop;
    for (let i = 60; i >= 0; i--) {
      setTimeout((i => {
        return () => {
          ele.scrollTop = scrollTop * i / 60;
          if (i === 0 && typeof callback === 'function') {
            callback();
          }
        };
      })(i), durations * (1 - i / 60))
    }
  },
  /**
 * @method 获取url参数
 * @param {String} paramKey url参数的key值
 * 
 * 示例 http://www.baidu.com?code=abcde
 * code     --paramKey
 * abcde    --param
 */
  getParams(paramKey) {
    let arr = window.location.search.replace('?', '').split('&');
    let set = {};
    for (let i = 0; i < arr.length; i++) {
      let item = arr[i];
      let key = item.split('=')[0];
      let val = item.split('=')[1];
      set[key] = val;
    }
    return set[paramKey];
  },
  getPath(url) {
    let hash = url.split('#')[1] || '/'
    return hash;
  },
  isInputLegal(text) {
    let t = text.trim();
    let flag = (t == 'undefined') || (t == 'null') || (t == '') || (t == 'false') || (t == '0') || (t == '-0') || (t == 'NaN');
    return !flag;
  },
  getObjectURL(file) {
    let url = null;
    if (window.createObjectURL != undefined) {
      url = window.createObjectURL(file)
    } else if (window.URL != undefined) {
      url = window.URL.createObjectURL(file)
    } else if (window.webkitURL != undefined) {
      url = window.webkitURL.createObjectURL(file)
    }
    return url
  }
};

let cookies = {
  set(key, val, expires) {
    document.cookie = expires ? `${key}=${val}; expires=${expires}` : `${key}=${val}`;
  },
  get(key) {
    let cookies = document.cookie.replace(/\s*/g, '').split(';');
    let o = {};
    cookies.length != 0 && cookies.forEach((cookie) => {
      let temp = cookie.split('=');
      let key = temp[0];
      let val = temp[1];
      o[key] = val;
    });
    return o[key];
  },
  clear(key) {
    this.set(key, '', new Date(1999, 0, 1).toGMTString());
  }
}

function show(ele){
    ele.style.display = 'block';
}
function hide(ele){
    ele.style.display = 'none';
}