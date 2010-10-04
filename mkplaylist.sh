#!/bin/bash
BASEDIR="/media/sdb1/"
DATE=`date +%m%d`
echo ${DATE}
REALNAME="podcast-${DATE}"
echo ${REALNAME}
TMPFILE="/tmp/podcast-${DATE}.tmp"
echo ${TMPFILE}
echo "PLP PLAYLIST" > ${TMPFILE}
echo "VERSION 1.20" >>  ${TMPFILE}
echo "" >> ${TMPFILE}
cd "${BASEDIR}/MUSIC"
for f in `find "${REALNAME}" -type f \( -name "*.[mM][pP]3" \)`
do
    FILE=`echo ${f} | sed -e 's/\//\\\\/g'`
    echo "HARP, MUSIC\\${FILE}" >> ${TMPFILE}
done
unix2dos ${TMPFILE}
iconv -f ASCII -t UTF16LE -o "${BASEDIR}PLAYLISTS/${REALNAME}.PLA" ${TMPFILE}
rm ${TMPFILE}
