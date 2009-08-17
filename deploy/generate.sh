# make sure we go direct to the server!
unset http_proxy

PIPELINE=http://heuristscholar.org/cocoon/relbrowser-kj


# copy files
echo "select file_id, file_nonce from files;" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id nonce; do cp /var/www/htdocs/uploaded-heurist-files/dos/$id files/full/$nonce; done

# generate resized images
echo "select file_nonce from files where file_mimetype like 'image%';" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read nonce; do
	if [[ ! -e files/thumbnail/$nonce ]]; then
		wget -O files/thumbnail/$nonce http://dos.heuristscholar.org/heurist/php/resize_image.php?file_id=$nonce\&w=148\&h=148;
	fi
	if [[ ! -e files/small/$nonce ]]; then
		wget -O files/small/$nonce http://dos.heuristscholar.org/heurist/php/resize_image.php?file_id=$nonce\&w=148;
	fi
	if [[ ! -e files/medium/$nonce ]]; then
		wget -O files/medium/$nonce http://dos.heuristscholar.org/heurist/php/resize_image.php?file_id=$nonce\&h=180;
	fi
	if [[ ! -e files/wide/$nonce ]]; then
		wget -O files/wide/$nonce http://dos.heuristscholar.org/heurist/php/resize_image.php?file_id=$nonce\&maxw=800\&maxh=400;
	fi
	if [[ ! -e files/large/$nonce ]]; then
		wget -O files/large/$nonce http://dos.heuristscholar.org/heurist/php/resize_image.php?file_id=$nonce\&maxw=698;
	fi
done

# generate pages for all appropriate records
echo "select rec_id from records where rec_type in (153,151,103,74,91,152,98);" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O item/$id $PIPELINE/item/$id; done

# generate popups for all multimedia records
echo "select rec_id from records where rec_type = 74;" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O popup/$id $PIPELINE/popup/$id; done

# generate KML for all entities
echo "select distinct b.rd_val from rec_details a left join rec_details b on a.rd_rec_id = b.rd_rec_id where a.rd_type = 526 and a.rd_val = 'TimePlace' and b.rd_type = 528;" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O kml/summary/$id.kml $PIPELINE/kml/summary/rename/$id; done

echo "select distinct b.rd_val from rec_details a left join rec_details b on a.rd_rec_id = b.rd_rec_id where a.rd_type in (177,178,230) and b.rd_type = 528;" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O kml/full/$id.kml $PIPELINE/kml/full/rename/$id; done

# generate browsing data
php entities-json.php Artefact > browse/artefacts.js
php entities-json.php Building > browse/buildings.js
php entities-json.php Event > browse/events.js
php entities-json.php "Natural feature" > browse/natural.js
php entities-json.php Organisation > browse/organisations.js
php entities-json.php Person > browse/people.js
php entities-json.php Place > browse/places.js
php entities-json.php Structure > browse/structures.js

php entities-json.php Entry > browse/entries.js
php entities-json.php Map > browse/maps.js
php entities-json.php Term > browse/subjects.js
php entities-json.php Role > browse/roles.js

# generate pages quietly and track progress at 1 minute intervals
#rm progress
#while [ 1 ]; do ls -1 item/ | wc -l >> progress; sleep 60; done &
#echo "select rec_id from records where rec_type in (153,151,103,74,91,152,98);" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O item/$id $PIPELINE/item/$id 2>/dev/null; done &

