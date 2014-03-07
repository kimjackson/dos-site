#####################################################
##!!!!!!First Read README in current repo directory##
#####################################################
#check disk space df -h  and/or du -ha| grep M

### STEP 1
##########################################################################################
#setup environment and copy files
# make sure we go direct to the server!
unset http_proxy

PIPELINE=http://localhost:8889/

REPO=repo

# create directories
mkdir item preview popup browse citation search kml kml/full kml/summary $REPO/hml
# sync files from prod web server
rsync -av -e 'ssh -i /home/ubuntu/aws-dos.pem' ubuntu@172.31.3.188:/var/www/files .
cp -prd $REPO/js $REPO/images $REPO/swf $REPO/*.css $REPO/index.html $REPO/config.xml .
cp -prL $REPO/jquery $REPO/timemap.js $REPO/timeline .
# TODO: just keep one map's tiles in this AMI for testing of map functionality?
# ln -s ../dos-map-tiles tiles


####STEP 2 Generate supporting files NOTE run each command separately to verify correctness
############################################################################################
# run all required queries
echo "select distinct ulf_ObfuscatedFileID, concat(ulf_FilePath, ulf_FileName) from recDetails, recUploadedFiles where ulf_ID = dtl_UploadedFileID;" | mysql -s -u roH3 -pro4all hdb_dos > file_names.txt
echo "select distinct ulf_ObfuscatedFileID from recDetails, recUploadedFiles where ulf_ID = dtl_UploadedFileID and ulf_MimeExt in ('jpeg', 'jpg', 'png');" | mysql -s -u roH3 -pro4all hdb_dos > image_files.txt
# 2674 is the Heuristos landing page
# 2675 is a link to Heuristos
ALL_ITEMS_QUERY="select rec_ID
                   from Records
              left join recDetails rt on rt.dtl_RecID = rec_ID and rt.dtl_DetailTypeID = 95
              left join recDetails ilt on ilt.dtl_RecID = rec_ID and ilt.dtl_DetailTypeID = 30
              left join defTerms rt_term on rt_term.trm_ID = rt.dtl_Value
              left join defTerms ilt_term on ilt_term.trm_ID = ilt.dtl_Value
                  where rec_RecTypeID in (24,25,28,5,27,29,13,11)
                    and if (rec_RecTypeID = 27, rt_term.trm_Label in ('Occupation', 'Type'), 1)
                    and if (rec_RecTypeID = 11, ilt_term.trm_Label = 'image', 1)
                    and rec_ID not in (2674,2675);"
NOT_ENTRIES_QUERY="select rec_ID
                   from Records
              left join recDetails rt on rt.dtl_RecID = rec_ID and rt.dtl_DetailTypeID = 95
              left join recDetails ilt on ilt.dtl_RecID = rec_ID and ilt.dtl_DetailTypeID = 30
              left join defTerms rt_term on rt_term.trm_ID = rt.dtl_Value
              left join defTerms ilt_term on ilt_term.trm_ID = ilt.dtl_Value
                  where rec_RecTypeID in (24,25,28,5,27,29,11)
                    and if (rec_RecTypeID = 27, rt_term.trm_Label in ('Occupation', 'Type'), 1)
                    and if (rec_RecTypeID = 11, ilt_term.trm_Label = 'image', 1)
                    and rec_ID not in (2674,2675);"
ALL_ENTRIES_QUERY="select rec_ID
                   from Records
                  where rec_RecTypeID = 13
                    and rec_ID not in (2674,2675);"
echo $NOT_ENTRIES_QUERY | mysql -s -u roH3 -pro4all hdb_dos > not_entries.txt
echo $ALL_ENTRIES_QUERY | mysql -s -u roH3 -pro4all hdb_dos > all_entries.txt
echo $ALL_ITEMS_QUERY | mysql -s -u roH3 -pro4all hdb_dos > all_items.txt

# popups and KML files
echo "select rec_ID from Records left join recDetails on dtl_RecID = rec_ID and dtl_DetailTypeID = 30 left join defTerms on trm_ID = dtl_Value where (rec_RecTypeID = 5) or (rec_RecTypeID = 11 and trm_Label = 'image');" | mysql -s -u roH3 -pro4all hdb_dos > popups.txt

KML_SUMMARY_QUERY="select distinct b.dtl_Value
                     from recDetails a
                left join recDetails b on a.dtl_RecID = b.dtl_RecID
                left join defTerms on trm_ID = a.dtl_Value
                    where a.dtl_DetailTypeID = 85 and trm_Label = 'TimePlace' and b.dtl_DetailTypeID = 87;"
echo $KML_SUMMARY_QUERY | mysql -s -u roH3 -pro4all hdb_dos > kml_summary.txt


KML_FULL_QUERY="select distinct b.dtl_Value
                  from recDetails a
             left join recDetails b on a.dtl_RecID = b.dtl_RecID
                 where a.dtl_DetailTypeID in (10,11,28) and b.dtl_DetailTypeID = 87;"


echo $KML_FULL_QUERY | mysql -s -u roH3 -pro4all hdb_dos > kml_full.txt

# generate URL map
php $REPO/deploy/urlmap.php check  # until errors are fixed

php $REPO/deploy/urlmap.php > $REPO/xsl/urlmap.xml
php $REPO/deploy/urlmap.php links > make_links.sh
php $REPO/deploy/urlmap.php spider-links > make_spider_links.sh

# generate browsing data
php $REPO/deploy/entities-json.php Artefact artefact > browse/artefacts.js
php $REPO/deploy/entities-json.php Building building > browse/buildings.js
php $REPO/deploy/entities-json.php Event event > browse/events.js
php $REPO/deploy/entities-json.php "Natural feature" natural_feature > browse/natural.js
php $REPO/deploy/entities-json.php Organisation organisation > browse/organisations.js
php $REPO/deploy/entities-json.php Person person > browse/people.js
php $REPO/deploy/entities-json.php Place place > browse/places.js
php $REPO/deploy/entities-json.php Structure structure > browse/structures.js
# newly added browse type Nov 2011
php $REPO/deploy/entities-json.php Multimedia multimedia > browse/multimedia.js

php $REPO/deploy/entities-json.php Entry entry > browse/entries.js
php $REPO/deploy/entities-json.php Map map > browse/maps.js
php $REPO/deploy/entities-json.php Term subject > browse/subjects.js
php $REPO/deploy/entities-json.php Role role > browse/roles.js
php $REPO/deploy/entities-json.php Contributor contributor > browse/contributors.js

###STEP 3 Generate all records hml  NOTE this will take several hours.
##########################################################################################
# consider using "screen -S genHML" and then start the command below and
# then detach "ctrl+A d"  and "screen -r genHML" to reattach
# when the command is finished just "exit" from screen

# generate XML for all required items
. $REPO/deploy/hml.sh


########################################
### END HEURIST-DEPENDENT OPERATIONS ###
########################################

###STEP 4 Generate content files
##########################################################################################
# THE FOLLOWING STEPS CAN TAKE A WHILE TO COMPLETE
# CONSIDER using "screen -S genContent" and then start the commands below and
# then detach "ctrl+A d"  and "screen -r genHML" to reattach
# when the command is finished just "exit" from screen
# this will allow you to dhut down you machine and reconnect at anytime.

# copy files
##########################################################################################
cat file_names.txt | \
while read nonce file; do
	if [[ ! -s files/full/$nonce ]]; then
		cp "$file" files/full/$nonce;
	fi
done

# generate resized images
##########################################################################################
cat image_files.txt | \
while read nonce; do
	if [[ ! -s files/thumbnail/$nonce ]]; then
		wget -O files/thumbnail/$nonce http://localhost/h3/common/php/resizeImage.php?ulf_ID=$nonce\&w=148\&h=148;
	fi
	if [[ ! -s files/small/$nonce ]]; then
		wget -O files/small/$nonce http://localhost/h3/common/php/resizeImage.php?ulf_ID=$nonce\&w=148;
	fi
	if [[ ! -s files/medium/$nonce ]]; then
		wget -O files/medium/$nonce http://localhost/h3/common/php/resizeImage.php?ulf_ID=$nonce\&h=180;
	fi
	if [[ ! -s files/wide/$nonce ]]; then
		wget -O files/wide/$nonce http://localhost/h3/common/php/resizeImage.php?ulf_ID=$nonce\&maxw=800\&maxh=400;
	fi
	if [[ ! -s files/large/$nonce ]]; then
		wget -O files/large/$nonce http://localhost/h3/common/php/resizeImage.php?ulf_ID=$nonce\&maxw=698;
	fi
done


# generate URL map
##########################################################################################
wget --no-cache -O $REPO/xsl/urlmap.xsl $PIPELINE/urlmap-xsl

# create symbolic links
. make_links.sh
. make_spider_links.sh
rm make_links.sh
rm make_spider_links.sh

# generate pages, previews for all appropriate records
##########################################################################################

cd item
cat ../not_entries.txt | \
while read id; do
	if [[ -s ../$REPO/hml/$id.xml  &&  ! -s $id ]]; then
		echo $PIPELINE/item-urlmapped/$id;
	fi
done | \
wget --no-cache -w 1 -i -

cat ../all_entries.txt | \
while read id; do
	if [[ -s ../$REPO/hml/$id.xml  &&  ! -s $id ]]; then
		echo $PIPELINE/item-entry-urlmapped/$id;
	fi
done | \
wget --no-cache -w 1 -i -
cd ..

cd preview
cat ../all_items.txt | \
while read id; do
	if [[ -s ../$REPO/hml/$id.xml  &&  ! -s $id ]]; then
		echo $PIPELINE/preview/$id;
	fi
done | \
wget --no-cache -w 1 -i -
cd ..


# added by Steven Hayes Nov 2011 to generate citations for all entries
cd citation
cat ../all_entries.txt | \
while read id; do
	if [[ -s ../$REPO/hml/$id.xml  &&  ! -s $id ]]; then
		echo $PIPELINE/citation/$id;
	fi
done | \
wget --no-cache -w 1 -i -
cd ..


# generate previews for all records in all necessary contexts
##########################################################################################
grep -r 'preview-[0-9]' item | perl -pe 's/.*preview-(\d+(c\d+)?).*/\1/' | sort | uniq > preview_contexts.txt
cd preview
cat ../preview_contexts.txt | while read id; do
	base_id=`echo $id | sed 's/c.*//'`
	if [[ -s ../$REPO/hml/$base_id.xml  &&  ! -s $id ]]; then
		echo $PIPELINE/preview/$id;
	fi
