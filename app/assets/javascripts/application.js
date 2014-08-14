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

// Add event listeners 'blur' and 'keyup' to donation amt input box.

$(document).ready(function(){
	var donation_amt = document.getElementById('donation_amt');
	donation_amt.addEventListener('blur', triggerQ, false);
	donation_amt.addEventListener('keyup', triggerQ, false);
});

// if user inputs a donation amount > 1, enable and check checkbox.
// if input is not >1 and is empty, disable and uncheck checkbox 
function triggerQ() {
	var question = document.getElementById('tag_role');
	(parseInt(this.value) >= 1 ? question.disabled = "" : question.disabled = 'disabled');
	(parseInt(this.value) >= 1 ? question.checked = true : question.checked = false);
}







