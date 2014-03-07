REPO=repo
HEURIST=http://localhost/h3
cat all_items.txt | \
while read id; do
	if [[ ! -e $REPO/hml/$id.xml ]]; then
		echo $id;
		curl $HEURIST/export/xml/hml.php?q=id:$id\&depth=2 > $REPO/hml/$id.xml
	fi
done


