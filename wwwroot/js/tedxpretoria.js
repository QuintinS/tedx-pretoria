var TEDx = {

	Menu: {

		expand: function(event) {
			var myMenuVisible = $(".sf-menu").is(":visible");
			if (myMenuVisible === true) {
				$(".sf-menu").slideUp();
			}
			else
			{
				$(".sf-menu").slideDown();
			}
		}

	},

	ScrollMagic: {
		controller: new ScrollMagic.Controller(),
		init: function(){
			new ScrollMagic.Scene({
			        duration: 100,    // the scene should last for a scroll distance of 100px
			        offset: 50        // start this scene after scrolling for 50px
			})
			.setPin("#my-sticky-element") // pins the element for the the scene's duration
			.addTo(controller); // assign the scene to the controller
		}
	},

	assignEventListeners: function(){
		$('a[href*=#]:not([href=#])').on("click", TEDx.functions.scrollTo);
		$('#menu-button').on("click", TEDx.Menu.expand);
	},

	functions: {

		scrollTo: function(HashOrEvent){

			if (typeof HashOrEvent === "string") {
				
			}
			else
			if (typeof HashOrEvent === "object") {
				if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
					var target = $(this.hash);
					target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
					if (target.length) {
						$('html,body').animate({
							scrollTop: target.offset().top - 400
						}, 1000);
						return false;
					}
				}
			}

			var myLocation = $(event.currentTarget).attr("href").replace("#", "");
			var anchorExists = $("[name='" + myLocation + "']").length >= 1;
			console.log(anchorExists);

			if (anchorExists === true) {

			}

		},

		getLinkScroll: function(){
			if(window.location.hash) {
			  // Fragment exists
			} else {
			  // Fragment doesn't exist
			}
		}

	},

	reset: function(){
		TEDx.assignEventListeners();
		TEDx.functions.getLinkScroll();
	}

};

$(document).ready(function(){
	// TEDx.reset();
});

scroll(0,0);
TEDx.functions.getLinkScroll();
TEDx.reset();