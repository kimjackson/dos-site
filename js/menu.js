$(function () {
	$("#connections .menu").click(function () {
		if ($(this).hasClass("closed")) {
			$(this).next(".submenu").show();
		} else {
			$(this).next(".submenu").hide();
		}
		$(this).toggleClass("closed");
	});
});
