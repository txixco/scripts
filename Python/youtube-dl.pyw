#!/usr/bin/env python3

from tkinter import *
import youtube_dl

def download(url):
    opts = {'outtmpl': '%(id)s.%(ext)s'}

    with youtube_dl.YoutubeDL(opts) as ydl:
        result = ydl.extract_info(
            'http://www.youtube.com/watch?v=BaW_jenozKc',
        )
    
    if 'entries' in result:
        # Can be a playlist or a list of videos
        video = result['entries'][0]
    else:
        # Just a video
        video = result

    return video

