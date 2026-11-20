#!/usr/bin/env python3
"""Builds lib/app/l10n/arb/app_<lang>.arb from tool/l10n/<lang>.py.

Each language module defines a dict named after the language code upper-cased
(EN, RO, ...). The script fails if a translation is missing a key or changes
the set of {placeholders}, so catalogs can never silently drift.

    python3 tool/l10n/build_arbs.py
"""
import importlib.util, json, os, re, sys

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(HERE, '..', '..', 'lib', 'app', 'l10n', 'arb')
LANGS = ['en', 'ro', 'ru', 'uk', 'de', 'fr', 'es', 'it', 'pt', 'pl']

def load(lang):
    spec = importlib.util.spec_from_file_location(lang, os.path.join(HERE, f'{lang}.py'))
    mod = importlib.util.module_from_spec(spec); spec.loader.exec_module(mod)
    return mod

def placeholders(s):
    # top-level {name} or {name, plural, ...}
    names, depth, i = set(), 0, 0
    for m in re.finditer(r'[{}]', s):
        if m.group() == '{':
            if depth == 0:
                names.add(re.match(r'\{\s*(\w+)', s[m.start():]).group(1))
            depth += 1
        else:
            depth -= 1
    return names

def main():
    en_mod = load('en')
    en, types = en_mod.EN, en_mod.PLACEHOLDER_TYPES
    os.makedirs(OUT, exist_ok=True)
    ok = True
    for lang in LANGS:
        if lang == 'en':
            data = en
        else:
            path = os.path.join(HERE, f'{lang}.py')
            if not os.path.exists(path):
                print(f'skip {lang}: no file'); continue
            data = getattr(load(lang), lang.upper())
        missing = set(en) - set(data)
        extra = set(data) - set(en)
        if missing or extra:
            ok = False
            print(f'{lang}: missing={sorted(missing)} extra={sorted(extra)}')
        arb = {'@@locale': lang}
        for k in en:
            if k not in data: continue
            v = data[k]
            if placeholders(v) != placeholders(en[k]):
                ok = False
                print(f'{lang}.{k}: placeholder mismatch {placeholders(v)} vs {placeholders(en[k])}')
            arb[k] = v
            if lang == 'en':
                ph = placeholders(v)
                if ph:
                    arb['@' + k] = {'placeholders': {p: {'type': types.get(p, 'String')} for p in sorted(ph)}}
        with open(os.path.join(OUT, f'app_{lang}.arb'), 'w', encoding='utf-8') as f:
            json.dump(arb, f, ensure_ascii=False, indent=2)
            f.write('\n')
    if not ok:
        sys.exit(1)

if __name__ == '__main__':
    main()
