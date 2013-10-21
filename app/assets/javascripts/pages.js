$(document).ready(function(){
	$('a.navigation[href^="#"]').bind('click.smoothscroll',function (e){
		e.preventDefault();
		var target = this.hash,
		$target = $(target);
		$('html, body').stop().animate({
			'scrollTop': $target.offset().top - $('.span12.controls-row').height() - 20
		}, 900, 'swing', function () {
			window.location.hash = target
		});
	});
//    document.write("User-agent header sent: " + navigator.userAgent);

    $('.carousel').carousel({
        interval: 4000
    })
    $("#notice-alert").delay(2500).fadeOut();

     //iframe

    var iWin = document.getElementById('frem').contentWindow,
        iDoc = iWin.document;

    if( ! iWin.$ ){
        var jq = iDoc.createElement('script');
        jq.type = 'text/javascript';
        jq.src = 'http://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js';
        jq.onload = ready;
        iDoc.head.appendChild(jq);
    }else{
        ready(); // the stuff you want to do
    }



//
});


function ready(){

    $("#player").width('100%');

}

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




