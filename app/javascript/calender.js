//recipes/showの献立追加を押すとカレンダーが表示されて日付を選択できるプログラム

window.addEventListener('load', function() {
  const kondate = document.getElementById('pull-down');
  const calender = document.getElementById('calender-selection');

  kondate.addEventListener('click', function(e) {
    e.preventDefault();
    if (calender.getAttribute("style") == "display:block;") {
      calender.removeAttribute("style", "display:block;");
    }else{
    calender.setAttribute("style", "display:block;");
    }
  });
});