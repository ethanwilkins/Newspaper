// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require bindWithDelay
	
$(window).bindWithDelay("scroll", function() {
	if($(window).scrollTop() + $(window).height() > $(document).height() - 50) {
		if ($("#more_content_anchor")) {
			var param = null;
			if (document.URL.search("users") != -1) {
				param = $.param({ user_id: document.URL.split("/")[4] });
			} else if (document.URL.search("tabs") != -1) {
				param = $.param({ tab_id: document.URL.split("/")[4] });
			}
			if (param) {
				$.ajax({
					type: "GET",
					url: "/pages/more",
					data: param
				});
			}
		}
	}
}, 500);