/*jslint browser: true, eqeqeq: true, immed: true, newcap: true, undef: true, white: true, indent: 4*/
/*global window, Node, $, YAHOO */

if (! window.Node) {
	/* courtesy of: http://safalra.com/web-design/javascript/dom-node-type-constants/ */
	var Node = {
		ELEMENT_NODE                :  1,
		ATTRIBUTE_NODE              :  2,
		TEXT_NODE                   :  3,
		CDATA_SECTION_NODE          :  4,
		ENTITY_REFERENCE_NODE       :  5,
		ENTITY_NODE                 :  6,
		PROCESSING_INSTRUCTION_NODE :  7,
		COMMENT_NODE                :  8,
		DOCUMENT_NODE               :  9,
		DOCUMENT_TYPE_NODE          : 10,
		DOCUMENT_FRAGMENT_NODE      : 11,
		NOTATION_NODE               : 12
	};
}

var currentRefs;

function highlight(root, refs) {
	// normalise addresses
	var i, j;
	for (i = 0; i < refs.length; ++i) {

		if (! refs[i].endElems  ||  ! refs[i].endElems.length) {
			refs[i].endElems = refs[i].startElems;
		}
		else {
			for (j = 0; j < refs[i].startElems.length; ++j) {
				if (j < refs[i].endElems.length  &&  refs[i].endElems[j] === null) {
					refs[i].endElems[j] = refs[i].startElems[j];
				}
			}
		}

		if (refs[i].startWord !== null  &&  refs[i].endWord === null) {
			refs[i].endWord = refs[i].startWord;
		}
	}

	currentRefs = [];
	traverse(root, refs, []);


	$("a.annotation").filter(".hide").click(function () {
		highlightAnnotation(this.getAttribute("annotation-id"));
		return false;
	});

}

function traverse(elem, refs, address) {
	var i,
		j,
		skip,
		match,
		startingRefs = [],
		endingRefs = [],
		children = [],
		elemNumber = 0,
		wordOffset = 0;

	// count the words that were in the footnote element,
	// but got moved into a title attribute in the transform!
	if ($(elem).is("span.note")) {
		return $(elem).find("sup a").attr("title")
				.replace(/^\s+/, "").replace(/\s+$/, "")
				.split(/\s+/).length;
	}

	// find refs starting at this elem
	for (i = 0; i < refs.length; ++i) {
		// only check refs which are not already current
		skip = false;
		for (j = 0; j < currentRefs.length; ++j) {
			if (currentRefs[j] === refs[i]) {
				skip = true;
			}
		}
		if (! skip) {
			match = checkAddress(address, refs[i].startElems);
			if (match) {
				startingRefs.unshift(i);
			}
		}
	}

	// find refs ending at this elem
	for (i = 0; i < refs.length; ++i) {
		match = checkAddress(address, refs[i].endElems);
		if (match) {
			endingRefs.unshift(i);
		}
	}

	// copy childNodes - more children might be inserted as we go!
	children = [];
	for (i = 0; i < elem.childNodes.length; ++i) {
		children.push(elem.childNodes[i]);
	}

	elemNumber = 0;
	wordOffset = 0;
	for (i = 0; i < children.length; ++i) {
		if (children[i].nodeType === Node.ELEMENT_NODE) {
			// may alter currentRefs!
			wordOffset += traverse(children[i], refs, address.concat([++elemNumber]));
		}
		else if (children[i].nodeType === Node.TEXT_NODE) {
			// may alter currentRefs
			wordOffset += transformTextNode(children[i], refs, startingRefs, endingRefs, wordOffset);
		}
	}

	return wordOffset;
}

function checkAddress(currLoc, addr) {
	// check currrent location against given address
	var i;

	if (currLoc.length !== addr.length) {
		return false;
	}

	for (i = 0; i < addr.length; ++i) {
		if (addr[i] === null) {
			break;
		}
		if (currLoc.length <= i) {
			return false;
		}
		if (currLoc[i] !== addr[i]) {
			return false;
		}
	}

	return true;
}

