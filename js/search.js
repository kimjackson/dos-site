if (! window.DOS) { DOS = {}; }

DOS.Search = {

	searchPrompt: "search...",
	resultsDiv: null,

	search: function() {
		var query = $("#search").val();
		if (! query  ||  query === DOS.Search.searchPrompt) return false;
		var loader = new HLoader(
			function(s,r) {
				DOS.Search.displayResults(s,r);
			},
			function(s,e) {
				alert("load failed: " + e);
			}
		);
		DOS.Search.loadAllRecords(query, null, loader);
		//HeuristScholarDB.loadRecords(new HSearch(query), loader);
		DOS.Search.showSearch(query);
		return false;
	},

	loadAllRecords: function(query, options, loader) {
			var records = [];
			var baseSearch = new HSearch(query, options);
			var bulkLoader = new HLoader(
				function(s, r) {	// onload
					records.push.apply(records, r);
					if (r.length < 100) {
						// we've loaded all the records: invoke the original loader's onload
						document.getElementById('loading-msg').innerHTML = '<b>Loaded ' + records.length + ' records </b>';
						loader.onload(baseSearch, records);
					}
					else { // more records to retrieve
						document.getElementById('loading-msg').innerHTML = '<b>Loaded ' + records.length + ' records so far ...</b>';

						//  do a search with an offset specified for retrieving the next page of records
						var search = new HSearch(query + " offset:"+records.length, options);
						HeuristScholarDB.loadRecords(search, bulkLoader);
					}
				},
				loader.onerror
			);
			HeuristScholarDB.loadRecords(baseSearch, bulkLoader);
	},

	showSearch: function(query) {
		// turn off any highlighting
		if (window.highlightElem) {
			highlightElem("inline-annotation", null);
			highlightElem("annotation-link", null);
		}

		// hide page-inner and show results div
		var resultsDiv = DOS.Search.resultsDiv;
		var pageInner = document.getElementById("content");
		pageInner.style.display = "none";
		if (resultsDiv) {
			resultsDiv.innerHTML = "";
			resultsDiv.style.display = "block";
		} else {
			DOS.Search.resultsDiv = resultsDiv = pageInner.parentNode.insertBefore(document.createElement("div"), pageInner.nextSibling);
			resultsDiv.id = "results-div";
			resultsDiv.className = "content";
		}

		resultsDiv.innerHTML += "<a style=\"float: right;\" href=# onclick=\"DOS.Search.hideResults(); return false;\">Return to previous view</a>";
		resultsDiv.innerHTML += "<h2>Search results for query \"" + query + "\"</h2>";
		resultsDiv.innerHTML += "<p id=loading-msg>Loading...</p>";
	},

	displayResults: function(s,r) {
		var l = document.getElementById("loading-msg");
		l.parentNode.removeChild(l);

		var innerHTML = "";
		for (var i = 0; i < r.length; i++) {
			//if (r[i].getRecordType().getID() != 52) {
				innerHTML += "<img src=\"http://dos.heuristscholar.org/heurist/img/reftype/" + r[i].getRecordType().getID() + ".gif\"/>";
				innerHTML += " <a href=../item/" + r[i].getID() + " target=\"_blank\">" + r[i].getTitle() + "</a><br/>";
			//}
		}

		if (innerHTML.length) {
			DOS.Search.resultsDiv.innerHTML += innerHTML;
		} else {
			DOS.Search.resultsDiv.innerHTML += "<p>No matching records</p>";
		}
	},

	hideResults: function() {
		DOS.Search.resultsDiv.style.display = "none";
		document.getElementById("content").style.display = "block";
	}
};

$(function () {
	$("#search-bar form").submit(DOS.Search.search);
	$("#search-submit").click(DOS.Search.search);

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
});

