function checkField (selector, name) {
	if ($(selector).val() == '') {
		alert(name + ' is required');
		return false;
	}
	return true;
}

function checkEmail (selector) {
	if (! $(selector).val().match(/\S+@\S+\.\S+/)) {
		alert('Invalid Email address');
		return false;
	}
	return true;
}

function validateForm () {
	if (checkField('#name', 'Name')  &&
	    checkField('#email', 'Email')  &&
	    checkEmail('#email')  &&
	    checkField('#message', 'Message')) {
		return true;
	}
	return false;
}

$(function () {
	var elems, i, matches;

	if (location.search.match(/\bsuccess=1/)) {
		alert('Message sent');
	}

	if (location.search.match(/\berror=incorrect-captcha-sol/)) {
		alert('Incorrect CAPTCHA.  Please try again.');
	}

	elems = ['name', 'email', 'phone', 'message'];
	for (i = 0; i < elems.length; ++i) {
		matches = location.search.match(new RegExp('\\b' + elems[i] + '=([^&]+)'));
		if (matches) {
			$('#' + elems[i]).val(unescape(matches[1].replace(/\+/g, ' ')));
		}
	}
});
