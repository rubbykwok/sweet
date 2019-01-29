(function () {
  $('#make-comment').on('click', (e) => {
    if(cookies.get('token') === undefined){
      Tips.show('评论需先登陆');
    }else {
        $('#input-comment__wrapper').addClass('expand');
    }
});

  $('#comment__upload-cancel').on('click', (e) => {
    e.preventDefault();
    let preview = $('#comment__upload-preview');
    preview.style.backgroundImage = '';
    preview.addClass('hid');
    console.log($('#comment__file').files);
  });

  $('#comment__file').on('change', (e) => {
    let files = e.target.files;
    let preview = $('#comment__upload-preview');
    preview.style.backgroundImage = `url(${Tool.getObjectURL(files[0])})`;
    preview.removeClass('hid');
  });

  $('#comment__upload-btn').on('click', (e) => {
    e.preventDefault();
    $('#comment__file').click();
  });
})();

function showReply(ele) {
    if(cookies.get('token') === undefined){
        Tips.show('回复评论需先登陆');
    }else{
      ele.parentNode.nextElementSibling.removeClass('hid');
    }
}