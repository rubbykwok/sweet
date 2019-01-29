function Dialog(ele) {
  if (!ele) {
    throw new TypeError('unexpected type, must be Element');
  }

  this._create = function (tagName) {
    return document.createElement(tagName);
  }
  this._wrapper = this._create('div');
  this._close = this._create('i');
  this._win = this._create('div');

  this._wrapper.className = 'dialog__wrapper animated fadeIn hid';
  this._close.className = 'close dialog__close-btn';
  this._win.className = 'dialog__win animated jackInTheBox';
  this._win.appendChild(this._close);
  this._win.appendChild(ele);

  this._wrapper.appendChild(this._win);

  document.body.insertBefore(this._wrapper, document.querySelector('script'));

  this._close.addEventListener('click', function () {
    this.hide();
  }.bind(this));

  this._closeAll = function () {

  }

  this.show = function () {
    Dialog.closeAll();
    this._wrapper.removeClass('hid');
  };

  this.hide = function () {
    this._wrapper.addClass('hid');
  }
}

Dialog.closeAll = function () {
  $('.dialog__wrapper').forEach(function (ele, index) {
    ele.addClass('hid');
  });
}