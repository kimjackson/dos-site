<?php

require_once('/var/www/h3/configIni.php');
require_once('/var/www/h3/common/php/dbMySqlWrappers.php');

define('READONLY_DBUSERNAME', $dbReadonlyUsername);
define('READONLY_DBUSERPSWD', $dbReadonlyPassword);

mysql_connection_select($dbPrefix . $defaultDBname, 'localhost');

$spider_links = (@$argv[1] === 'spider-links');
$links = (@$argv[1] === 'links') || $spider_links;
$check = (@$argv[1] === 'check');

$path_to_id = array();

if ($spider_links) {
	echo "rm -rf spider-*\n";
	echo "mkdir spider-contributor spider-entry spider-role spider-subject spider-map spider-image spider-audio spider-video spider-artefact spider-building spider-event spider-natural_feature spider-organisation spider-person spider-place spider-structure\n";
} else if ($links) {
	echo "rm -rf contributor entry role subject map image audio video artefact building event natural_feature organisation person place structure\n";
	echo "mkdir contributor entry role subject map image audio video artefact building event natural_feature organisation person place structure\n";
} else {
	echo "<map>\n";
}

$terms = getTerms();
//var_dump($terms['termsByDomainLookup']['enum']);

// contributors, entities, roles, terms, entries
$res = mysql_query('select rec_ID from Records left join recDetails on dtl_RecID = rec_ID and dtl_DetailTypeID = 95 where rec_RecTypeID in (24,25,27,29,13) and if (rec_RecTypeID = 27, dtl_Value in ("Occupation", "Type"), 1) and ! rec_FlagTemporary and rec_ID not in (2674,2675)');
while ($row = mysql_fetch_row($res)) {
	$record = loadRecord($row[0], false, true);
	$id = $record['rec_ID'];
	$path = getRecordType($record) . '/' . getTitle($record);
	if (array_key_exists($path, $path_to_id)) {
		echo "Conflict: $path: " . $path_to_id[$path] . ", $id\n";
		if (! $check) {
			exit;
		}
	}
	$path_to_id[$path] = $id;

	printMapping($id, $path);
}

