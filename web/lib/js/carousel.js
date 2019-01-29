class Carousel {
  constructor() {
    this._index = 0;
    this._timer = null;
    this._imgs = document.querySelectorAll('.carousel__item');
    this._btns = document.querySelectorAll('.carousel__btn');
    this._limit = this._imgs.length;
    this._init();
    this._setTimer();
  }

  _init() {
    for (let index = 0; index < this._btns.length; index++) {
      this._btns[index].onclick = () => {
        this._clearTimer();
        this._setTimer();
        this._setActive(index);
      };
    }
  }

  _clearTimer() {
    clearInterval(this._timer);
  }

  _setTimer() {
    this._timer = setInterval(() => {
      this._setActive();
    }, 5000);
  }

  _setActive(index) {
    let lastIndex = this._index;
    let nextIndex = index !== undefined ? index : ++this._index % this._limit;
    this._imgs[lastIndex].removeClass('carousel__item--active');
    this._btns[lastIndex].removeClass('carousel__btn--active');

    this._imgs[nextIndex].addClass('carousel__item--active');
    this._btns[nextIndex].addClass('carousel__btn--active');

    this._index = nextIndex;
  }
}

new Carousel();