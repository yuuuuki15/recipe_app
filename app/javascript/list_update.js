window.addEventListener('load', function() {
  const updateList = document.querySelectorAll('#update');
  for (let i = 0; i < updateList.length; i++) {
  updateList[i].addEventListener('click', function(e) {
    debugger
    const formData = new FormData();
    const listId = updateList[i].childNodes
    //formdataをllistIdに追加
    formData.append('listId', listId);
    /*
    const editListId = document.querySelectorAll('.edit-list-form')
      XHR = new XMLHttpRequest();
      XHR.open('PATCH', '/lists/update', true);
      XHR.send();
      */
  });
  };
});