// media
$res = mysql_query('select rec_ID, if (dtl_Value like "image/%", "image", if (dtl_Value like "audio/%", "audio", "video"))
                      from Records, recDetails
                     where rec_RecTypeID = 5
                       and dtl_RecID = rec_ID
                       and dtl_DetailTypeID = 29
                       and (dtl_Value like "image/%" or dtl_Value like "audio/%" or dtl_Value like "video/%")');
while ($row = mysql_fetch_row($res)) {
	$id = $row[0];
	$path = $row[1] . '/' . $id;
	// we use IDs so no need to check for collisions
	printMapping($id, $path);
}

// hi-res images
$res = mysql_query('select rec_ID
                      from Records, recDetails
                     where rec_RecTypeID = 11
                       and dtl_RecID = rec_ID
                       and dtl_DetailTypeID = 30
                       and dtl_Value = "image"');
while ($row = mysql_fetch_row($res)) {
	$id = $row[0];
	$path = 'image/' . $id;
	// we use IDs so no need to check for collisions
	printMapping($id, $path);
}

$res = mysql_query('select rec_ID from Records where rec_RecTypeID = 28');
while ($row = mysql_fetch_row($res)) {
	$id = $row[0];
	$path = 'map/' . $id;
	// we use IDs so no need to check for collisions
	printMapping($id, $path);
}

if (! $links) echo "</map>\n";



function getTitle($record) {
	global $links, $spider_links, $check;
	$search = array(',', '\'', ' ', '/', '&');
	$replace = array('', '', '_', '_', ($links ? '&' : '&amp;'));
	if (! $record['details'][1]) {
		echo "Missing title!\n";
		var_dump($record);
		if (! $check) {
			exit;
		}
	}
	foreach ($record['details'][1] as $detailID => $value) {
		return str_replace($search, $replace, mb_strtolower($value, 'UTF-8'));
	}
}

function getEntityType($record) {
	global $check, $terms;
	if (! $record['details'][75]) {
		echo "Missing entity type!\n";
		var_dump($record);
		if (! $check) {
			exit;
		}
	}
	foreach ($record['details'][75] as $detailID => $value) {
		$entity_type = $terms['termsByDomainLookup']['enum'][$value][0];
		return str_replace(' ', '_', strtolower($entity_type));
	}
}

function getRecordType($record) {
	switch ($record['rec_RecTypeID']) {
	case 24:
		return 'contributor';
		break;
	case 13:
		return 'entry';
		break;
	case 27:
		return 'role';
		break;
	case 29:
		return 'subject';
		break;
	case 25:
		return getEntityType($record);
		break;
	}
}

function printMapping($id, $path) {
	global $links, $spider_links, $check;
	if ($spider_links) {
		echo "ln -s ../item/$id \"spider-" . str_replace("&", "AMPERSAND", $path) . "\"\n";
	} else if ($links) {
		echo "ln -s ../item/$id \"$path\"\n";
	} else if ($check) {
		# noop, only output errors
	} else {
		echo "<record><id>$id</id><path>$path</path></record>\n";
	}
}


function loadRecord ($id) {
	$res = mysql_query(
		"select rec_ID,
		rec_RecTypeID,
		rec_Title,
		rec_URL,
		rec_ScratchPad,
		rec_OwnerUGrpID,
		rec_NonOwnerVisibility,
		rec_URLLastVerified,
		rec_URLErrorMessage,
		rec_Added,
		rec_Modified,
		rec_AddedByUGrpID,
		rec_Hash
		from Records
		where rec_ID = $id");
	$record = mysql_fetch_assoc($res);
	if ($record) {
		loadRecordDetails($record);
		// saw todo might need to load record relmarker info here which gets the constrained set or just constraints
	}
	return $record;
}

function loadRecordDetails(&$record) {
	$recID = $record["rec_ID"];
	$squery =
	"select dtl_ID,
	dtl_DetailTypeID,
	dtl_Value,
	astext(dtl_Geo) as dtl_Geo,
	dtl_UploadedFileID,
	dty_Type,
	rec_ID,
	rec_Title,
	rec_RecTypeID,
	rec_Hash
	from recDetails
	left join defDetailTypes on dty_ID = dtl_DetailTypeID
	left join Records on rec_ID = dtl_Value and dty_Type = 'resource'
	where dtl_RecID = $recID";

	$res = mysql_query($squery);

	$details = array();
	while ($rd = mysql_fetch_assoc($res)) {
		// skip all invalid value
		if (( !$rd["dty_Type"] === "file" && $rd["dtl_Value"] === null ) ||
			(($rd["dty_Type"] === "enum" || $rd["dty_Type"] === "relationtype") && !$rd["dtl_Value"])) {
			error_log("found INVALID detail in rec $rd[rec_ID] dtl $rd[dtl_ID] dty $rd[dtl_DetailTypeID] with value = $rd[dtl_Value]");
			continue;
		}

		if (! @$details[$rd["dtl_DetailTypeID"]]) $details[$rd["dtl_DetailTypeID"]] = array();

		$detailValue = null;

		switch ($rd["dty_Type"]) {
			case "freetext": case "blocktext":
			case "float":
			case "date":
			case "enum":
			case "relationtype":
			case "integer": case "boolean": case "year": case "urlinclude": // these shoudl no logner exist, retained for backward compatibility
				$detailValue = $rd["dtl_Value"];
				break;

			case "file":

				//$detailValue = get_uploaded_file_info($rd["dtl_UploadedFileID"], false);

				break;

			case "resource":
				$detailValue = array(
					"id" => $rd["rec_ID"],
					"type"=>$rd["rec_RecTypeID"],
					"title" => $rd["rec_Title"],
					"hhash" => $rd["rec_Hash"]
				);
				break;

			case "geo":
				if ($rd["dtl_Value"]  &&  $rd["dtl_Geo"]) {
					$detailValue = array(
						"geo" => array(
							"type" => $rd["dtl_Value"],
							"wkt" => $rd["dtl_Geo"]
						)
					);
				}
				break;

			case "separator":	// this should never happen since separators are not saved as details, skip if it does
			case "relmarker":	// relmarkers are places holders for display of relationships constrained in some way
			default:
				continue;
		}

		if ($detailValue) {
			$details[$rd["dtl_DetailTypeID"]][$rd["dtl_ID"]] = $detailValue;
		}
	}

	$record["details"] = $details;
}


/**
 * return array of term table column names
 */
function getTermColNames() {
    return array("trm_ID",
                "trm_Label",
                "trm_InverseTermID",
                "trm_Description",
                "trm_Status",
                "trm_OriginatingDBID",
                //					"trm_NameInOriginatingDB",
                "trm_IDInOriginatingDB",
                "trm_AddedByImport",
                "trm_IsLocalExtension",
                "trm_Domain",
                "trm_OntID",
                "trm_ChildCount",
                "trm_ParentTermID",
                "trm_Depth",
                "trm_Modified",
                "trm_LocallyModified",
                "trm_Code",
                "trm_ConceptID");
}
/**
 * get term structure with trees from relation and enum domains
 * @param     boolean $useCachedData whether to use cached data (default = false)
 * @return    object terms structure that contains domainLookups and domain term trees
 * @uses      getTermColNames()
 * @uses      getTermTree()
 * @uses      getCachedData()
 * @uses      setCachedData()
 */
function getTerms() {
    global $dbID;
    $query = "select " . join(",", getTermColNames());
    $query = preg_replace("/trm_ConceptID/", "", $query);
    if ($dbID) { //if(trm_OriginatingDBID,concat(cast(trm_OriginatingDBID as char(5)),'-',cast(trm_IDInOriginatingDB as char(5))),'null') as trm_ConceptID
        $query.= " if(trm_OriginatingDBID, concat(cast(trm_OriginatingDBID as char(5)),'-',cast(trm_IDInOriginatingDB as char(5))), concat('$dbID-',cast(trm_ID as char(5)))) as trm_ConceptID";
    } else {
        $query.= " if(trm_OriginatingDBID, concat(cast(trm_OriginatingDBID as char(5)),'-',cast(trm_IDInOriginatingDB as char(5))), '') as trm_ConceptID";
    }
    $query.= " from defTerms order by trm_Domain, trm_Label";
    $res = mysql_query($query);
    $terms = array('termsByDomainLookup' => array('relation' => array(), 'enum' => array()), 'commonFieldNames' => array_slice(getTermColNames(), 1), 'fieldNamesToIndex' => getColumnNameToIndex(array_slice(getTermColNames(), 1)));
    while ($row = mysql_fetch_row($res)) {
        $terms['termsByDomainLookup'][$row[9]][$row[0]] = array_slice($row, 1);
    }
    $terms['treesByDomain'] = array('relation' => getTermTree("relation", "prefix"), 'enum' => getTermTree("enum", "prefix"));
    return $terms;
}
/**
 * get name to index map for columns
 * @param     array $columns array of strings
 * @return    object string => index lookup
 */
function getColumnNameToIndex($columns) {
    $columnsNameIndexMap = array();
    $index = 0;
    foreach ($columns as $columnName) {
        $columnsNameIndexMap[$columnName] = $index++;
    }
    return $columnsNameIndexMap;
}
/**
 * attaches a child branch to a parent, recursively calling itself to build the childs subtree
 * @param     int $parentIndex id of parent term to attach child branch to
 * @param     int $childIndex id of child branch in current array
 * @param     mixed $terms the array of branches to build the tree
 * @return    object $terms
 */
function attachChild($parentIndex, $childIndex, $terms) {
    if (!@count($terms[$childIndex]) || $parentIndex == $childIndex) {//recursion termination
        return $terms;
    }
    /*****DEBUG****///error_log(" enter attach $contIndex, $childIndex, ".print_r($terms,true));
    if (array_key_exists($childIndex, $terms)) {//check for
        if (count($terms[$childIndex])) {
            foreach ($terms[$childIndex] as $gChildID => $n) {
                if ($gChildID != null) {
                    $terms = attachChild($childIndex, $gChildID, $terms);//depth first recursion
                    /*****DEBUG****/// error_log(" after recurse $childIndex, $gChildID, ".print_r($terms,true));
                }
            }
        }
        /*****DEBUG****///error_log(" attaching ".print_r($terms[$childIndex],true));
        /*****DEBUG****///error_log(" to ".print_r($terms[$parentIndex],true));
        $terms[$parentIndex][$childIndex] = $terms[$childIndex];
        unset($terms[$childIndex]);
    }
    /*****DEBUG****/// error_log(" exit attach $contIndex, $childIndex, ".print_r($terms,true));
    return $terms;
}
/**
 * build a tree of term ids for a given domain name or names (prefix or postfix subdomain naming)
 * @global    type description of global variable usage in a function
 * @staticvar type [$varname] description of static variable usage in function
 * @param     string $termDomain the term domain to build
 * @param     string $matching indicates whether the domain name is complete or portion of the domain
 * @return    mixed
 * @uses      attachChild()
 */
 function getTermTree($termDomain, $matching = 'exact') { // termDomain can be empty, 'reltype' or 'enum' or any future term use domain defined in the trm_Domain enum
    $whereClause = "a.trm_Domain " . ($matching == 'prefix' ? " like '" . $termDomain . "%' " : ($matching == 'postfix' ? " like '%" . $termDomain . "' " : "='" . $termDomain . "'"));
    $query = "select a.trm_ID as pID, b.trm_ID as cID
				from defTerms a
					left join defTerms b on a.trm_ID = b.trm_ParentTermID
				where $whereClause
				order by a.trm_Label, b.trm_Label";
    $res = mysql_query($query);
    $terms = array();
    // create array of parent => child arrays
    while ($row = mysql_fetch_assoc($res)) {
        if (!@$terms[$row["pID"]]) {
            $terms[$row["pID"]] = array();
        }
        if ($row['cID']) {//insert child under parent
            $terms[$row["pID"]][$row['cID']] = array();
        }
    }//we have all the branches, now lets build a tree
    foreach ($terms as $parentID => $childIDs) {
        foreach ($childIDs as $childID => $n) {
            //check that we have a child branch
            if ($childID != null && array_key_exists($childID, $terms)) {
                if (count($terms[$childID])) {//yes then attach it and it's children's branches
                    $terms = attachChild($parentID, $childID, $terms);
                } else {//no then it's a leaf in a branch, remove this redundant node.
                    unset($terms[$childID]);
                }
            }
        }
    }
    return $terms;
}
