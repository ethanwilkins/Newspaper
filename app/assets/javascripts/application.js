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

// need to test for existance of tab feed or user feed etc and only run this then
// also needs to send correct parameters expected by pages more action
	
// $(window).scroll(function() {
// 	if($(window).scrollTop() + $(window).height() > $(document).height() - 50) {
// 		$.ajax( { url: "pages/more", type: "GET" } );
// 	}
// });