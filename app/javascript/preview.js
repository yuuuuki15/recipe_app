document.addEventListener('DOMContentLoaded', function(){
  const postForm = document.getElementById('new_post');
  const previewList = document.getElementById('previews');


  //if (!postForm) return null;

  const fileField = document.querySelector('input[type="file"], [name="recipe[image]"]');
  fileField.addEventListener('change', function(e){
    const alreadyPreviewed = previewList.querySelector('.preview');
    if(alreadyPreviewed){
      alreadyPreviewed.remove();
    };
    const file = e.target.files[0];
    const blob = window.URL.createObjectURL(file);
    console.log(blob);

    const previewWrapper = document.createElement('div');
    previewWrapper.setAttribute('class', 'preview');
    const previewImage = document.createElement('img');
    previewImage.setAttribute('class', 'preview-image');
    previewImage.setAttribute('src', blob);
    previewWrapper.appendChild(previewImage);
    previewList.appendChild(previewWrapper);
  });
});