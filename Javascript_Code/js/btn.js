function openExercise(ex) {
    dialog.showModal();
    $("#dialogFrame").attr('src',ex+"/sketch.js"); 
    // console.log($("#dialogFrame"))
    // $("#dialogFrame").src(ex+"/sketch.js");
}

function gotoExercise(ex) {
    window.location.href = ex+"/sketch.js"; 
}

var dialog = document.querySelector('dialog');

if (!dialog.showModal) {
    dialogPolyfill.registerDialog(dialog);
}

dialog.querySelector('.close').addEventListener('click', function () {
    dialog.close();
});