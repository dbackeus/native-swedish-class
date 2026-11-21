# Lektionsmall — instruktioner för att generera nya lektioner

Det här dokumentet är prompten/mallen för varje ny lektion i serien.
Utgå från den senaste färdiga lektionens HTML som teknisk mall och följ
strukturen och omfånget nedan.

## Mål och ramar

- **Målgrupp:** en nioåring med svenska som hemspråk, bor i Italien.
  Pappan läser och diskuterar tillsammans med honom.
- **Total tid: max 30 minuter** inklusive samtal. (Lektion 1–3 tog ~45 min
  — därför är omfånget nedan medvetet mindre än i de lektionerna.)
- **Fokus:** människors vardag, kulturmöten och varför samhällen förändras
  — inte kungalängder och årtalsrabblande.
- **Lite text.** Läsbart för ett barn utan att vara barnsligt.
- **Belägg och tolkning hålls strikt isär.** Markera alltid vad som är
  historiskt belagt, vad som är forskarnas tolkning och vad som är påhittat.
  Uppdiktade scener taggas synligt ("Påhittad scen"), rekonstruktioner och
  teckningar likaså.
- **Moderna gränser och nationella identiteter framställs aldrig som eviga.**
  Skriv "det som nu är Sverige", inte "Sverige" om förhistorisk tid.
- **Hitta aldrig på fakta, källor eller bilder.** Osäkert = säg att det är osäkert.

## Serien

20 lektioner i 6 delar. Varje lektion är fristående men länkar till
föregående och nästa.

1. Del 1: Innan Sverige fanns *(lektion 1–3 klara; lektion 4: Från järnålder till vikingatid)*
2. Del 2: Vikingatiden och världen
3. Del 3: Medeltidens sammanlänkade värld
4. Del 4: Tro, makt och en större värld
5. Del 5: Människor förändrar samhället
6. Del 6: Sverige i vår gemensamma värld

## Lektionens struktur och omfång

Riktmärke: **max ~750 ord barnvänd text totalt** (lektion 3 hade ~1 300,
vilket blev för långt). Ordantalen nedan är tak, inte mål.

1. **Hero** (~80 ord) — Del/lektion + titel, epokanpassad SVG-illustration,
   kurstidslinje med "här är vi"-markering, 2–3 meningars ingress med en
   rad som knyter an till förra lektionen.
2. **Gåtan/kroken** (~90 ord) — ett konkret mysterium eller en fråga som
   väcker nyfikenhet, gärna med en bild. Besvaras under lektionens gång.
3. **Berättelsen** (**max 200 ord**) — en kort, levande scen. Taggas
   "Påhittad scen" om den är uppdiktad. **Max 1–2 bilder** (inte 3 som förr).
4. **Interaktionen** — EN meningsfull interaktion (karta med slider,
   animation e.d.). **Max 4 stationstexter à ~2 meningar.** Kartor ritas med
   igenkännbara europeiska kustlinjer (se lektion 3) och noten "Förenklad karta".
5. **Hur vet vi det?** (~100 ord) — **ETT fyndkort**, inte tre: det enskilt
   starkaste belägget, med bild. (Detta är den största nedbantningen mot
   lektion 1–3.)
6. **Samtidigt i Italien** (~110 ord) — en konkret, verklig koppling.
   Var tydlig om årtalen inte matchar exakt.
7. **Att prata om** — **2 frågor** (inte 3). Öppna frågor utan facit.
8. **Orden** — 3 svenska ord + uppmaning att återberätta med egna ord.
9. **Föräldradelen** (`<details>`, räknas inte in i barntexten) — källor
   med namn/år, föreslagen tidsplan (rikta mot 30 min), osäkerheter och
   forskardebatter, bildkällor med licenser.
10. **Footer** — "Del X · Lektion N av 20", länk till föregående lektion,
    "Nästa gång: …" (länk när nästa lektion finns).

En cliffhanger/brygga till nästa lektion planteras gärna i slutet
(som Ötzis yxa → bronset, bronset → järnet).

## Design och teknik

- **En självständig HTML-fil per lektion** i repots rot, namngiven
  `NN-slug.html`. Filen publiceras som Claude-artefakt och saknar därför
  doctype/html/head/body — börja med `<title>` och
  `<meta name="claude:viewport-fit-sides" content="cover">`.
- **Typsnitt (seriens identitet):** Bricolage Grotesque (rubriker) +
  Atkinson Hyperlegible (brödtext) via Google Fonts.
- **Epokanpassad palett**, alla färger som tokens på `:root`. Mörkt tema
  dubbleras under både
  `@media (prefers-color-scheme: dark){ :root:not([data-theme="light"]) }`
  och `:root[data-theme="dark"]` (med `color-scheme: dark`).
  Temaväxlare ☀/☾ som sätter `data-theme` + localStorage-nyckeln
  `'historia-tema'` — kopiera från senaste lektionen.
- **Fungerar på mobil och dator.** Sidomarginal
  `max(16px, env(safe-area-inset-*, 0px))`, inget horisontellt skroll.
- Slider-animationer: `<input type="range" step="1">` kvantiserar — låt
  play-loopen hålla en egen float och tilldela `Math.round(pos)`.

## Bilder (Wikimedia Commons)

- Endast riktiga fynd/platser/verk under fria licenser (PD, CC BY, CC BY-SA).
- Sök via Commons-API:t, hämta licens/upphovsperson via
  `prop=imageinfo&iiprop=url|size|extmetadata` (sätt User-Agent, vila
  mellan anrop — API:t svarar annars 429).
- **Verifiera alltid varje bild visuellt innan den bäddas in** (fel bild
  har hänt: en museibesökare i replikadräkt såg ut att vara Egtvedflickan).
- Skala om med `sips` (~880 px bredd, jpeg ~78) till `bilder/NN/`.
- Kreditera i figcaption, i föräldradelens "Bildkällor" och i README.
- Foton taggas t.ex. "RIKTIGT FYND"; teckningar/rekonstruktioner markeras.

## Publiceringschecklista

1. Skriv `NN-slug.html` i repots rot, bilder i `bilder/NN/`.
2. Publicera som artefakt (bilderna via `files`).
3. Testa i webbläsaren: interaktionen (inkl. play-knapp), ljust + mörkt
   tema, mobilbredd.
4. Uppdatera föregående lektions footer: "Nästa gång: …" → länk till den
   nya artefakten.
5. `build.sh`: lägg till sed-mappning (ny artefakt-URL → filnamn) och en
   `build`-rad.
6. `docs/index.html`: gör lektionen klickbar med en kort blurb, lägg till
   nästa lektion som "kommer snart".
7. README: lägg till bildkällorna.
8. Kör `./build.sh`, committa och pusha — GitHub Pages bygger om automatiskt.
   Publik adress: https://dbackeus.github.io/native-swedish-class/
