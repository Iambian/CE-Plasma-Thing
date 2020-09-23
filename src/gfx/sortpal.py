from PIL import Image
import os,sys

img = Image.open('mainpal.png').convert("RGB")

w,h = img.size
li = list()
for x in range(w):
    li.append(img.getpixel((x,0)))
li = sorted(li)
for x in range(w):
    img.putpixel((x,0),li[x])
img.save('mainpal2.png')



