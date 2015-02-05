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
//= require scrollView
	
setInterval(function() {
	if ($("#instant_messaging_anchor").length) {
		$.ajax({
			type: "GET",
			url: "/messages/new_messages",
			data: $.param({folder_id: document.URL.split("/")[4]})
		})
	}
}, 5000);
	
$(window).bindWithDelay("scroll", function() {
	if($(window).scrollTop() + $(window).height() > $(document).height() - 300) {
		if ($("#more_content_anchor").length) {
			var param = null;
			if (document.URL.search("users") != -1) {
				param = $.param({ user_id: document.URL.split("/")[4] });
			} else if (document.URL.search("subtabs") != -1) {
				param = $.param({ subtab_id: document.URL.split("/")[6] });
			} else if (document.URL.search("tabs") != -1) {
				param = $.param({ tab_id: document.URL.split("/")[4] });
			} else if (document.URL.search("notes") != -1) {
				param = $.param({ notes: true });
			} else if (document.URL.search("search") != -1) {
				param = $.param({ search: true });
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
}, 200);

// ajax new notes not rendering, probably because of bootstrap
// setInterval(function() {
// 	$.ajax({
// 		type: "GET",
// 		url: "/notes/new_notes"
// 	})
// }, 6000);