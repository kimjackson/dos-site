REPO=.
HEURIST=../heurist-kj
echo "select rec_id from records left join rec_details on rd_rec_id = rec_id and rd_type = 591 where rec_type in (153,151,103,74,91,152,98) and if (rec_type = 91, rd_val in ('Occupation', 'Type'), 1) and rec_id not in (2674,2675);" | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ ! -e $REPO/hml/$id.xml ]]; then
		php $HEURIST/php/hml.php -instance dos -depth 2 -q id:$id > $REPO/hml/$id.xml
	fi
done


