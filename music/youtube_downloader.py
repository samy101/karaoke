# -*- coding: utf-8 -*-
"""
Created on Sat Jun 27 02:58:32 2020

@author: sbbpan
"""

# https://spapas.github.io/2018/03/06/easy-youtube-mp3-downloading/
import sys
import glob
from youtube_dl import YoutubeDL

import youtube_dl

ydl_opts = {
    'format': 'bestaudio/best',
    'postprocessors': [{
        'key': 'FFmpegExtractAudio',
        'preferredcodec': 'mp3',
        'preferredquality': '192',
    }],
}
    
with youtube_dl.YoutubeDL(ydl_opts) as ydl:
    ydl.download(['https://www.youtube.com/watch?v=Q60wgYix1Q8&list=PL8kfkXkJFqJCFjF3vtbNM8YIWWM3O0tkX'])
    
    

# https://stackoverflow.com/questions/43890/crop-mp3-to-first-30-seconds
files = glob.glob("*.mp3")
f = files[0]
for f in files:
    try:
        f1 = f.replace(' ', '-')    
        os.rename(f, f1)    
        cmd = f'ffmpeg -y -t 30 -i "{f1}" -acodec copy ".\cut\{f1}"'
        os.system(cmd)    
        shutil.move(f1, f".\orig\{f1}")
    except:
        pass