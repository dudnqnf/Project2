// Hide Header on on scroll down
var didScroll;
var lastScrollTop = 0;
var delta = 5;
var navbarHeight = $('.footer').outerHeight();

var toggleTime = 500;

$(window).scroll(function(event){
    didScroll = true;
});

setInterval(function() {
    if (didScroll) {
        hasScrolled();
        didScroll = false;
    }
}, 200);

function hasScrolled() {
    var st = $(this).scrollTop();
    
    // Make sure they scroll more than delta
    if(Math.abs(lastScrollTop - st) <= delta)
        return;
    
    // If they scrolled down and are past the navbar, add class .nav-up.
    // This is necessary so you never see what is "behind" the navbar.
    if (st > lastScrollTop && st > navbarHeight){
    	//Scroll Down
    	$( ".footer" ).animate({
    		bottom: "-60px"
    	}, toggleTime, function() {
    		// Animation complete.
    	});
    } else {
        // Scroll Up
    	$( ".footer" ).animate({
    		bottom: "0px"
    	}, toggleTime, function() {
    		// Animation complete.
    	});
    }
    
    lastScrollTop = st;
}

