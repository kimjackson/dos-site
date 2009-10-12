if (! window.DOS) { DOS = {}; }

DOS.Search = {

	searchPrompt: "search..."

};

$(function () {
	$("#search-submit")
		.click(function () {
			$("#search-bar form").submit();
		})
		.hover(function () {
			$("#search-bar").addClass("active");
		}, function () {
			$("#search-bar").removeClass("active");
		});


	$("#search").val(DOS.Search.searchPrompt)
		.focus(function () {
			if (this.value === DOS.Search.searchPrompt) {
				this.value = "";
			}
		})
		.blur(function () {
			if (this.value === "") {
				this.value = DOS.Search.searchPrompt;
			}
		});

	// process search results
	if ($(".results").length > 0) {
		$(".result_block, .result_altblock").each(function () {
			var id, className;

			id = $(".result_metavalue_id", this).text();
			className = $(".result_metavalue_class", this).text();

			$(".result_title a", this).addClass("preview-" + id);
			$(this).addClass("list-" + className);

			// this needs to happen before DOS.ToolTip.addToolTips()
			// in order for previews to be loaded
			$("#previews").append(
				"<div class='preview' id='preview-" + id + "'/>"
			);
		});
	}
});

