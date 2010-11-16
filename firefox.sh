#!/bin/bash
#called with mode to select which tar ball to use

if [ -z $1 ] #test for mode option, exit if not present
then
    echo "Must select mode"
    echo "ie: firefox.sh priv"
    exit 1
fi

MODE=$1
UPDATE=$2
if test -z "$(mount | grep firefox)"
then
    mount "${HOME}/.mozilla"
fi
cd "${HOME}/.mozilla"
tar xf "${HOME}/conf/mozilla-${MODE}.tar"
/usr/bin/firefox
tar cf "mozilla-${MODE}.tar" "./firefox"
cp "${HOME}/conf/mozilla-${MODE}.tar" "${HOME}/conf/mozilla-${MODE}.tar.old"
cp "${HOME}/.mozilla/mozilla-${MODE}.tar" "${HOME}/conf/mozilla-${MODE}.tar"
#if [[ -n $UPDATE ]]
#then 
#    tar cf "mozilla-${MODE}.tar" "./firefox"
#    lzop -7U "mozilla-${MODE}.tar"
#    cp "${HOME}/conf/mozilla-${MODE}.tar.lzo" "${HOME}/conf/mozilla-${MODE}.tar.lzo.old"
#    cp "./mozilla-${MODE}.tar.lzo" "${HOME}/conf/mozilla-${MODE}.tar.lzo"
#fi
rm -r firefox
rm -r extensions
rm mozilla*.tar