done | \
wget --no-cache -i -
cd ..

# generate popups for all multimedia records
##########################################################################################
cd popup
cat ../popups.txt | \
while read id; do
	if [[ -s ../$REPO/hml/$id.xml  &&  ! -s $id ]]; then
		echo $PIPELINE/popup-urlmapped/$id;
	fi
done | \
wget --no-cache -i -
cd ..

# generate KML for all entities
##########################################################################################
cat kml_summary.txt | \
while read id; do
	if [[ ! -s kml/summary/$id.kml ]]; then
		wget --no-cache -O kml/summary/$id.kml $PIPELINE/kml/summary/rename/$id;
	fi
done

cat kml_full.txt | \
while read id; do
	if [[ ! -s kml/full/$id.kml ]]; then
		wget --no-cache -O kml/full/$id.kml $PIPELINE/kml/full/rename/$id;
	fi
done

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

#new browse method added in Nov 2011
wget --no-cache -O browse/multimedia $PIPELINE/browse/multimedia

wget --no-cache -O search/search_template.html $PIPELINE/search

#wget --no-cache -O about.html $PIPELINE/about
#wget --no-cache -O contact.html $PIPELINE/contact
#wget --no-cache -O contribute.html $PIPELINE/contribute
#wget --no-cache -O copyright.html $PIPELINE/copyright
#wget --no-cache -O faq.html $PIPELINE/faq

