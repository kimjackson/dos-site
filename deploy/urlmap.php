<?php

define('HEURIST_INSTANCE', 'dos');
define('DATABASE', '`heuristdb-dos`');

require_once('/var/www/htdocs/heurist/php/modules/db.php');
require_once('/var/www/htdocs/heurist/php/modules/loading.php');

mysql_connection_db_select('`heuristdb-dos`');

$path_to_id = array();

echo "<map>\n";

// contributors, entities, roles, terms, entries
$res = mysql_query('select rec_id from records where rec_type in (153,151,91,152,98) and ! rec_temporary');
while ($row = mysql_fetch_row($res)) {
	$record = loadRecord($row[0], false, true);
	$id = $record['rec_id'];
	$path = getRecordType($record) . '/' . getTitle($record);
	if (array_key_exists($path, $path_to_id)) {
		echo "Conflict: $path: " . $path_to_id[$path] . ", $id\n";
		exit;
	}
	$path_to_id[$path] = $id;

	echo "<record><id>$id</id><path>$path</path></record>\n";
}

// media
$res = mysql_query('select rec_id, if (rd_val like "image/%", "image", if (rd_val like "audio/%", "audio", "video"))
                      from records, rec_details
                     where rec_type = 74
                       and rd_rec_id = rec_id
                       and rd_type = 289
                       and (rd_val like "image/%" or rd_val like "audio/" or rd_val like "video/%")');
while ($row = mysql_fetch_row($res)) {
	$id = $row[0];
	$path = $row[1] . '/' . $id;
	// we use IDs so no need to check for collisions
	echo "<record><id>$id</id><path>$path</path></record>\n";
}

$res = mysql_query('select rec_id from records where rec_type = 103');
while ($row = mysql_fetch_row($res)) {
	$id = $row[0];
	$path = 'map/' . $id;
	// we use IDs so no need to check for collisions
	echo "<record><id>$id</id><path>$path</path></record>\n";
}
echo "</map>\n";



function getTitle($record) {
	foreach ($record['details'][160] as $detailID => $value) {
		return str_replace('&', '&amp;', (str_replace(' ', '_', mb_strtolower($value, 'UTF-8'))));
	}
}

function getEntityType($record) {
	foreach ($record['details'][523] as $detailID => $value) {
		return str_replace(' ', '_', strtolower($value));
	}
}

function getRecordType($record) {
	switch ($record['rec_type']) {
	case 153:
		return 'contributor';
		break;
	case 98:
		return 'entry';
		break;
	case 91:
		return 'role';
		break;
	case 152:
		return 'subject';
		break;
	case 151:
		return getEntityType($record);
		break;
	}
}

