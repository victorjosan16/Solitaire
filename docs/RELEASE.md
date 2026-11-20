# Publicare pe Google Play și reclame reale (AdMob)

ID aplicație (definitiv): **`com.solitairenova.app`** — nu se mai poate schimba după prima publicare.

Ce face codul deja:
* Build-ul de test (debug) cere doar reclame de TEST Google — poți apăsa pe ele fără risc.
* Build-ul de publicare folosește unitățile reale AdMob din `lib/core/config/app_config.dart`
  (ID-urile AdMob nu sunt secrete; sunt vizibile în orice APK).
* Reclame folosite: **banner sus** (după 10 mutări) și **reclame cu recompensă** opționale.
  **Fără reclame între jocuri** (decizie de produs).
* Semnarea se face cu cheia ta de upload, păstrată ca *secret* în GitHub (niciodată în cod).
* Fluxul **Actions → "Release (Google Play)"** rulează testele, construiește `.aab` semnat și îl urcă pe Google Play.

---

## Pasul 1 — AdMob ✅ (făcut, inclusiv mesajul GDPR)
| | ID |
|---|---|
| App ID (Android) | `ca-app-pub-4151706326405945~7945466753` |
| Banner | `ca-app-pub-4151706326405945/4002352310` |
| Rewarded | `ca-app-pub-4151706326405945/8647128151` |

* Mesajul GDPR (Reglementări europene) este publicat ✅
* După publicarea pe Google Play: App settings → **Link to app store**.
* Nu da clic pe propriile reclame reale (poate duce la suspendarea contului).

## Pasul 2 — Cheia de upload (de pe telefon, fără calculator)
Cheia o generează GitHub; tu creezi doar o parolă.

1. **Parola**: generează una lungă (minim 16 caractere; recomandat 24+), de exemplu cu managerul de
   parole Google (în Chrome: câmp de parolă → „Sugerează o parolă puternică”) sau Bitwarden.
   **Salveaz-o în managerul de parole.** Fără ea nu se mai pot publica actualizări.
2. GitHub (în Chrome, mod „Site pentru desktop”) → repo → **Settings → Secrets and variables → Actions →
   New repository secret** → Name: `ANDROID_KEYSTORE_PASSWORD`, Secret: parola → **Add secret**.
3. **Actions → „Create upload key (run once)” → Run workflow** → în câmpul *confirm* scrie `CREATE` → Run.
4. În ~1 minut apare în **Releases** un draft „Upload key (encrypted) – DO NOT DELETE”.
   **Nu-l șterge.** Pentru o copie de siguranță: deschide draftul și descarcă `upload-key.jks.enc` în
   Google Drive (e criptat; fără parolă nu poate fi folosit).

Fluxul refuză să creeze o a doua cheie dacă există deja una.

## Pasul 3 — Secrete în GitHub
Singurul secret obligatoriu este `ANDROID_KEYSTORE_PASSWORD` (Pasul 2).
Opțional, mai târziu: `PLAY_SERVICE_ACCOUNT_JSON` (Pasul 7, upload automat).

*Alternativă cu calculator:* poți genera cheia local cu
`keytool -genkey -v -keystore solitaire-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload`
și s-o pui în secretul `ANDROID_KEYSTORE_BASE64` (base64); atunci fluxul o folosește pe aceea.

## Pasul 4 — Politica de confidențialitate (obligatorie pentru aplicații cu reclame)
1. În `docs/privacy/index.html` înlocuiește `[CONTACT EMAIL]` cu adresa de contact pe care vrei s-o afișezi public.
   Adresa paginii e deja setată în aplicație: `https://victorjosan16.github.io/Solitaire/privacy/`.
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
