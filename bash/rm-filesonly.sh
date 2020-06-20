#!/bin/bash

echo -e "Student file remover v0.1 starting.\r"
echo -e "By Jacob Steelsmith for Everett Community College.\r\n"

ERRLOG=~/sfm-err-log
OUTLOG=~/sfm-out-log
DTSTAMP=`date`
BASE=$1

echo -e "$DTSTAMP\r" >> $ERRLOG
echo -e "Starting student file remover v0.1 by Jacob Steelsmith.\r\n" >> $ERRLOG
echo -e "$DTSTAMP\r" >> $OUTLOG
echo -e "Starting student file remover v0.1 by Jacob Steelsmith.\r\n" >> $OUTLOG

echo -e "Errors will be logged to $ERRLOG.\r\n" | tee -a $OUTLOG
echo -e "Output will be logged to $OUTLOG.\r\n" | tee -a $ERRLOG


echo -e "Calculating base size...this will take a few minutes...\r"


BASESIZE=`du -hs $BASE/ 2>> $ERRLOG | cut -f1`

echo -e "Preparing to remove a total of $BASESIZE.\r" | tee -a $OUTLOG 
echo -e "Press enter key to coninue.\r\n"
read junk

for i in $BASE/*
do
	echo -e "Now working on $i.\r" | tee -a $OUTLOG
	DSIZE=`du -hs $i 2>> $ERRLOG | cut -f1` 
        echo -e "Preparing to remove $DSIZE.\r\n" | tee -a $OUTLOG
	for j in $i/*
	do
		if [ -d "$j" ]; then
			echo -e "Removing directory $j.\r" | tee -a $OUTLOG
			chmod -R +rw "$j" 2>>ERRLOG
			rm -Rf "$j" 2>> $ERRLOG
		else
			echo -e "Removing file $j." | tee -a $OUTLOG
			chmod +rw "$j" 2>>ERRLOG
			rm -f "$j" 2>> $ERRLOG
		fi
	done
	echo -e "Done with $i.\r\n" | tee -a $OUTLOG
done

echo -e "\r\nDone!" | tee -a $OUTLOG
