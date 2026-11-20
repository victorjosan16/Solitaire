# Publicare pe Google Play și reclame reale (AdMob)

ID aplicație (definitiv): **`com.solitairenova.app`** — nu se mai poate schimba după prima publicare.

Ce face codul deja:
* Build-ul de test (debug) folosește reclamele de TEST Google.
* Build-ul de publicare folosește ID-urile reale AdMob primite din GitHub (variabile), iar dacă lipsesc,
  fluxul de publicare se oprește cu eroare — nu se poate publica din greșeală fără reclame sau cu reclame de test.
* Semnarea se face cu cheia ta de upload, păstrată ca *secret* în GitHub (niciodată în cod).
* Fluxul **Actions → "Release (Google Play)"** rulează testele, construiește `.aab` semnat și îl urcă pe Google Play.

---

## Pasul 1 — AdMob (reclamele reale)
1. Intră pe <https://admob.google.com> cu același cont Google ca Play Console și finalizează contul
   (țară, fus orar, date de plată / impozitare).
2. **Apps → Add app → Android →** „Is the app listed on a supported app store?” → **No** (încă nu e publicată).
   Nume: *Solitaire Nova*. Notează **App ID** (`ca-app-pub-XXXXXXXXXXXXXXXX~YYYYYYYYYY`).
3. Creează 3 unități de reclamă (**Ad units → Add ad unit**) și notează ID-urile (`ca-app-pub-…/…`):
   * **Banner** — „Solitaire banner”
   * **Interstitial** — „Solitaire between games”
   * **Rewarded** — „Solitaire rewarded” (recompensa din AdMob poate rămâne 1; aplicația decide ce primești)
4. **Privacy & messaging → GDPR → Create message**: alege aplicația, limbile (cel puțin engleză + română),
   publică mesajul. Fără el, utilizatorii din UE nu vor vedea reclame. Opțional: mesajul „US state regulations”.
5. După ce aplicația apare pe Google Play: AdMob → App settings → **Link to app store**.

> Nu da clic pe propriile reclame. Pentru teste pe telefonul tău folosește APK-urile de test (reclame de test).

## Pasul 2 — Cheia de upload (o singură dată, pe calculatorul tău)
Ai nevoie de Java (vine cu Android Studio). Rulează:
```bash
keytool -genkey -v -keystore solitaire-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
Alege o parolă puternică. **Fă copie de siguranță** a fișierului `.jks` și a parolei (manager de parole).
Dacă le pierzi, Google îți poate reseta cheia de upload (cu Play App Signing), dar durează.

Transformă cheia în text pentru GitHub:
* macOS / Linux: `base64 -i solitaire-upload.jks | tr -d '\n' > upload.b64`
* Windows (PowerShell): `[Convert]::ToBase64String([IO.File]::ReadAllBytes("solitaire-upload.jks")) > upload.b64`

## Pasul 3 — Secrete și variabile în GitHub
Repo → **Settings → Secrets and variables → Actions**.

**Secrets** (ascunse):
| Nume | Valoare |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | conținutul fișierului `upload.b64` |
| `ANDROID_KEYSTORE_PASSWORD` | parola keystore-ului |
| `ANDROID_KEY_ALIAS` | `upload` |
| `ANDROID_KEY_PASSWORD` | parola cheii (de obicei aceeași) |
| `PLAY_SERVICE_ACCOUNT_JSON` | (opțional, Pasul 7) conținutul fișierului JSON |

**Variables** (ID-urile AdMob nu sunt secrete):
| Nume | Exemplu |
|---|---|
| `ADMOB_APP_ID_ANDROID` | `ca-app-pub-1234567890123456~1111111111` |
| `ADMOB_BANNER_ANDROID` | `ca-app-pub-1234567890123456/2222222222` |
| `ADMOB_INTERSTITIAL_ANDROID` | `ca-app-pub-1234567890123456/3333333333` |
| `ADMOB_REWARDED_ANDROID` | `ca-app-pub-1234567890123456/4444444444` |
| `PRIVACY_POLICY_URL` | `https://victorjosan16.github.io/Solitaire/privacy/` |

## Pasul 4 — Politica de confidențialitate (obligatorie pentru aplicații cu reclame)
1. În `docs/privacy/index.html` înlocuiește `[CONTACT EMAIL]` cu adresa de contact pe care vrei s-o afișezi public.
2. Repo → **Settings → Pages** → Source: *Deploy from a branch* → branch-ul principal → folder **/docs** → Save.
   (GitHub Pages gratuit necesită repo public; altfel găzduiește pagina oriunde și pune URL-ul în variabilă.)
