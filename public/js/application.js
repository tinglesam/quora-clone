// (function() {
//   $(function() {
//     $(".login--container").removeClass("preload");
//     this.timer = window.setTimeout((function(_this) {
//       return function() {
//         return $(".login--container").toggleClass("login--active");
//       };
//     })(this),2000);
//     return $(".js-toggle-login").click((function(_this) {
//       return function() {
//         window.clearTimeout(_this.timer);
//         $(".login--container").toggleClass("login--active");
//         return $(".login--username-container input").focus();
//       };
//     })(this));
//   });

// }).call(this);

$(document).ready(function() {
    
function loadDoc() {
  var xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (xhttp.readyState == 4 && xhttp.status == 200) {
      document.getElementById("demo").innerHTML = xhttp.responseText;
    }
  };
  xhttp.open("GET", "ajax_info.txt", true);
  xhttp.send();
}

    
})