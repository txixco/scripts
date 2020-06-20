#!/bin/bash

# source: http://blog.quaternio.net/2009/04/13/nasa-image-of-the-day-as-gnome-background/

# grabs the nasa image of the day by RSS feed and updates the gnome
# background. add this to your cron jobs to have this happen daily.  this is,
# obviously, a hack, that is likely to break at the slightest change of NASA's
# RSS implementation. yay standards!
 
img_dir='/home/txixco/fondos/NASA'

rss=`wget -q -O - http://www.nasa.gov/rss/lg_image_of_the_day.rss`
img_url=`echo $rss | grep -o '<enclosure [^>]*>' | grep -o 'http://[^\"]*'`
img_name=`echo $img_url | grep -o [^/]*\.\w*$`
 
# this command is benign if the directory already exists.
mkdir -p $img_dir
 
# this command will overwrite the image if it already exists
wget -q -O $img_dir/$img_name $img_url
cp -f $img_dir/$img_name $img_dir/today.jpg
 
/usr/bin/gconftool-2 -t string --set \
					 /desktop/gnome/background/picture_filename $img_dir/today.jpg

gsettings set org.cinnamon.desktop.background \
		  picture-uri 'file:///home/txixco/fondos/NASA/today.jpg'

# For fluxbox
export DISPLAY=:0.0
fbsetbg -a $img_dir/today.jpg
