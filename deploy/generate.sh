# make sure we go direct to the server!
unset http_proxy

PIPELINE=http://heuristscholar.org/cocoon/relbrowser-kj

REPO=repo

# create directories
mkdir item preview popup browse search kml kml/full kml/summary files files/thumbnail files/small files/medium files/wide files/large files/full $REPO/hml
cp -prd $REPO/js $REPO/images $REPO/swf $REPO/*.css $REPO/config.xml $REPO/contact.php .
cp -pd $REPO/jquery $REPO/timemap.js $REPO/timeline $REPO/recaptcha .
ln -s ../dos-map-tiles tiles


# copy files
echo "select distinct file_id, file_nonce from rec_details, files where file_id = rd_file_id;" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id nonce; do
	if [[ ! -e files/full/$nonce ]]; then
		cp /var/www/htdocs/uploaded-heurist-files/dos/$id files/full/$nonce;
	fi
done

# generate resized images
echo "select distinct file_nonce from rec_details, files where file_id = rd_file_id and file_mimetype like 'image%';" | mysql -s -u readonly -pmitnick heuristdb-dos | \
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
php $REPO/deploy/urlmap.php spider-links > make_spider_links.sh
. make_links.sh
. make_spider_links.sh
rm make_links.sh
rm make_spider_links.sh

# generate XML for all required items
. $REPO/deploy/hml.sh

# generate pages, previews for all appropriate records
# 2674 is the Heuristos landing page
# 2675 is a link to Heuristos
ALL_ITEMS_QUERY="select rec_id
                   from records
              left join rec_details rt on rt.rd_rec_id = rec_id and rt.rd_type = 591
              left join rec_details ilt on ilt.rd_rec_id = rec_id and ilt.rd_type = 618
                  where rec_type in (153,151,103,74,91,152,98,168)
                    and if (rec_type = 91, rt.rd_val in ('Occupation', 'Type'), 1)
                    and if (rec_type = 168, ilt.rd_val = 'image', 1)
                    and rec_id not in (2674,2675);"
NOT_ENTIRES_QUERY="select rec_id
                   from records
              left join rec_details rt on rt.rd_rec_id = rec_id and rt.rd_type = 591
              left join rec_details ilt on ilt.rd_rec_id = rec_id and ilt.rd_type = 618
                  where rec_type in (153,151,103,74,91,152,168)
                    and if (rec_type = 91, rt.rd_val in ('Occupation', 'Type'), 1)
                    and if (rec_type = 168, ilt.rd_val = 'image', 1)
                    and rec_id not in (2674,2675);"
ALL_ENTRIES_QUERY="select rec_id
                   from records
                  where rec_type = 98
                    and rec_id not in (2674,2675);"

cd item
echo $NOT_ENTIRES_QUERY | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ -e ../$REPO/hml/$id.xml  &&  ! -e $id ]]; then
		echo $PIPELINE/item-urlmapped/$id;
	fi
done | \
wget --no-cache -w 1 -i -
echo $ALL_ENTRIES_QUERY | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ -e ../$REPO/hml/$id.xml  &&  ! -e $id ]]; then
		echo $PIPELINE/item-entry-urlmapped/$id;
	fi
done | \
wget --no-cache -w 1 -i -
cd ..

cd preview
echo $ALL_ITEMS_QUERY | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ ! -e $id ]]; then
		echo $PIPELINE/preview/$id;
	fi
done | \
wget --no-cache -w 1 -i -
cd ..

# generate previews for all records in all necessary contexts
cd preview
grep -r 'preview-[0-9]' ../item | perl -pe 's/.*preview-(\d+(c\d+)?).*/\1/' | sort | uniq | \
while read id; do
	if [[ ! -e $id ]]; then
		echo $PIPELINE/preview/$id;
	fi
done | \
wget --no-cache -i -
cd ..

# generate popups for all multimedia records
cd popup
echo "select rec_id from records left join rec_details on rd_rec_id = rec_id and rd_type = 618 where (rec_type = 74) or (rec_type = 168 and rd_val = 'image');" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ ! -e $id ]]; then
		echo $PIPELINE/popup-urlmapped/$id;
	fi
done | \
wget --no-cache -i -
cd ..

# generate KML for all entities
echo "select distinct b.rd_val from rec_details a left join rec_details b on a.rd_rec_id = b.rd_rec_id where a.rd_type = 526 and a.rd_val = 'TimePlace' and b.rd_type = 528;" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ ! -e kml/summary/$id.kml ]]; then
		wget --no-cache -O kml/summary/$id.kml $PIPELINE/kml/summary/rename/$id;
	fi
done

echo "select distinct b.rd_val from rec_details a left join rec_details b on a.rd_rec_id = b.rd_rec_id where a.rd_type in (177,178,230) and b.rd_type = 528;" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ ! -e kml/full/$id.kml ]]; then
		wget --no-cache -O kml/full/$id.kml $PIPELINE/kml/full/rename/$id;
	fi
done

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
wget --no-cache -O browse/contributors $PIPELINE/browse/contributors

wget --no-cache -O search/search_template.html $PIPELINE/search

wget --no-cache -O about.html $PIPELINE/about
wget --no-cache -O contact.html $PIPELINE/contact
wget --no-cache -O contribute.html $PIPELINE/contribute
wget --no-cache -O copyright.html $PIPELINE/copyright
wget --no-cache -O faq.html $PIPELINE/faq

wget --no-cache -O index.html $PIPELINE/

# run zoom indexer over spider-* directories
# rm -rf spider-*
chmod +x search/search.cgi


rsync -av about.html artefact audio boxy-ie.css boxy.css browse building config.xml contact.html contact.php contribute.html contributor copyright.html entry event faq.html image images index.html item jquery js kml map natural_feature organisation person place popup preview recaptcha role search search.css structure style.css subject swf tiles timeline timemap.js video kimj@dos-web-prd-1.ucc.usyd.edu.au:/var/www/dos-2009-12-03/

rsync -av ../dos-static-2009-10-22/files/ kimj@dos-web-prd-1.ucc.usyd.edu.au:/var/www/files/

# on production server:
perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2009-12-03/../' item/*
perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2009-12-03/../' popup/*
perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2009-12-03/http:\/\/dictionaryofsydney.org/' `grep -l heurist preview/*`
perl -pi -e 's/ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w/ABQIAAAA5wNKmbSIriGRr4NY0snaURTtHC9RsOn6g1vDRMmqV_X8ivHa_xSNBstkFn6GHErY6WRDLHcEp1TxkQ/' `grep -l maps.google.com item/*`

