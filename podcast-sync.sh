#!/bin/bash
BASEDIR="${HOME}/gpodder-downloads/"
SYNCDIR="/media/sansa/MUSIC/podcast-`date +%m%d`"
mkdir -p ${SYNCDIR}
echo $BASEDIR
echo $SYNCDIR
find $BASEDIR -type f -iname "*.mp3" | while read f
do
    cp "${f}" ${SYNCDIR}
done
mkplaylist.sh
