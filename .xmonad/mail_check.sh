#! /bin/bash

COUNT=`ls -l ~/.mail/$1/INBOX/new/ | grep ^- | wc -l`

if [ $COUNT != 0 ] ; then
    echo -e "<fc=#444444>[</fc><fc=#00ff00>$COUNT</fc><fc=#444444>]</fc>"
else
    echo -e "<fc=#444444>[</fc>$COUNT<fc=#444444>]</fc>"
fi
