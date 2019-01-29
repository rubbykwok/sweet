class Snackbar {
  constructor() {
    this.wrapper = document.createElement('div');
    this.wrapper.id = 'snackbar';
    this.wrapper.className = 'animated fadeIn hid';
    document.body.appendChild(this.wrapper);
  }
  show(msg, ms = 2000) {
    this.wrapper.innerText = msg;
    this.wrapper.removeClass('hid');
    setTimeout(() => {
      this.wrapper.addClass('hid');
    }, ms);
  }
}

const Tips = new Snackbar(); 