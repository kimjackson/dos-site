if (! window.DOS) { DOS = {}; }

DOS.Browse = {

	alphabet: "ABCDEFGHIJKLMNOPQRSTUVWXYZ",

	render: function() {
		var id, entity, type, heading, newheading, entityIDs, i, $index, $ul, className;

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

		heading = null;

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

			if (entity[1]) {
				className = entity[2] ? "left has-entry" : "left";
				$ul.append("<li><div class='"+className+"'><a href='../item/"+id+"'>"+entity[0]+"</a></div><div class='right'>"+getSubtypes(entity[1])+"</div><div class='clearfix'/></li>");
			} else {
				className = entity[2] ? " class='has-entry'" : "";
				$ul.append("<li"+className+"><a href='../item/"+id+"'>"+entity[0]+"</a></li>");
			}
		}
		$("#browse-alpha-index").append("<div class='clearfix'/>");

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
					$ul.append("<li"+className+"><a href='../item/"+id+"'>"+entity[0]+"</a></li>");
				}
			}
		}
		$("#browse-type-index").append("<div class='clearfix'/>");
	},

	sortByName: function() {
		$("#entities-type").add("#browse-type-index").hide();
		$("#entities-alpha").add("#browse-alpha-index").show();
		return false;
	},

	sortByType: function() {
		$("#entities-alpha").add("#browse-alpha-index").hide();
		$("#entities-type").add("#browse-type-index").show();
		return false;
	}

};

$(function() {
	$('#type-sort-link').click(DOS.Browse.sortByType);
	$('#name-sort-link').click(DOS.Browse.sortByName);
	if (DOS.Browse.orderedSubtypes.length > 0) {
		DOS.Browse.sortByType();
	} else {
		$("#heading #sub-title").empty();
		DOS.Browse.sortByName();
	}
	DOS.Browse.render();
});
