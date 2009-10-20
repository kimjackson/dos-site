# make sure we go direct to the server!
unset http_proxy

PIPELINE=http://heuristscholar.org/cocoon/relbrowser-kj

REPO=repo

# create directories
mkdir item preview popup browse search kml kml/full kml/summary files files/thumbnail files/small files/medium files/wide files/large files/full
cp -prd $REPO/js $REPO/images $REPO/swf $REPO/*.css .


# copy files
echo "select file_id, file_nonce from files;" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id nonce; do
	if [[ ! -e files/full/$nonce ]]; then
		cp /var/www/htdocs/uploaded-heurist-files/dos/$id files/full/$nonce;
	fi
done

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

# generate URL map
php $REPO/deploy/urlmap.php > $REPO/xsl/urlmap.xml
wget --no-cache -O $REPO/xsl/urlmap.xsl $PIPELINE/urlmap-xsl

# create symbolic links
php $REPO/deploy/urlmap.php links > make_links.sh
. make_links.sh
rm make_links.sh

# generate pages, previews for all appropriate records
# 2674 is the Heuristos landing page
# 2675 is a link to Heuristos
echo "select rec_id from records left join rec_details on rd_rec_id = rec_id and rd_type = 591 where rec_type in (153,151,103,74,91,152,98) and if (rec_type = 91, rd_val in ('Occupation', 'Type'), 1) and rec_id not in (2674,2675);" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	wget --no-cache -O item/$id $PIPELINE/item-urlmapped/$id;
	wget --no-cache -O preview/$id $PIPELINE/preview/$id;
done

# generate previews for all records in all necessary contexts
grep -r 'preview-[0-9]' item | perl -pe 's/.*preview-(\d+(c\d+)?).*/\1/' | sort | uniq | \
while read id; do
	if [[ ! -e preview/$id ]]; then
		wget --no-cache -O preview/$id $PIPELINE/preview/$id;
	fi
done

# generate popups for all multimedia records
echo "select rec_id from records where rec_type = 74;" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O popup/$id $PIPELINE/popup-urlmapped/$id; done

# generate KML for all entities
echo "select distinct b.rd_val from rec_details a left join rec_details b on a.rd_rec_id = b.rd_rec_id where a.rd_type = 526 and a.rd_val = 'TimePlace' and b.rd_type = 528;" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O kml/summary/$id.kml $PIPELINE/kml/summary/rename/$id; done

echo "select distinct b.rd_val from rec_details a left join rec_details b on a.rd_rec_id = b.rd_rec_id where a.rd_type in (177,178,230) and b.rd_type = 528;" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O kml/full/$id.kml $PIPELINE/kml/full/rename/$id; done

# generate browsing data
php $REPO/deploy/entities-json.php Artefact artefact > browse/artefacts.js
php $REPO/deploy/entities-json.php Building building > browse/buildings.js
php $REPO/deploy/entities-json.php Event event > browse/events.js
php $REPO/deploy/entities-json.php "Natural feature" natural_feature > browse/natural.js
php $REPO/deploy/entities-json.php Organisation organisation > browse/organisations.js
php $REPO/deploy/entities-json.php Person person > browse/people.js
php $REPO/deploy/entities-json.php Place place > browse/places.js
php $REPO/deploy/entities-json.php Structure structure > browse/structures.js

php $REPO/deploy/entities-json.php Entry entry > browse/entries.js
php $REPO/deploy/entities-json.php Map map > browse/maps.js
php $REPO/deploy/entities-json.php Term subject > browse/subjects.js
php $REPO/deploy/entities-json.php Role role > browse/roles.js
php $REPO/deploy/entities-json.php Contributor contributor > browse/contributors.js

wget --no-cache -O browse/artefacts $PIPELINE/browse/artefacts
wget --no-cache -O browse/buildings $PIPELINE/browse/buildings
wget --no-cache -O browse/events $PIPELINE/browse/events
wget --no-cache -O browse/natural $PIPELINE/browse/natural
wget --no-cache -O browse/organisations $PIPELINE/browse/organisations
wget --no-cache -O browse/people $PIPELINE/browse/people
wget --no-cache -O browse/places $PIPELINE/browse/places
wget --no-cache -O browse/structures $PIPELINE/browse/structures
wget --no-cache -O browse/entries $PIPELINE/browse/entries
wget --no-cache -O browse/maps $PIPELINE/browse/maps
wget --no-cache -O browse/subjects $PIPELINE/browse/subjects
wget --no-cache -O browse/roles $PIPELINE/browse/roles

wget --no-cache -O search/search_template.html $PIPELINE/search

# generate pages quietly and track progress at 1 minute intervals
#rm progress
#while [ 1 ]; do ls -1 item/ | wc -l >> progress; sleep 60; done &
#echo "select rec_id from records left join rec_details on rd_rec_id = rec_id and rd_type = 591 where rec_type in (153,151,103,74,91,152,98) and if (rec_type = 91, rd_val in ('Occupation', 'Type'), 1);" | mysql -s -u readonly -pmitnick heuristdb-dos | while read id; do wget --no-cache -O item/$id $PIPELINE/item-urlmapped/$id 2>/dev/null; done &

