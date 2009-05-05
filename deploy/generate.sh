# copy files
echo "select file_id, file_nonce from files;" | mysql -s -u readonly -pmitnick heuristdb-dos-sandbox | while read id nonce; do cp /var/www/htdocs/uploaded-heurist-files/dos-sandbox/$id files/full/$nonce; done

# generate small size images
echo "select file_nonce from files where file_mimetype like 'image%';" | mysql -s -u readonly -pmitnick heuristdb-dos-sandbox | while read nonce; do wget -O files/100/$nonce http://dos-sandbox.heuristscholar.org/heurist/php/resize_image.php?file_id=$nonce; done

# generate medium size images
echo "select file_nonce from files where file_mimetype like 'image%';" | mysql -s -u readonly -pmitnick heuristdb-dos-sandbox | while read nonce; do wget -O files/300/$nonce http://dos-sandbox.heuristscholar.org/heurist/php/resize_image.php?file_id=$nonce\&w=300\&h=300; done

# generate pages for all appropriate records
echo "select rec_id from records where rec_type in (153,151,103,74,91,152,98);" | mysql -s -u readonly -pmitnick heuristdb-dos-sandbox | while read id; do wget --no-cache -O item/$id http://heuristscholar.org/cocoon/relbrowser-kj/item/$id; done

# generate KML for all entities
echo "select rd_val from rec_details where rd_type = 527;" | mysql -s -u readonly -pmitnick heuristdb-dos-sandbox | while read id; do wget -O kml/$id.kml http://heuristscholar.org/cocoon/relbrowser-kj/kmltrans/linkto:$id+type:150; done
