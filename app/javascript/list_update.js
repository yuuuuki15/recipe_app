// 買い物リストを更新する
window.addEventListener('load', function() {
  const updateList = document.querySelectorAll('#update');
  for (let i = 0; i < updateList.length; i++) {
  updateList[i].addEventListener('click', function(e) {
    const list = e.target
    const new_element = document.createElement('p');
    new_element.textContent = '追加テキスト';
    /*listにnew_elementを重ねる 
    list.appendChild(new_element);
    const formData = new FormData(e.target);*/

    /*
    const editListId = document.querySelectorAll('.edit-list-form')
      XHR = new XMLHttpRequest();
      XHR.open('PATCH', '/lists/update', true);
      XHR.send();
      */
  });
  };
});