function transformTextNode(elem, refs, startingRefs, endingRefs, wordOffset) {
	var parentElem = elem.parentNode,
		text = elem.nodeValue,
		words,
		i,
		j,
		skip,
		s,
		myStartingRefs = [],
		myEndingRefs = [],
		ref,
		a,
		newElements = [],
		startPositions = [],
		endPositions = [],
		refId,
		startWord,
		endWord,
		sortfunc,
		refStack = [],
		sections = [],
		section,
		w,
		startPos,
		endPos,
		newRefStack,
		wordString,
		newState,
		remove;


	text = text.replace(/^\s+/, "").replace(/\s+$/, "");
	words = text.split(/\s+/);

	// filter just the applicable refs from startingRefs and endingRefs
	for (i = 0; i < startingRefs.length; ++i) {
		s = refs[startingRefs[i]].startWord;
		if (wordOffset < s  &&  s <= (wordOffset + words.length)) {
			myStartingRefs.push(startingRefs[i]);
		}
	}
	for (i = 0; i < endingRefs.length; ++i) {
		s = refs[endingRefs[i]].endWord;
		if (wordOffset < s  &&  s <= (wordOffset + words.length)) {
			myEndingRefs.push(endingRefs[i]);
		}
	}

	// trivial trivial case: there is nothing happening in this text node.
	// we only visited it to find out how many words it contains
	if (! currentRefs.length  &&  ! myStartingRefs.length  &&  ! myEndingRefs.length) {
		return words.length;
	}

	// trivial case: there are no references starting or ending within this element
	// so just highlight it and link to the ref on the top of the currentRefs stack
	if (! myStartingRefs.length  &&  ! myEndingRefs.length) {
		ref = refs[currentRefs[0]];
		a = document.createElement("a");
		a.className = "annotation" + (currentRefs.length > 1 ? " multiple" : "") + (ref.hide ? " hide" : "");
		if (! ref.hide) { a.href = "#ref=" + ref.recordID; }
		a.title = ref.title;
		a.name = "ref" + ref.recordID;
		a.setAttribute("annotation-id", ref.recordID);
		a.innerHTML = elem.nodeValue;
		elem.parentNode.replaceChild(a, elem);

	} else {

		for (i = 0; i < currentRefs.length; ++i) {
			startPositions.push({ "word": 1, "refId": currentRefs[i] });
			// if this ref is in myEndingRefs, ignore it here -- it will be entered into the endPositions list correctly below
			skip = false;
			for (j = 0; j < myEndingRefs.length; ++j) {
				if (myEndingRefs[j] === currentRefs[i]) {
					skip = true;
				}
			}
			if (! skip) {
				endPositions.push({ "word": words.length, "refId": currentRefs[i] });
			}
		}
		for (i = 0; i < myStartingRefs.length; ++i) {
			refId = myStartingRefs[i];
			startWord = refs[refId].startWord - wordOffset;
			startPositions.push({ "word": startWord, "refId": refId, "starting": true });
		}
		for (i = 0; i < myEndingRefs.length; ++i) {
			refId = myEndingRefs[i];
			endWord = refs[refId].endWord - wordOffset;
			endPositions.push({ "word": endWord, "refId": refId, "ending": true });
		}

		sortfunc = function (a, b) {
			if (a.word === b.word) {
				return a.refId - b.refId;
			} else {
				return a.word - b.word;
			}
		};

		startPositions = startPositions.sort(sortfunc);
		endPositions = endPositions.sort(sortfunc);

		section = { "startWord": 1, "endWord": null, "refId": null, "refCount": 0, "refNums": [] };
		for (w = 1; w <= words.length; ++w) {
			startPos = null;
			// push any refs that start at this pos onto the stack
			while (startPositions.length > 0  &&  startPositions[0].word === w) {
				startPos = startPositions.shift();
				refStack.unshift(startPos.refId);

				if (section.startWord === w) {
					// there is already a section starting at this word
					// how?  either one finished at the previous word, or more than one ref starts here
					section.refId = startPos.refId;
					section.refCount = refStack.length;
				} else {
					// wrap up the current section and start a new one
					section.endWord = w - 1;
					sections.push(section);
					section = { "startWord": w, "endWord": null, "refId": startPos.refId, "refCount": refStack.length, "refNums": [], "starting": startPos.starting || false };
				}
			}

			endPos = null;
			// remove any refs that end at this pos from the "stack"
			while (endPositions.length > 0  &&  endPositions[0].word === w) {
				endPos = endPositions.shift();
				newRefStack = [];
				while (refStack.length) {
					ref = refStack.shift();
					if (ref !== endPos.refId) {
						newRefStack.push(ref);
					}
				}
				refStack = newRefStack;

				// a reference ends here
				section.endWord = w;
				section.ending = (section.ending || endPos.ending) || false;
				if (endPos.ending) {
					section.refNums.push(endPos.refId);
				}
				if (endPositions.length === 0  ||  endPositions[0].word !== w) {
					// no more to come
					sections.push(section);
					if (w === words.length) {
						// this is the last word => no more sections
						section = null;
					} else {
						section = { "startWord": w + 1, "endWord": null, "refId": (refStack.length > 0 ? refStack[0] : null), "refCount": refStack.length, "refNums": [] };
					}
				}
			}
		}

		if (section) {
			section.endWord = words.length;
			sections.push(section);
		}

		for (i = 0; i < sections.length; ++i) {
			section = sections[i];

			wordString =
				(section.starting ? "" : " ") +
				words.slice(section.startWord - 1, section.endWord).join(" ") +
				(section.ending ? "" : " ");

			if (section.refId !== null) {
				ref = refs[section.refId];
				a = document.createElement("a");
				a.className = "annotation" + (currentRefs.length > 1 ? " multiple" : "") + (ref.hide ? " hide" : "");
				if (! ref.hide) { a.href = "#ref=" + ref.recordID; }
				a.title = ref.title;
				a.name = "ref" + ref.recordID;
				a.setAttribute("annotation-id", ref.recordID);
				a.innerHTML = wordString;
				newElements.push(a);

			} else {
				newElements.push(document.createTextNode(wordString));
			}

		}

		// replace elem with newElements
		parentElem = elem.parentNode;
		parentElem.replaceChild(newElements[0], elem);
		for (i = 1; i < newElements.length; ++i) {
			parentElem.insertBefore(newElements[i], newElements[i - 1].nextSibling);
		}

		// now update currentRefs to reflect what happened within this text node
		// add refs that start at this elem
		if (myStartingRefs.length) {
			currentRefs = myStartingRefs.reverse().concat(currentRefs);
		}
		// remove refs which end here
		if (currentRefs.length  &&  myEndingRefs.length) {
			newState = [];
			for (i = 0; i < currentRefs.length; ++i) {
				remove = false;
				for (j = 0; j < myEndingRefs.length; ++j) {
					if (currentRefs[i] === myEndingRefs[j]) {
						remove = true;
					}
				}
				if (! remove) {
					newState.push(currentRefs[i]);
				}
			}
			currentRefs = newState;
		}
	}

	return words.length;
}