#wget --no-cache -O index.html $PIPELINE/

wget --no-cache -O browse.html $PIPELINE/browse

# run zoom indexer over spider-* directories
# this can be done on any machine with zoom indexer.
# open repo/dossearch.xcfg (having updated pathes the new dates)
# this will generate the index files for the site.
# NOTE the search engine that we generate is CGI for speed and you WILL
#      NEED to ENSURE that the search directory is enable to run the script
#      OR the binary script file gets downloaded as crud into the browser.

#remove the index links
# rm -rf spider-*
chmod +x search/search.cgi

#######
##DONE with the generation this should now be a working site at http://heuristscholar.org/dos-static-2011-05-20
#######ssh

#COPY the files up to the production server into a new directory
#su as kjackson to run this command
rsync -av artefact audio boxy-ie.css boxy.css browse index.html browse.html building citation config.xml contributor entry event image images item jquery js kml map natural_feature organisation person place popup preview recaptcha role search search.css structure style.css subject swf tiles timeline timemap.js video kimj@dos-web-prd-1.ucc.usyd.edu.au:/var/www/dos-2013-02-15/

#sync the uploaded files
rsync -av ../dos-static-2009-10-22/files/ kimj@dos-web-prd-1.ucc.usyd.edu.au:/var/www/files/

