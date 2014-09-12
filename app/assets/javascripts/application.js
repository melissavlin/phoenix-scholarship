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
	$(".link_app").on("click", function(e){
		showHideApp(e);
	})
	$("#donation_amt").bind("blur keyup", function(event){
		event.preventDefault();
		triggerQ();
	});

	// $(document).on('ajax:success', '.check', function(e){
	// 	// $(e.currentTarget).switchClass('received_donation_button', 'donation_complete_button');
	// 	$(e.currentTarget).removeClass('received_donation_button');
	// });

	$(".received_donation_button").on("click", function(e){
		$.ajax({
			success: function(){
				$(e.delegateTarget).removeClass('received_donation_button').html("<p class='donation_complete_button'> &check; </p>");
			}
		})
	})

});


	var triggerQ = function() {
		if (parseInt($("#donation_amt").val())  >= 1) {
			$("#role").removeAttr("disabled");
		}
	}

	var showHideApp = function(e){
		console.log($(e.delegateTarget).prop("id"));

		var link = ($(e.delegateTarget).prop("id")).substring(5);
			console.log(link);

		$('.app').addClass('hidden');
		$("#"+link).removeClass('hidden');

	}







