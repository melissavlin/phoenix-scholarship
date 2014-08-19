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

$(document).on('ready page:load', function(){
// $(document).ready(function(){
	$(".link_app").on("click", function(e){
		showHideApp(e);
	})
	var donation_amt = document.getElementById('donation_amt');
	donation_amt.addEventListener('blur', triggerQ, false);
	donation_amt.addEventListener('keyup', triggerQ, false);
});


function triggerQ() {
	var question = document.getElementById('tag_role');
	(parseInt(this.value) >= 1 ? question.disabled = "" : question.disabled = 'disabled');
	(parseInt(this.value) >= 1 ? question.checked = true : question.checked = false);
}

	var showHideApp = function(e){
		console.log($(e.delegateTarget).prop("id"));

		var link = ($(e.delegateTarget).prop("id")).substring(5);
			console.log(link);

		$('.app').addClass('hidden');
		$("#"+link).removeClass('hidden');
			// var selector = $(e.delegateTarget).closest('.review_app_wrapper').siblings().contents(link).toggle(); 
			// $(".review_app").hide();
			// $(selector).show();
	}







