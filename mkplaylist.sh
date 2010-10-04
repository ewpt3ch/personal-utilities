#!/bin/bash
#usage mkplaylist.sh listname(optional) audiodir(optional)

#variables
BASEDIR="/media/sdb1"
BASEDIR="/tmp/sdb1/" #uncomment to test or debug
DATE=`date +%m%d`
LISTNAME="podcast-${DATE}"
AUDIODIR="${LISTNAME}"
TMPFILE="/tmp/podcast-${DATE}.tmp"
#print variables for debugging
echo ${BASEDIR}
echo ${DATE}
echo ${LISTNAME}
echo ${AUDIODIR}
echo ${TMPFILE}

#mk tmp playlist
echo "PLP PLAYLIST" > ${TMPFILE}
echo "VERSION 1.20" >>  ${TMPFILE}
echo "" >> ${TMPFILE}
cd "${BASEDIR}/MUSIC"
for f in `find "${AUDIODIR}" -type f \( -name "*.[mM][pP]3" \)`
do
    FILE=`echo ${f} | sed -e 's/\//\\\\/g'`
    echo "HARP, MUSIC\\${FILE}" >> ${TMPFILE}
done

# convert playlist for use on sansa e280 and copy it there
unix2dos ${TMPFILE}
iconv -f ASCII -t UTF16LE -o "${BASEDIR}PLAYLISTS/${LISTNAME}.PLA" ${TMPFILE}
rm ${TMPFILE}