rsync -av recaptcha kimj@dos-web-prd-1.ucc.usyd.edu.au:/var/www/dos-2012-09-15/

##########################
## on production server:##
##########################
cd /var/www/dos-2012-09-15
#replace dynamic links on built version to the relative links for the static production version
# old way gets Arg list too long error		perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2012-02-24/../' item/*
grep -rl dos-static-2012-02-24 item |\
while read filename; do
	perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2012-02-24/../' $filename;
done

# old way gets Arg list too long error		perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2012-02-24/../' popup/*
grep -rl dos-static-2012-02-24 popup |\
while read filename; do
	perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2012-02-24/../' $filename;
done

grep -rl heurist preview |\
while read filename; do
	perl -pi -e 's/http:\/\/heuristscholar.org\/dos-static-2012-02-24/http:\/\/dictionaryofsydney.org/' $filename;
done

#change the google key to the production key
grep -rl maps.google.com item |\
while read filename; do
	perl -pi -e 's/ABQIAAAAGZugEZOePOFa_Kc5QZ0UQRQUeYPJPN0iHdI_mpOIQDTyJGt-ARSOyMjfz0UjulQTRjpuNpjk72vQ3w/ABQIAAAA5wNKmbSIriGRr4NY0snaURTtHC9RsOn6g1vDRMmqV_X8ivHa_xSNBstkFn6GHErY6WRDLHcEp1TxkQ/' $filename
done

# create production site sym links
##########################################################################################
ln -fs ../files
ln -fs ../tiles
ln -s ../test
ln -s ../previous
cd /var/www/

# hook this into test  (make sure this link sticks,
# may have TO DELETE the link first, "rm test")
##########################################################################################
ln -s /var/www/dos-2012-02-24 test

# once the new version is tested then log in to the server same as before and
# change the dos link to point to the new build by running this command to go LIVE!
# note that again you may have to remove the link first "rm dos"
#ln -fs /var/www/dos-2012-02-24 dos


# you should also move the previous link "rm previous" then
# ln -s /var/www/dos-(yyyy-mm-dd formatted date of previous build goes here) previous

# copy over the redirection file
cd previous
cp index.html ../dos
