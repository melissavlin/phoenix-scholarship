// Add event listeners 'blur' and 'keyup' to donation amt input box.
// wrap this in its own variable
// $(document).on('ready page:load', function(){
// 	var donation_amt = document.getElementById('donation_amt');
// 	donation_amt.addEventListener('blur', triggerQ, false);
// 	donation_amt.addEventListener('keyup', triggerQ, false);
// });

// if user inputs a donation amount > 1, enable and check checkbox.
// if input is not >1 and is empty, disable and uncheck checkbox 
// function triggerQ() {
// 	var question = document.getElementById('tag_role');
// 	(parseInt(this.value) >= 1 ? question.disabled = "" : question.disabled = 'disabled');
// 	(parseInt(this.value) >= 1 ? question.checked = true : question.checked = false);
// }