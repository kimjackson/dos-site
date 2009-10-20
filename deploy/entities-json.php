<?php

require_once("/var/www/htdocs/heurist/php/modules/db.php");

mysql_connection_db_select("`heuristdb-dos`");


if ($argc < 2) {
	print "Usage: php " . $argv[0] . " <type> [<typePath>]\n";
	exit(1);
}

$type = $argv[1];
$typePath = @$argv[2];


$entities = array();
$orderedEntities = array();

if ($type == "Entry") {
	$query = "select rec_id,
	                 rec_title
	            from records
	           where rec_type = 98
	        order by if (rec_title like 'the %', substr(rec_title, 5), replace(rec_title, '\'', ''))";

} else if ($type == "Map") {
	$query = "select rec_id,
	                 rec_title
	            from records
	           where rec_type = 103
	        order by if (rec_title like 'the %', substr(rec_title, 5), replace(rec_title, '\'', ''))";

} else if ($type == "Term") {
	$query = "select rec_id,
	                 rec_title,
	                 null,
	                 group_concat(rel_ptr_2.rd_val)
	            from records
	       left join rec_details rel_ptr_1
	                          on rel_ptr_1.rd_val = rec_id
	                         and rel_ptr_1.rd_type = 199
	       left join rec_details rel_type
	                          on rel_type.rd_rec_id = rel_ptr_1.rd_rec_id
	                         and rel_type.rd_type = 200
	                         and rel_type.rd_val in ('hasPrimarySubject', 'hasSubject')
	       left join rec_details rel_ptr_2
	                          on rel_ptr_2.rd_rec_id = rel_type.rd_rec_id
	                         and rel_ptr_2.rd_type = 202
	           where rec_type = 152
	        group by rec_id
	        order by rec_title";

} else if ($type == "Role") {
	$query = "select rec_id,
	                 rec_title,
	                 rd_val
	            from records,
	                 rec_details
	           where rec_type = 91
	             and rd_rec_id = rec_id
	             and rd_type = 591
	             and rd_val = 'Occupation'
	        order by if (rec_title like 'the %', substr(rec_title, 5), replace(rec_title, '\'', ''))";

} else if ($type == "Person") {
	$query = "select type.rd_rec_id,
	                 title.rd_val,
	                 null,
	                 group_concat(rel_ptr_2.rd_val)
	            from rec_details type
	      inner join rec_details title
	       left join rec_details rel_ptr_1
	                          on rel_ptr_1.rd_val = type.rd_rec_id
	                         and rel_ptr_1.rd_type = 199
	       left join rec_details rel_type
	                          on rel_type.rd_rec_id = rel_ptr_1.rd_rec_id
	                         and rel_type.rd_type = 200
	                         and rel_type.rd_val = 'isAbout'
	       left join rec_details rel_ptr_2
	                          on rel_ptr_2.rd_rec_id = rel_type.rd_rec_id
	                         and rel_ptr_2.rd_type = 202
	           where type.rd_type = 523
	             and type.rd_val = '$type'
	             and title.rd_rec_id = type.rd_rec_id
	             and title.rd_type = 160
	        group by type.rd_rec_id
	        order by if (title.rd_val like 'the %', substr(title.rd_val, 5), replace(title.rd_val, '\'', ''))";

} else if ($type == "Contributor") {
	$query = "select rec_id,
	                 rec_title,
	                 rd_val
	            from records,
	                 rec_details
	           where rec_type = 153
	             and rd_rec_id = rec_id
	             and rd_type = 568
	        order by if (rec_title like 'the %', substr(rec_title, 5), replace(rec_title, '\'', ''))";

} else {
	$query = "select type.rd_rec_id,
	                 title.rd_val,
	                 group_concat(distinct subtype.rd_rec_id),
	                 group_concat(distinct rel_ptr_2.rd_val)
	            from rec_details type
	      inner join rec_details title
	      inner join rec_details factoid_src_ptr
	      inner join rec_details factoid_type
	      inner join rec_details factoid_role_ptr
	      inner join rec_details subtype
	       left join rec_details rel_ptr_1
	                          on rel_ptr_1.rd_val = type.rd_rec_id
	                         and rel_ptr_1.rd_type = 199
	       left join rec_details rel_type
	                          on rel_type.rd_rec_id = rel_ptr_1.rd_rec_id
	                         and rel_type.rd_type = 200
	                         and rel_type.rd_val = 'isAbout'
	       left join rec_details rel_ptr_2
	                          on rel_ptr_2.rd_rec_id = rel_type.rd_rec_id
	                         and rel_ptr_2.rd_type = 202
	           where type.rd_type = 523
	             and type.rd_val = '$type'
	             and title.rd_rec_id = type.rd_rec_id
	             and title.rd_type = 160
	             and factoid_src_ptr.rd_val = title.rd_rec_id
	             and factoid_src_ptr.rd_type = 528
	             and factoid_type.rd_rec_id = factoid_src_ptr.rd_rec_id
	             and factoid_type.rd_type = 526
	             and factoid_type.rd_val = 'Type'
	             and factoid_role_ptr.rd_rec_id = factoid_src_ptr.rd_rec_id
	             and factoid_role_ptr.rd_type = 529
	             and subtype.rd_rec_id = factoid_role_ptr.rd_val
	             and subtype.rd_type = 160
	             and subtype.rd_val != 'Generic'
	        group by type.rd_rec_id
	        order by if (title.rd_val like 'the %', substr(title.rd_val, 5), replace(title.rd_val, '\'', ''))";
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
	$query = "select if (entity_type.rd_val is null, 'Thematic', entity_type.rd_val),
	                 if (entity_type.rd_val is null, 'Thematic Entries',
	                     concat(
	                            'Entries about ',
	                            if (entity_type.rd_val = 'Person', 'People', concat(entity_type.rd_val, 's'))
	                     )
	                 ),
	                 entry.rec_id,
	                 entry.rec_title
	            from records entry
	       left join rec_details rel_ptr_1
	                          on rel_ptr_1.rd_val = entry.rec_id
	                         and rel_ptr_1.rd_type = 202
	       left join rec_details rel_type
	                          on rel_type.rd_rec_id = rel_ptr_1.rd_rec_id
	                         and rel_type.rd_type = 200
	                         and rel_type.rd_val = 'isAbout'
	       left join rec_details rel_ptr_2
	                          on rel_ptr_2.rd_rec_id = rel_type.rd_rec_id
	                         and rel_ptr_2.rd_type = 199
	       left join rec_details entity_type
	                          on entity_type.rd_rec_id = rel_ptr_2.rd_val
	                         and entity_type.rd_type = 523
	           where rec_type = 98
	        order by entity_type.rd_val,
	                 if (rec_title like 'the %', substr(rec_title, 5), replace(rec_title, '\'', ''))";
} else if ($type == "Contributor") {
	$query = "select rd_val,
	                 if (rd_val = 'public', 'Other', concat(upper(substring(rd_val, 1, 1)), substring(rd_val from 2))),
	                 rec_id
	            from records,
	                 rec_details
	           where rec_type = 153
	             and rd_rec_id = rec_id
	             and rd_type = 568
	        order by rd_val, if (rec_title like 'the %', substr(rec_title, 5), replace(rec_title, '\'', ''))";
} else {
	$query = "select rec_id,
	                 title.rd_val,
	                 factoid_src_ptr.rd_val
	            from records,
	                 rec_details type,
	                 rec_details title,
	                 rec_details factoid_role_ptr,
	                 rec_details factoid_src_ptr,
	                 rec_details entity_type,
	                 rec_details entity_title
	           where rec_type = 91
	             and type.rd_rec_id = rec_id
	             and type.rd_type = 591
	             and type.rd_val = 'Type'
	             and title.rd_rec_id = rec_id
	             and title.rd_type = 160
	             and factoid_role_ptr.rd_val = type.rd_rec_id
	             and factoid_role_ptr.rd_type = 529
	             and factoid_src_ptr.rd_rec_id = factoid_role_ptr.rd_rec_id
	             and factoid_src_ptr.rd_type = 528
	             and entity_type.rd_rec_id = factoid_src_ptr.rd_val
	             and entity_type.rd_type = 523
	             and entity_type.rd_val = '$type'
	             and entity_title.rd_rec_id = factoid_src_ptr.rd_val
	             and entity_title.rd_type = 160
	        order by title.rd_val, if (entity_title.rd_val like 'the %', substr(entity_title.rd_val, 5), replace(entity_title.rd_val, '\'', ''))";
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


print "if (! window.DOS) { DOS = {}; }\n";
print "if (! DOS.Browse) { DOS.Browse = {}; }\n";
if ($typePath) { print "DOS.Browse.pathBase = " . json_format($typePath) . ";\n"; }
print "DOS.Browse.entities = " . json_format($entities) . ";\n";
print "DOS.Browse.orderedEntities = " . json_format($orderedEntities) . ";\n";
print "DOS.Browse.subtypes = " . json_format($subtypes) . ";\n";
print "DOS.Browse.orderedSubtypes = " . json_format($orderedSubtypes) . ";\n";

?>
