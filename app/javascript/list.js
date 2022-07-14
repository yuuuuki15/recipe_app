window.addEventListener('load', function() {
  const deleteList = document.querySelectorAll('.delete-list');
  for (let i = 0; i < deleteList.length; i++) {
    deleteList[i].addEventListener('click', function(e) {
      //同じ列のリストを削除する
      //親の親の親を削除（テーブルを追加したのでひとつ追加した）
      const list = e.target.parentNode.parentNode.parentNode;
      const listId = deleteList[i].getAttribute('data');
      XHR = new XMLHttpRequest();
      XHR.open('DELETE', `/lists/${listId}`, true);
      XHR.send();
      XHR.onload = function() {
        list.remove();
      }
    });
  }
});