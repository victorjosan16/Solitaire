# Synthesizes original sound effects and an ambient music loop (no samples).
import numpy as np, wave, subprocess, sys, os
SR = 44100
out = sys.argv[1]

def mix(a, b):
    n = max(len(a), len(b)); out = np.zeros(n); out[:len(a)] += a; out[:len(b)] += b; return out

def write(name, x):
    x = np.clip(x, -1, 1)
    data = (x * 32767 * 0.9).astype(np.int16)
    with wave.open(os.path.join(out, name), 'wb') as w:
        w.setnchannels(1); w.setsampwidth(2); w.setframerate(SR)
        w.writeframes(data.tobytes())

def env(n, a=0.002, d=0.08):
    t = np.arange(n) / SR
    e = np.minimum(1, t / a) * np.exp(-t / d)
    return e

def noise_click(dur=0.06, f=2400, decay=0.012, seed=1):
    n = int(SR * dur)
    rng = np.random.default_rng(seed)
    x = rng.standard_normal(n)
    # crude band-pass: difference of moving averages
    k1 = max(1, int(SR / f)); k2 = k1 * 4
    a = np.convolve(x, np.ones(k1) / k1, 'same')
    b = np.convolve(x, np.ones(k2) / k2, 'same')
    return (a - b) * env(n, 0.0008, decay) * 1.6

def tone(freqs, dur, decay, amp=0.4):
    n = int(SR * dur); t = np.arange(n) / SR
    x = sum(np.sin(2 * np.pi * f * t) * (0.6 ** i) for i, f in enumerate(freqs))
    return x * env(n, 0.004, decay) * amp

# card place: soft papery tap
write('card_place.wav', mix(noise_click(0.07, 1800, 0.014, 3), tone([180], 0.07, 0.02, 0.15)))
# flip: quick brighter swish
write('card_flip.wav', noise_click(0.09, 4200, 0.03, 5) * 0.8)
# draw from stock
write('card_draw.wav', noise_click(0.08, 3000, 0.02, 7))
# foundation: gentle bell (D6 + overtones)
write('foundation.wav', mix(tone([1174.7, 2349.3, 3524], 0.45, 0.18, 0.28), noise_click(0.05, 1800, 0.01, 9) * 0.5))
# invalid: low muted thud
write('invalid.wav', tone([110, 220], 0.18, 0.05, 0.35))
# button tap
write('tap.wav', tone([880], 0.06, 0.015, 0.2))
# coins: two quick bright notes
c = np.concatenate([tone([1568, 3136], 0.09, 0.05, 0.25), tone([2093, 4186], 0.3, 0.12, 0.25)])
write('coins.wav', c)
# victory: rising arpeggio C major 9
notes = [523.25, 659.25, 783.99, 1046.5, 1174.66]
parts = []
for i, f in enumerate(notes):
    seg = np.zeros(int(SR * 1.6))
    s = tone([f, f * 2, f * 3], 1.6 - i * 0.12, 0.5, 0.22)
    off = int(SR * 0.11 * i)
    seg[off:off + len(s)] += s[:len(seg) - off]
    parts.append(seg)
write('victory.wav', sum(parts))

# ambient loop: slow evolving pad (Am9 - Fmaj7 - Cmaj7 - G6), 32 s, seamless
dur = 32.0; n = int(SR * dur); t = np.arange(n) / SR
chords = [[220, 261.63, 329.63, 493.88], [174.61, 220, 261.63, 329.63],
          [130.81, 196, 246.94, 329.63], [196, 246.94, 293.66, 329.63]]
x = np.zeros(n)
seg = n // 4
for i, ch in enumerate(chords):
    w = np.zeros(n)
    centre = (i + 0.5) * seg
    # raised-cosine window per chord, overlapping neighbours, wraps around
    d = np.minimum(np.abs(np.arange(n) - centre), n - np.abs(np.arange(n) - centre))
    w = np.clip(np.cos(np.pi * d / (seg * 2)), 0, None) ** 2
    for j, f in enumerate(ch):
        # integer cycles over the loop keeps it seamless
        fq = round(f * dur) / dur
        trem = 1 + 0.15 * np.sin(2 * np.pi * (1 / 8) * t + j)
        x += w * trem * (np.sin(2 * np.pi * fq * t) + 0.25 * np.sin(4 * np.pi * fq * t)) / (j + 1.5)
x = x / np.max(np.abs(x)) * 0.35
write('music_tmp.wav', x)
subprocess.run(['ffmpeg', '-y', '-loglevel', 'error', '-i', os.path.join(out, 'music_tmp.wav'),
                '-c:a', 'aac', '-b:a', '96k', os.path.join(out, 'ambient_loop.m4a')], check=True)
os.remove(os.path.join(out, 'music_tmp.wav'))
