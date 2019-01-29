(function () {
  function $(selector) {
    if (selector[0] === '.') {
      return document.querySelectorAll(selector);
    }
    return document.querySelector(selector);
  }

  function on(type, callback) {
    this.addEventListener(type, function (e) {
      callback && callback(e)
    });
  }

  function addClass(className) {
    let old = this.className;
    old.indexOf(className) === -1 &&
      (this.className = this.className ? `${this.className} ${className}` : className);
  }

  function removeClass(className) {
    let reg = new RegExp('(\\s*' + className + '|' + className + '\\s*)', 'g');
    this.className = this.className.replace(reg, '');
  }

  function hasClass(className) {
    return this.className.indexOf(className) !== -1;
  }

  function parseToDOM() {
    let txt = this.toString();
    let div = document.createElement('div');
    div.innerHTML = txt;
    return div.childNodes[0];
  }

  window.$ = $;
  Element.prototype.on = on;
  Element.prototype.addClass = addClass;
  Element.prototype.removeClass = removeClass;
  Element.prototype.hasClass = hasClass;
  String.prototype.parseToDOM = parseToDOM;
})();
