# generate browsing data
php deploy/entities-json.php Artefact > browse/artefacts.js
php deploy/entities-json.php Building > browse/buildings.js
php deploy/entities-json.php Event > browse/events.js
php deploy/entities-json.php "Natural feature" > browse/natural.js
php deploy/entities-json.php Organisation > browse/organisations.js
php deploy/entities-json.php Person > browse/people.js
php deploy/entities-json.php Place > browse/places.js
php deploy/entities-json.php Structure > browse/structures.js

php deploy/entities-json.php Entry > browse/entries.js
php deploy/entities-json.php Map > browse/maps.js
php deploy/entities-json.php Term > browse/subjects.js
php deploy/entities-json.php Role > browse/roles.js
php deploy/entities-json.php Contributor > browse/contributors.js