function alignImages() {
	var $annotation,
		$section,
		textpos,
		imgpos,
		imgbottom,
		delta,
		textbottom,
		$img;

	$("div.annotation-img").each(function () {
		$annotation = $("#tei a[annotation-id=" + $(this).attr("annotation-id") + "]");
		$section = $annotation.parent().parent();
		if ($section.is(":visible")) {
			textbottom = $section.offset().top + $section.height();

			$(this).css("margin-top", "0px");
			$(this).show();
			textpos = $annotation.offset().top;
			$img = $(this).find("img");
			imgpos = $img.offset().top;
			imgbottom = imgpos + $img.outerHeight();
			delta = textpos - (imgpos);
			if (imgbottom + delta > textbottom) {
				// image would protrude below the bottom of the text for this section - try to move it up
				delta -= (imgbottom + delta - textbottom);
				if (delta < 0) {
					// we can't apply a -ve margin; see if there are preceding images in this section
					// that we can nudge up a bit
					$prev = $(this).prevAll("div").eq(0);
					while ($prev.length > 0  &&  $section.find("a[annotation-id=" + $prev.attr("annotation-id") + "]").length > 0) {
						m = parseInt($prev.css("margin-top"));
						if (m > 0) {
							if (m + delta < 0) {
								$prev.css("margin-top", "0px");
								delta += m;
							} else {
								$prev.css("margin-top", (m + delta) + "px");
								delta = 0;
								break;
							}
						}
						$prev = $prev.prevAll("div").eq(0);
					}
				}
			}
			if (delta > 0) {
				$(this).css("margin-top", delta + "px");
			}
		} else {
			$(this).hide();
		}
	});
}


