// 增加一个步骤
(function () {
  let curStep = 1;
  let wrapper = $('#step');
  $('#step__add').on('click', (e) => {
    e.preventDefault();
    ++curStep;
    let tpl = $('#step__template').text.trim().parseToDOM();
    let label = tpl.querySelector('.label');
    let file = tpl.querySelector('.step__file');
    let txt = tpl.querySelector('.step__content');

    tpl.dataset.step = `${curStep}`;
    label.innerText = `第 ${curStep} 步`;
    file.name = `step${curStep}-file`;
    txt.name = `step${curStep}-content`;

    wrapper.appendChild(tpl);
  });
})();
function complete() {
    $('#step-no').value = document.querySelectorAll('[data-step]').length;
    $('#edit-form').submit();
}

function click(e) {
  let t = e.target;
  // 上传按钮
  if (t.hasClass('step__upload-btn')) {
    t.previousElementSibling.click();
  }

  // 预览取消按钮
  if (t.hasClass('step__upload-cancel') || t.hasClass('cancel')) {
    e.preventDefault();
    let preview = t.parentNode.parentNode;
    let btn = preview.previousElementSibling;

    preview.addClass('hid');
    preview.style.backgroundImage = '';
    btn.removeClass('hid');
  }
}

function change(e) {
  let t = e.target;
  // file变化事件
  if (t.hasClass('step__file')) {
    let parent = t.parentNode;
    let btn = parent.querySelector('.step__upload-btn');
    let preview = parent.querySelector('.step__upload-preview');
    preview.style.backgroundImage = `url('${Tool.getObjectURL(t.files[0])}')`;
    btn.addClass('hid');
    preview.removeClass('hid');
  }
}

// 制作步骤div的事件委托
(function () {
  // click事件代理
  $('#step').on('click', (e) => {
    click(e);
  });

  // change事件代理
  $('#step').on('change', (e) => {
    change(e);
  })
})();


//  成品事件监听
(function () {
  $('#end').on('click', click);
  $('#end').on('change', change);
})();

