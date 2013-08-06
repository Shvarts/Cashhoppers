$(document).ready(function(){
	$('a.navigation[href^="#"]').bind('click.smoothscroll',function (e){
		e.preventDefault();
		var target = this.hash,
		$target = $(target);
		$('html, body').stop().animate({
			'scrollTop': $target.offset().top-100
		}, 900, 'swing', function () {
			window.location.hash = target
		});
	});


    $('.carousel').carousel({
        interval: 4000
    })
});





