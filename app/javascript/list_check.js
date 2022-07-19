// 非同期でチェックリストのステータスを更新する
window.addEventListener('load', function() {
  const checkList = document.querySelectorAll('#list_check');
  for (let i = 0; i < checkList.length; i++) {
    checkList[i].addEventListener('click', function(e) {
      const listId = checkList[i].getAttribute('data');
      XHR = new XMLHttpRequest();
      XHR.open('PATCH', `/lists/${listId}/check`, true);
      XHR.send();
    });
  }
});