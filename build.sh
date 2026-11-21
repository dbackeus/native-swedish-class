#!/usr/bin/env bash
# Bygger publika kopior av lektionerna till docs/ (GitHub Pages).
# Artefaktfilerna saknar <head> (claude.ai lägger på det), så här får de
# ett riktigt dokumentskal + charset, och claude.ai-länkar blir relativa.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p docs

skel() {
cat <<'HEAD'
<!doctype html>
<html lang="sv">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}</style>
HEAD
}

build() {
  local src="$1" dst="$2"
  { skel
    sed -e 's|https://claude.ai/artifact/L4VSE7AV435G2d3v7KzxPw|01-isen-och-de-forsta-manniskorna.html|g' \
        -e 's|https://claude.ai/artifact/3nDFNcZb7sUJEeqUGCEtq7|02-de-forsta-bonderna.html|g' \
        -e 's|https://claude.ai/artifact/MmrgHrKy5dhgDpu8m9HcQ9|02-de-forsta-bonderna.html|g' \
        -e 's|https://claude.ai/artifact/Lrk4npTCZyYP5Sz8P7c7c5|03-bronsalderns-forbindelser.html|g' \
        -e 's|https://claude.ai/artifact/5jhrYBrX6KXxPYiSF1bj9c|04-fran-jarnalder-till-vikingatid.html|g' \
        "$src"
    echo '</html>'
  } > "docs/$dst"
  echo "  $src -> docs/$dst"
}

build 01-isen-och-de-forsta-manniskorna.html 01-isen-och-de-forsta-manniskorna.html
build 02-de-forsta-bonderna-v2.html 02-de-forsta-bonderna.html
build 03-bronsalderns-forbindelser.html 03-bronsalderns-forbindelser.html
build 04-fran-jarnalder-till-vikingatid.html 04-fran-jarnalder-till-vikingatid.html
rm -rf docs/bilder
cp -R bilder docs/bilder
find docs -name .DS_Store -delete
echo "klart."
