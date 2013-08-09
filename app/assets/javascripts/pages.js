$(document).ready(function(){
	$('a.navigation[href^="#"]').bind('click.smoothscroll',function (e){
		e.preventDefault();
		var target = this.hash,
		$target = $(target);
		$('html, body').stop().animate({
			'scrollTop': $target.offset().top-80
		}, 900, 'swing', function () {
			window.location.hash = target
		});
	});
//    document.write("User-agent header sent: " + navigator.userAgent);
buttonselect();
    $('.carousel').carousel({
        interval: 4000
    })
});
//function buttonselect(){
// var uagent = navigator.userAgent.toLowerCase();
//    alert(uagent);
//   if(1 == 1){
//     $(".button-container a").attr("href", "/users/sign_in")
//   }
//   else if(navigator.userAgent.match(/iPad/i) ) {
//       alert('iphone');
//   }
//   else if(navigator.userAgent.match(/iPhone/i) ){
//       alert('android');
//    }
//    else if(navigator.userAgent.match(/os/) ) {
//       alert('ipod');
//   }
//};





