//recipes/showの献立追加を押すとカレンダーが表示されて日付を選択できるプログラム

window.addEventListener('load', function() {
  const kondate = document.getElementById('pull-down');
  const calender = document.getElementById('calender-selection');

  kondate.addEventListener('click', function(e) {
    if (calender.getAttribute("style") == "display:block;") {
      calender.removeAttribute("style", "display:block;");
    }else{
    calender.setAttribute("style", "display:block;");
    };
  });

  // const calender_submit_button = document.getElementById('calender-submit-button');
  // calender_submit_button.addEventListener('click', function(e) {
    // form = document.getElementById('calender-form');
    // const formData = new FormData(form);
    // e.preventDefault();
    // const XHR = new XMLHttpRequest();
    // XHR.open('POST', '/recipes/menus', true);
    // XHR.responseType = 'json';
    // XHR.send(formData);
    // XHR.onload = function() {
      // const animation = document.getElementsByClassName('header-mypage');
      // animation.className = 'active';
    // };
  // });
});