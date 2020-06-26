# -*- coding: utf-8 -*-
"""
Created on Sat Jun 27 06:12:25 2020

@author: sbbpan
"""

import glob
import os
import pandas as pd

files = glob.glob("./cut/*.mp3", )

fullpath = []
for f in files:
    f1 = os.path.basename(f)
    f2 = f'https://raw.githubusercontent.com/samy101/karaoke/master/music/cut/{f1}'
    fullpath.append(f2)
    print(f2)
    
df = pd.DataFrame({'urls':fullpath})
df.to_csv('../urls.csv', index=False)   