function setupPageControls() {
	$("#previous").click(function () {
		$("#tei div:has(~ div:visible):last").each(function () {
			showSection($("#tei div").index(this) + 1);
		});
		return false;
	});
	$("#next").click(function () {
		$("#tei div:visible ~ div:first").each(function () {
			showSection($("#tei div").index(this) + 1);
		});
		return false;
	});
}

function showSection(i) {
	if (i === "all") {
		YAHOO.util.History.navigate("page", "all");
	} else {
		YAHOO.util.History.multiNavigate({"page": "" + i, "ref": ""});
	}
}

function highlightAnnotation(id) {
	YAHOO.util.History.navigate("ref", "" + id);
}

YAHOO.util.Event.onDOMReady(function () {

	var initPage,
		initAnnotation,
		$link,
		$section;

	function _showSection(i) {
		if (i) {
			// note index begins at 1; "all" means show all sections
			if (i === "all") {
				$("#tei div").show();
				$("#previous").add("#next").hide();
			} else {
				i = i - 0;
				$("#tei div").hide().eq(i - 1).show();
				if (i === 1) {
					$("#previous").hide();
				} else {
					$("#previous").show();
				}
				if (i === $("#tei div").length) {
					$("#next").hide();
				} else {
					$("#next").show();
				}
			}
			alignImages();
		}
	}

	function _highlightAnnotation(id) {
		if (id) {
			$("#tei a.annotation.highlighted").removeClass("highlighted");
			$link = $("#tei a[annotation-id=" + id + "]");
			$link.addClass("highlighted");
			$section = $link.parent().parent();
			if (! $section.is(":visible")) {
				_showSection($("#tei div").index($section[0]) + 1);
			}
		}
	}

	initPage = YAHOO.util.History.getBookmarkedState("page");
	initAnnotation = YAHOO.util.History.getBookmarkedState("ref");

	if (! initPage) {
		initPage = "1";
	}
	if (! initAnnotation) {
		initAnnotation = "";
	}

	YAHOO.util.History.register("page", initPage, function (state) {
		_showSection(state);
	});
	YAHOO.util.History.register("ref", initAnnotation, function (state) {
		_highlightAnnotation(state);
	});

	YAHOO.util.History.onReady(function () {
		_showSection(YAHOO.util.History.getCurrentState("page"));
		_highlightAnnotation(YAHOO.util.History.getCurrentState("ref"));
	});

	try {
		YAHOO.util.History.initialize("yui-history-field", "yui-history-iframe");
	} catch (e) {
		alert("history manager init failed");
	}

	setupPageControls();

	if ($("#tei").length > 0  &&  window.refs) {
		highlight($("#tei")[0], refs);
	}
});


