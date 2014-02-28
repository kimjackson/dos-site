<?php

require_once('/var/www/h3/configIni.php');
require_once('/var/www/h3/common/php/dbMySqlWrappers.php');

define('READONLY_DBUSERNAME', $dbReadonlyUsername);
define('READONLY_DBUSERPSWD', $dbReadonlyPassword);

mysql_connection_select($dbPrefix . $defaultDBname, 'localhost');


if ($argc < 2) {
	print "Usage: php " . $argv[0] . " <type> [<typePath>]\n";
	exit(1);
}

$type = $argv[1];
$typePath = @$argv[2];


$entities = array();
$orderedEntities = array();

$termIDs = array();
$query = "select trm_ID, trm_Label from defTerms";
$res = mysql_query($query);
while ($row = mysql_fetch_row($res)) {
	$termIDs[$row[1]] = $row[0];
}


if ($type == "Entry") {
	$query = "select rec_ID,
	                 rec_Title
	            from Records
	           where rec_RecTypeID = 13
	             and rec_ID != 2674
	        order by if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', ''))";

} else if ($type == "Map") {
	$query = "select rec_ID,
	                 rec_Title
	            from Records
	           where rec_RecTypeID = 28
	        order by if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', ''))";

}

else if ($type == "Multimedia") {
	$query = "SELECT
                Records.rec_ID,
                Records.rec_Title
                from Records
                WHERE rec_RecTypeID =  5
                order by if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', '')) ";

}
else if ($type == "Term") {
	$query = "select rec_ID,
	                 rec_Title,
	                 null,
	                 group_concat(rel_ptr_2.dtl_Value)
	            from Records
	       left join recDetails rel_ptr_1
	                          on rel_ptr_1.dtl_Value = rec_ID
	                         and rel_ptr_1.dtl_DetailTypeID = 5
	       left join recDetails rel_type
	                          on rel_type.dtl_RecID = rel_ptr_1.dtl_RecID
	                         and rel_type.dtl_DetailTypeID = 6
	                         and rel_type.dtl_Value in ({$termIDs['hasPrimarySubject']}, {$termIDs['hasSubject']})
	       left join recDetails rel_ptr_2
	                          on rel_ptr_2.dtl_RecID = rel_type.dtl_RecID
	                         and rel_ptr_2.dtl_DetailTypeID = 7
	           where rec_RecTypeID = 29
	        group by rec_ID
	        order by rec_Title";

} else if ($type == "Role") {
	$query = "select rec_ID,
	                 rec_Title,
	                 'Occupation'
	            from Records,
	                 recDetails
	           where rec_RecTypeID = 27
	             and dtl_RecID = rec_ID
	             and dtl_DetailTypeID = 95
	             and dtl_Value = {$termIDs['Occupation']}
	        order by if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', ''))";

} else if ($type == "Person") {
	$query = "select type.dtl_RecID,
	                 title.dtl_Value,
	                 null,
	                 group_concat(rel_ptr_2.dtl_Value)
	            from recDetails type
	      inner join recDetails title
	       left join recDetails rel_ptr_1
	                          on rel_ptr_1.dtl_Value = type.dtl_RecID
	                         and rel_ptr_1.dtl_DetailTypeID = 5
	       left join recDetails rel_type
	                          on rel_type.dtl_RecID = rel_ptr_1.dtl_RecID
	                         and rel_type.dtl_DetailTypeID = 6
	                         and rel_type.dtl_Value = {$termIDs['isAbout']}
	       left join recDetails rel_ptr_2
	                          on rel_ptr_2.dtl_RecID = rel_type.dtl_RecID
	                         and rel_ptr_2.dtl_DetailTypeID = 7
	           where type.dtl_DetailTypeID = 75
	             and type.dtl_Value = {$termIDs[$type]}
	             and title.dtl_RecID = type.dtl_RecID
	             and title.dtl_DetailTypeID = 1
	        group by type.dtl_RecID
	        order by if (title.dtl_Value like 'the %', substr(title.dtl_Value, 5), replace(title.dtl_Value, '\'', ''))";

} else if ($type == "Contributor") {
	$query = "select rec_ID,
	                 rec_Title,
	                 trm_Label
	            from Records,
	                 recDetails,
	                 defTerms
	           where rec_RecTypeID = 24
	             and dtl_RecID = rec_ID
	             and dtl_DetailTypeID = 74
	             and trm_ID = dtl_Value
	        order by if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', ''))";

} else {
	$query = "select type.dtl_RecID,
	                 title.dtl_Value,
	                 group_concat(distinct subtype.dtl_RecID),
	                 group_concat(distinct rel_ptr_2.dtl_Value)
	            from recDetails type
	      inner join recDetails title
	      inner join recDetails factoid_src_ptr
	      inner join recDetails factoid_type
	      inner join recDetails factoid_role_ptr
	      inner join recDetails subtype
	       left join recDetails rel_ptr_1
	                          on rel_ptr_1.dtl_Value = type.dtl_RecID
	                         and rel_ptr_1.dtl_DetailTypeID = 5
	       left join recDetails rel_type
	                          on rel_type.dtl_RecID = rel_ptr_1.dtl_RecID
	                         and rel_type.dtl_DetailTypeID = 6
	                         and rel_type.dtl_Value = {$termIDs['isAbout']}
	       left join recDetails rel_ptr_2
	                          on rel_ptr_2.dtl_RecID = rel_type.dtl_RecID
	                         and rel_ptr_2.dtl_DetailTypeID = 7
	           where type.dtl_DetailTypeID = 75
	             and type.dtl_Value = {$termIDs[$type]}
	             and title.dtl_RecID = type.dtl_RecID
	             and title.dtl_DetailTypeID = 1
	             and factoid_src_ptr.dtl_Value = title.dtl_RecID
	             and factoid_src_ptr.dtl_DetailTypeID = 87
	             and factoid_type.dtl_RecID = factoid_src_ptr.dtl_RecID
	             and factoid_type.dtl_DetailTypeID = 85
	             and factoid_type.dtl_Value = {$termIDs['Type']}
	             and factoid_role_ptr.dtl_RecID = factoid_src_ptr.dtl_RecID
	             and factoid_role_ptr.dtl_DetailTypeID = 88
	             and subtype.dtl_RecID = factoid_role_ptr.dtl_Value
	             and subtype.dtl_DetailTypeID = 1
	             and subtype.dtl_Value != {$termIDs['Generic']}
	        group by type.dtl_RecID
	        order by if (title.dtl_Value like 'the %', substr(title.dtl_Value, 5), replace(title.dtl_Value, '\'', ''))";
}

