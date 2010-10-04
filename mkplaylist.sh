#!/bin/bash
#usage mkplaylist.sh listname(optional) audiodir(optional)
#or if $1 = debug BASEDIR will have /tmp prepended

#variables
BASEDIR="/media/sansa"
DATE=`date +%m%d`
LISTNAME="podcast-${DATE}"
AUDIODIR="${LISTNAME}"
TMPFILE="/tmp/playlist.tmp"

#set debug mode and create some dirs in /tmp
#for testing and/or debugging.
if [[ $1 == "debug" ]]
then
    BASEDIR="/tmp${BASEDIR}"
    mkdir -p "${BASEDIR}/MUSIC/${AUDIODIR}"
    mkdir "${BASEDIR}/PLAYLISTS"
    echo ${BASEDIR}
    echo ${DATE}
    echo ${LISTNAME}
    echo ${AUDIODIR}
    echo ${TMPFILE}
    shift
    echo "$@"
    echo "$1"
fi

#check for options from cmd ln
if [[ -n $1 ]]
then
    LISTNAME=$1
fi
if [[ -n $2 ]]
then
    AUDIODIR=$2
fi

#get file names for playlist and sort them

cd "${BASEDIR}/MUSIC"
find ${AUDIODIR} -type f -name "*.[mM][pP]3" | while read f
do
    FILE=`echo ${f} | sed -e 's/\//\\\\/g'`
    echo ${FILE}
    echo "HARP, MUSIC\\${FILE}" >> "${TMPFILE}unsorted"
done

echo "PLP PLAYLIST" > ${TMPFILE}
echo "VERSION 1.20" >>  ${TMPFILE}
echo "" >> ${TMPFILE}
echo `sort "${TMPFILE}unsorted" >> ${TMPFILE}`

# convert playlist for use on sansa e280 and copy it there
unix2dos ${TMPFILE}
iconv -f ASCII -t UTF16LE -o "${BASEDIR}/PLAYLISTS/${LISTNAME}.PLA" ${TMPFILE}
rm ${TMPFILE}
rm "${TMPFILE}unsorted"