if (! window.DOS) { DOS = {}; }

DOS.Browse = {

	render: function() {
		var id, entity, type, heading, newheading, entityIDs, i, $index, $ul, className, entries, types;

		var getSubtypes = function(ids) {
			var i, s = "";
			for (i = 0; i < ids.length; ++i) {
				if (i > 0) {
					s+= ", ";
				}
				s += DOS.Browse.subtypes[ids[i]][0];
			}
			return s;
		};

		var getSortingLetter = function(name) {
			var matches = name.match(/^('|the )?(.)/i);
			if (matches  &&  matches[2]) {
				return matches[2].toUpperCase();
			}
		};

		DOS.Browse.sortByContent();

		heading = null;

		// alphabetic list
		for (i = 0; i < DOS.Browse.orderedEntities.length; ++i) {
			id = DOS.Browse.orderedEntities[i];
			entity = DOS.Browse.entities[id];

			newheading = getSortingLetter(entity[0]);
			if (newheading < "0") {
				newheading = "Symbols";
			} else if (newheading < "A") {
				newheading = "0-9";
			}
			if (newheading != heading) {
				heading = newheading;
				$("#browse-alpha-index").append("<li><a href='#"+heading+"'>"+heading+"</a></li>");
				$("#entities-alpha").append("<h2 id='"+heading+"'>"+heading+"</h2>");
				$ul = $("<ul/>").appendTo("#entities-alpha");
			}

			className = entity[2] ? " class='has-entry'" : "";
			if (entity[1]) {
				$ul.append("<li"+className+"><div class='left'><a class='preview-"+id+"' href='../item/"+id+"'>"+entity[0]+"</a></div><div class='right'>"+getSubtypes(entity[1])+"</div><div class='clearfix'/></li>");
			} else {
				$ul.append("<li"+className+"><a class='preview-"+id+"' href='../item/"+id+"'>"+entity[0]+"</a></li>");
			}
		}
		$("#browse-alpha-index").append("<div class='clearfix'/>");

		// list by sub-type
		for (i = 0; i < DOS.Browse.orderedSubtypes.length; ++i) {
			type = DOS.Browse.orderedSubtypes[i];
			subtype = DOS.Browse.subtypes[type];

			if (DOS.Browse.orderedSubtypes.length > 1) {
				$("#browse-type-index").append("<li><a href='#"+type+"'>"+subtype[0]+"</a></li>");
			}

			$("#entities-type").append("<h2 id='"+type+"'>"+subtype[0]+"</h2>");
			entityIDs = subtype[1];
			$ul = $("<ul/>").appendTo("#entities-type");
			for (j = 0; j < entityIDs.length; ++j) {
				id = entityIDs[j];
				entity = DOS.Browse.entities[id];
				if (entity) {
					className = entity[2] ? " class='has-entry'" : "";
					$ul.append("<li"+className+"><a class='preview-"+id+"' href='../item/"+id+"'>"+entity[0]+"</a></li>");
				}
			}
		}
		$("#browse-type-index").append("<div class='clearfix'/>");

		// split into entities with entries and those without
		for (i = 0; i < DOS.Browse.orderedEntities.length; ++i) {
			id = DOS.Browse.orderedEntities[i];
			entity = DOS.Browse.entities[id];

			className = entity[2] ? " class='has-entry'" : "";
			$ul = entity[2] ? $("#entities-with-entries") : $("#entities-without-entries");

			if (entity[1]) {
				$ul.append("<li"+className+"><div class='left'><a class='preview-"+id+"' href='../item/"+id+"'>"+entity[0]+"</a></div><div class='right'>"+getSubtypes(entity[1])+"</div><div class='clearfix'/></li>");
			} else {
				$ul.append("<li"+className+"><a class='preview-"+id+"' href='../item/"+id+"'>"+entity[0]+"</a></li>");
			}
		}

		if (DOS.Browse.orderedSubtypes.length > 0) {
			// alternate row shading
			$("#entities-alpha ul, #entities-content ul").each(function () {
				$(this).find("li:odd").addClass("shade"); }
			);
		}

		entries = $("#entities-with-entries li").length > 0;
		types = DOS.Browse.orderedSubtypes.length > 0;

		if (! entries) {
			$("#entities-content").empty();
			if (types) {
				DOS.Browse.sortByType();
			} else {
				DOS.Browse.sortByName();
			}
		}

		if (entries && types) {
			// Sort by Content, Name or Type
			$("#sub-title").append("Sort by <a id='content-sort-link' href='#'>Content</a>")
			               .append(", <a id='name-sort-link' href='#'>Name</a>")
			               .append(" or <a id='type-sort-link' href='#'>Type</a>");
		} else if (entries) {
			// Sort by Content or Name
			$("#sub-title").append("Sort by <a id='content-sort-link' href='#'>Content</a>")
			               .append(" or <a id='name-sort-link' href='#'>Name</a>")
		} else if (types) {
			// Sort by Name or Type
			$("#sub-title").append("Sort by <a id='name-sort-link' href='#'>Name</a>")
			               .append(" or <a id='type-sort-link' href='#'>Type</a>");
		}

		$('#type-sort-link').click(DOS.Browse.sortByType);
		$('#name-sort-link').click(DOS.Browse.sortByName);
		$('#content-sort-link').click(DOS.Browse.sortByContent);

	},

	sortByName: function() {
		$("#entities-type, #browse-type-index, #entities-content").hide();
		$("#entities-alpha, #browse-alpha-index").show();
		return false;
	},

	sortByType: function() {
		$("#entities-alpha, #browse-alpha-index, #entities-content").hide();
		$("#entities-type, #browse-type-index").show();
		return false;
	},

	sortByContent: function() {
		$("#entities-alpha, #browse-alpha-index, #entities-type, #browse-type-index").hide();
		$("#entities-content").show();
		return false;
	}

};

$(DOS.Browse.render);
