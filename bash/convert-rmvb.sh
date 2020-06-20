#! /bin/bash

mencoder $1 -oac mp3lame -lameopts mode=3:cbr:vol=7:padding=1 -sws 9 -ovc xvid -xvidencopts max_bframes=2:me_quality=6:trellis:hq_ac:vhq=2:bvhq=1:qpel:closed_gop:chroma_opt:profile=dxnhtpal:bitrate=1150 -ofps 24000/1001 -o $1.avi