3. Verifică: `https://victorjosan16.github.io/Solitaire/privacy/`.

## Pasul 5 — Aplicația în Play Console
1. **Create app**: nume *Solitaire Nova*, limba implicită English (United States) sau Română, **Game**, **Free**.
2. **Testing → Internal testing → Create new release**: Play App Signing rămâne activat (implicit).
3. Primul `.aab` se urcă **manual** (Google nu permite API-ul la prima versiune):
   GitHub → Actions → **Release (Google Play)** → *Run workflow* (track `internal`, status `draft`) →
   la final, descarcă `.aab` din **Releases** (draft) → încarcă-l în Play Console.
4. **App content** (meniul *Policy*):
   * Privacy policy: URL-ul de la Pasul 4.
   * Ads: **Yes, my app contains ads**.
   * App access: *All functionality available without special access*.
   * Content rating: completează chestionarul (joc de cărți, fără violență, **fără jocuri de noroc cu bani reali**).
   * Target audience: **13+** (nu bifa grupe sub 13, altfel se aplică reguli stricte pentru copii).
   * Data safety (pentru AdMob): colectat *Device or other IDs*, *App interactions*, *Diagnostics*;
     scop *Advertising or marketing* și *Analytics*; partajat cu Google (AdMob); criptat în tranzit;
     utilizatorul poate cere ștergerea (Setări → Șterge datele locale). Fără locație precisă, fără cont.
   * Advertising ID: **Yes** — folosit pentru reclame.
   * Financial features: niciuna. Government app: nu.
5. **Store listing**: descriere scurtă/lungă, icon 512×512 (`docs/design/app_icon_1024.png` redimensionat),
   feature graphic 1024×500, minimum 2 capturi de ecran telefon.

### Atenție: conturi personale noi
Conturile Play Console **personale** create după noiembrie 2023 trebuie să facă un **test închis cu cel puțin
12 testeri timp de 14 zile** înainte de a putea publica în producție. Folosește track-ul *Closed testing*
(`alpha` în flux) și invită testerii prin e-mail sau Google Group. Conturile de tip organizație nu au această cerință.

## Pasul 6 — Actualizări
1. Crește versiunea în `pubspec.yaml`: `version: 1.0.1+1` (numărul după `+` e ignorat; fluxul folosește
   automat numărul rulării, care crește mereu — Google cere `versionCode` crescător).
2. Actualizează notele din `distribution/whatsnew/whatsnew-ro-RO` și `whatsnew-en-US` (max 500 caractere).
3. GitHub → Actions → **Release (Google Play)** → *Run workflow* → alege track-ul:
   `internal` → `alpha` (test închis) → `production`. Status `draft` = verifici și apeși *Roll out* în Play Console;
   `completed` = se lansează direct (doar după ce aplicația a fost publicată o dată).

## Pasul 7 — Upload automat pe Play (opțional, recomandat)
1. Google Cloud Console → proiect nou → activează **Google Play Android Developer API**.
2. IAM → **Service accounts → Create** → creează o cheie **JSON** și descarc-o.
3. Play Console → **Users and permissions → Invite new users** → adresa service account-ului →
   permisiuni pentru aplicație: *Release to testing tracks* (și *Release to production* dacă vrei).
4. Pune conținutul JSON în secretul `PLAY_SERVICE_ACCOUNT_JSON`. De acum fluxul urcă singur versiunile.

## Opțional — app-ads.txt
AdMob recomandă fișierul `app-ads.txt` pe site-ul de dezvoltator declarat în Play Console
(de ex. `https://victorjosan16.github.io/app-ads.txt` dintr-un repo `victorjosan16.github.io`), cu linia afișată în
AdMob → Apps → app-ads.txt. Fără el reclamele merg, dar unii cumpărători de reclame plătesc mai puțin.

## iOS (mai târziu)
Bundle id iOS este tot `com.solitairenova.app`. Pentru App Store e nevoie de Mac + Xcode, cont Apple Developer,
App ID AdMob separat pentru iOS (`GAD_APP_ID` în `ios/Flutter/AdMob.xcconfig`) și ID-uri de unități iOS.