$res = mysql_query($query);
while ($row = mysql_fetch_row($res)) {
	$entity = array($row[1]);
	$types = @$row[2] ? split(",", $row[2]) : null;
	$entries = @$row[3] ? split(",", $row[3]) : null;
	if ($types || $entries) {
		array_push($entity, $types);
	}
	if ($entries) {
		array_push($entity, $entries);
	}
	$entities[$row[0]] = $entity;
	array_push($orderedEntities, $row[0]);
}

$subtypes = array();
$orderedSubtypes = array();

if ($type == "Entry") {
	$query = "select distinct if (entity_type_term.trm_Label is null, 'Thematic', entity_type_term.trm_Label),
	                 if (entity_type_term.trm_Label is null, 'Thematic Entries',
	                     concat(
	                            'Entries about ',
	                            if (entity_type_term.trm_Label = 'Person', 'People', concat(entity_type_term.trm_Label, 's'))
	                     )
	                 ),
	                 entry.rec_ID
	            from Records entry
	       left join recDetails rel_ptr_1
	                          on rel_ptr_1.dtl_Value = entry.rec_ID
	                         and rel_ptr_1.dtl_DetailTypeID = 7
	       left join recDetails rel_type
	                          on rel_type.dtl_RecID = rel_ptr_1.dtl_RecID
	                         and rel_type.dtl_DetailTypeID = 6
	                         and rel_type.dtl_Value = (select trm_ID from defTerms where trm_Label = 'isAbout')
	       left join recDetails rel_ptr_2
	                          on rel_ptr_2.dtl_RecID = rel_type.dtl_RecID
	                         and rel_ptr_2.dtl_DetailTypeID = 5
	       left join recDetails entity_type
	                          on entity_type.dtl_RecID = rel_ptr_2.dtl_Value
	                         and entity_type.dtl_DetailTypeID = 75
	       left join defTerms entity_type_term on trm_ID = entity_type.dtl_Value
	           where rec_RecTypeID = 13
	             and rec_ID != 2674
	        order by entity_type_term.trm_Label,
	                 if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', ''))";
} else if ($type == "Contributor") {
	$query = "select trm_Label, ".
					"if (trm_Label = 'author', 'Authors', ".
					"if (trm_Label = 'institution', 'Institutions and Collections', ".
					"if (trm_Label = 'public', 'Public', ".
					"if (trm_Label = 'supporter', 'Supporters', 'Other')))),
	                 rec_ID
	            from Records,
	                 recDetails,
	                 defTerms
	           where rec_RecTypeID = 24
	             and dtl_RecID = rec_ID
	             and dtl_DetailTypeID = 74
	             and trm_ID = dtl_Value
	        order by trm_Label, if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', ''))";
} else {
	$query = "select rec_ID,
	                 title.dtl_Value,
	                 factoid_src_ptr.dtl_Value
	            from Records,
	                 recDetails type,
	                 recDetails title,
	                 recDetails factoid_role_ptr,
	                 recDetails factoid_src_ptr,
	                 recDetails entity_type,
	                 recDetails entity_title
	           where rec_RecTypeID = 27
	             and type.dtl_RecID = rec_ID
	             and type.dtl_DetailTypeID = 95
	             and type.dtl_Value = 'Type'
	             and title.dtl_RecID = rec_ID
	             and title.dtl_DetailTypeID = 1
	             and factoid_role_ptr.dtl_Value = type.dtl_RecID
	             and factoid_role_ptr.dtl_DetailTypeID = 88
	             and factoid_src_ptr.dtl_RecID = factoid_role_ptr.dtl_RecID
	             and factoid_src_ptr.dtl_DetailTypeID = 87
	             and entity_type.dtl_RecID = factoid_src_ptr.dtl_Value
	             and entity_type.dtl_DetailTypeID = 75
	             and entity_type.dtl_Value = '$type'
	             and entity_title.dtl_RecID = factoid_src_ptr.dtl_Value
	             and entity_title.dtl_DetailTypeID = 1
	        order by title.dtl_Value, if (entity_title.dtl_Value like 'the %', substr(entity_title.dtl_Value, 5), replace(entity_title.dtl_Value, '\'', ''))";
		// order by sub-type title then entity title
}

