#!/usr/bin/env python3
"""Draws the original Solitaire Nova launcher icon and writes all Android
mipmaps and iOS AppIcon sizes.  python3 tool/generate_icons.py"""
import json, math, os
from PIL import Image, ImageDraw, ImageFilter

ROOT = os.path.join(os.path.dirname(__file__), '..')
S = 1024

def bez(p0, p1, p2, p3, n=40):
    return [((1-t)**3*p0[0]+3*(1-t)**2*t*p1[0]+3*(1-t)*t*t*p2[0]+t**3*p3[0],
             (1-t)**3*p0[1]+3*(1-t)**2*t*p1[1]+3*(1-t)*t*t*p2[1]+t**3*p3[1]) for t in [i/n for i in range(n+1)]]

def spade(cx, cy, w):
    def P(x, y): return (cx + (x-0.5)*w, cy + (y-0.5)*w)
    pts = []
    pts += bez(P(.5,.03), P(.62,.2), P(.95,.38), P(.95,.6))
    pts += bez(P(.95,.6), P(.95,.75), P(.83,.83), P(.71,.83))
    pts += bez(P(.71,.83), P(.62,.83), P(.55,.78), P(.52,.72))
    pts += bez(P(.52,.72), P(.54,.82), P(.58,.9), P(.68,.97))
    pts += [P(.32,.97)]
    pts += bez(P(.32,.97), P(.42,.9), P(.46,.82), P(.48,.72))
    pts += bez(P(.48,.72), P(.45,.78), P(.38,.83), P(.29,.83))
    pts += bez(P(.29,.83), P(.17,.83), P(.05,.75), P(.05,.6))
    pts += bez(P(.05,.6), P(.05,.38), P(.38,.2), P(.5,.03))
    return pts

def gold_fill(mask_img):
    grad = Image.new('RGB', (S, S))
    d = ImageDraw.Draw(grad)
    for y in range(S):
        t = y / S
        c0, c1, c2 = (246,227,174), (221,187,114), (180,140,69)
        c = tuple(int(c0[i]+(c1[i]-c0[i])*t/0.55) if t < .55 else int(c1[i]+(c2[i]-c1[i])*(t-.55)/.45) for i in range(3))
        d.line([(0,y),(S,y)], fill=c)
    return grad, mask_img

def master():
    img = Image.new('RGB', (S, S), (11, 42, 38))
    d = ImageDraw.Draw(img)
    for r in range(int(S*0.75), 0, -4):
        t = r / (S*0.75)
        c = tuple(int(a + (b-a)*t) for a, b in zip((30, 100, 86), (8, 30, 27)))
        d.ellipse([S/2-r, S*0.45-r, S/2+r, S*0.45+r], fill=c)
    mask = Image.new('L', (S, S), 0)
    md = ImageDraw.Draw(mask)
    md.polygon(spade(S/2, S*0.58, S*0.56), fill=255)
    # crown
    cw, ch, cx, cy = S*0.34, S*0.17, S/2, S*0.2
    md.polygon([(cx-cw/2*0.84, cy+ch/2), (cx-cw/2, cy-ch*0.22), (cx-cw*0.22, cy+ch*0.05),
                (cx, cy-ch/2), (cx+cw*0.22, cy+ch*0.05), (cx+cw/2, cy-ch*0.22), (cx+cw/2*0.84, cy+ch/2)], fill=255)
    for x, y in [(cx-cw/2, cy-ch*0.22), (cx, cy-ch/2), (cx+cw/2, cy-ch*0.22)]:
        md.ellipse([x-S*0.022, y-S*0.022, x+S*0.022, y+S*0.022], fill=255)
    shadow = mask.filter(ImageFilter.GaussianBlur(14))
    img.paste((0, 0, 0), (0, 12), shadow.point(lambda v: int(v*0.55)))
    grad, _ = gold_fill(mask)
    img.paste(grad, (0, 0), mask)
    # gold frame
    d = ImageDraw.Draw(img)
    d.rounded_rectangle([S*0.06, S*0.06, S*0.94, S*0.94], radius=S*0.16, outline=(214,181,116), width=int(S*0.012))
    return img

def main():
    m = master()
    for folder, px in {'mdpi': 48, 'hdpi': 72, 'xhdpi': 96, 'xxhdpi': 144, 'xxxhdpi': 192}.items():
        m.resize((px, px), Image.LANCZOS).save(os.path.join(ROOT, f'android/app/src/main/res/mipmap-{folder}/ic_launcher.png'))
    iosdir = os.path.join(ROOT, 'ios/Runner/Assets.xcassets/AppIcon.appiconset')
    meta = json.load(open(os.path.join(iosdir, 'Contents.json')))
    for img in meta['images']:
        if 'filename' not in img: continue
        base = float(img['size'].split('x')[0]); scale = int(img['scale'][0])
        px = int(round(base * scale))
        m.resize((px, px), Image.LANCZOS).save(os.path.join(iosdir, img['filename']))
    m.save(os.path.join(ROOT, 'docs/design/app_icon_1024.png'))

if __name__ == '__main__':
    main()
