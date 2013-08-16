$(document).ready(function(){
	$('a.navigation[href^="#"]').bind('click.smoothscroll',function (e){
		e.preventDefault();
		var target = this.hash,
		$target = $(target);
		$('html, body').stop().animate({
			'scrollTop': $target.offset().top - $('.span12.controls-row').height()
		}, 900, 'swing', function () {
			window.location.hash = target
		});
	});
//    document.write("User-agent header sent: " + navigator.userAgent);

    $('.carousel').carousel({
        interval: 4000
    })
});



//$('.button-container').device_detector({
//    var useragent = navigator.userAgent.toLowerCase();
//
//    if( useragent.match("iphone") )
//       alert('iphone');
//    else if( useragent.match("ipod") )
//       alert('ipod');
//    else if( useragent.match("android") )
//       alert('android');
//});