$res = mysql_query($query);
while ($row = mysql_fetch_row($res)) {
	if (! @$subtypes[$row[0]]) {
		$subtypes[$row[0]] = array($row[1], array());
		array_push($orderedSubtypes, $row[0]);
	}
	array_push($subtypes[$row[0]][1], $row[2]);
}

// FIXME
if ($type == "Role") {
	$subtypes["Occupation"] = array("Occupation", $orderedEntities);
}

if ($type == "Entry") {
	$licenceTypes = array();
	$orderedLicenceTypes = array();
	$query = "select distinct if (trm_Label is null, 'other', trm_Label),
	                 entry.rec_ID
	            from Records entry
	       left join recDetails licence
	                          on licence.dtl_RecID = entry.rec_ID
	                         and licence.dtl_DetailTypeID = 94
	       left join defTerms
	                          on trm_ID = licence.dtl_Value
	           where rec_RecTypeID = 13
	             and rec_ID != 2674
	        order by trm_Label is null,
	                 trm_Label,
	                 if (rec_Title like 'the %', substr(rec_Title, 5), replace(rec_Title, '\'', ''))";
	$res = mysql_query($query);
	while ($row = mysql_fetch_row($res)) {
		if (! @$licenceTypes[$row[0]]) {
			$licenceTypes[$row[0]] = array();
			array_push($orderedLicenceTypes, $row[0]);
		}
		array_push($licenceTypes[$row[0]], $row[1]);
	}
}

print "if (! window.DOS) { DOS = {}; }\n";
print "if (! DOS.Browse) { DOS.Browse = {}; }\n";
if ($typePath) { print "DOS.Browse.pathBase = " . json_format($typePath) . ";\n"; }
print "DOS.Browse.entities = " . json_format($entities) . ";\n";
print "DOS.Browse.orderedEntities = " . json_format($orderedEntities) . ";\n";
print "DOS.Browse.subtypes = " . json_format($subtypes) . ";\n";
print "DOS.Browse.orderedSubtypes = " . json_format($orderedSubtypes) . ";\n";
if ($type == "Entry") {
	print "DOS.Browse.licenceTypes = " . json_format($licenceTypes) . ";\n";
	print "DOS.Browse.orderedLicenceTypes = " . json_format($orderedLicenceTypes) . ";\n";
}

?>
