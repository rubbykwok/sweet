(function () {
  $('#nav__menu').on('click', function (e) {
    var t = e.target;
    if (t.tagName.toUpperCase() === 'A' && !t.hasClass('text--active')) {
      $('.text--active')[0].removeClass('text--active');
      $('.arrow--active')[0].removeClass('arrow--active');

      t.addClass('text--active');
      t.nextElementSibling.addClass('arrow--active');
    }
  })
})();

(function () {
  $('#user #tabs').on('click', (e) => {
    var t = e.target;
    if (t.tagName.toUpperCase() === 'A' && !t.hasClass('tab--active')) {
      $('.tab--active')[0].removeClass('tab--active');
      $('.content--active')[0].removeClass('content--active');
      t.addClass('tab--active');
      $(`#${t.dataset.target}`).addClass('content--active');
    }   
  })
})();