REPO=repo
HEURIST=../heurist-kj
ALL_ITEMS_QUERY="select rec_id
                   from records
              left join rec_details rt on rt.rd_rec_id = rec_id and rt.rd_type = 591
              left join rec_details ilt on ilt.rd_rec_id = rec_id and ilt.rd_type = 618
                  where rec_type in (153,151,103,74,91,152,98,168)
                    and if (rec_type = 91, rt.rd_val in ('Occupation', 'Type'), 1)
                    and if (rec_type = 168, ilt.rd_val = 'image', 1)
                    and rec_id not in (2674,2675);"
echo $ALL_ITEMS_QUERY | mysql -s -u readonly -pmitnick heuristdb-dos | \
while read id; do
	if [[ ! -e $REPO/hml/$id.xml ]]; then
		php $HEURIST/php/hml.php -instance dos -depth 2 -q id:$id > $REPO/hml/$id.xml
	fi
done


