#!/usr/bin/perl

while (@ARGV)
{
	$tmp = shift @ARGV;
	
	if ($tmp != "x")
    	$cadena = "-resize $1"

	if [ $2 != "x" ]
then 
    cadena="$cadena -resample $2"
fi

for file in *
do
    convert $cadena $file $3/$file
done
