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
    
$("#answer-button").unbind("click").on('click', function(event){
	event.preventDefault(); //stops it from submitting the regular form
	var formUrl = $(this).parent().attr('action');
	var userAnswer = $(this).siblings().val();
    $.ajax({
    	url: formUrl, //the url that is searched for in controller
    	method: 'post', 
    	data: { answer: userAnswer },
    	dataType: 'json',
    	success: function(result){
    		debugger;
    		var userID = result['answer'].question_id;
    		$("#q"+ userID).append('<p class ="answer-text">' + result['answer'].text + '</p>' + '<div id="ans-info"><form method="post" action="/answer/aid/vote/upvote" id ="upvote-form"><input type=hidden name= "answid"  value="'+ result['answer'].id + ' "/><input type=submit value=" Upvote | 0" id ="upvote"></form><p id="answer-name-feed"> Submitted by: ' + result['user_name'] +' </p></div>');
    		//put quotes around html elements and then + the javascript elements
        	//$("#answer-text").html(result['answer'].text);

    	}
    });
});

    
})