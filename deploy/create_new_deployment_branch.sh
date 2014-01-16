#!/bin/bash

if [[ ! $1 ]]; then
	echo "Usage: $0 <DATE> (yyyy-mm-dd)";
	exit;
fi


git checkout -b dos-site --track origin/dos-site
git checkout -b dos-site-deploy-$1
cat static_version_config.patch | sed s/__DATE__/$1/g | git apply -
