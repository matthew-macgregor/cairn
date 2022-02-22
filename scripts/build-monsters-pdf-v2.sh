#!/bin/bash
# This creates a compiled PDF of all the monster stat blocks in both A4 and Letter formats (including booklets)
date="$(date "+%B %e, %Y")"
cd /tmp
rsync -av /home/yochai/github/cairn/resources/monsters/ /tmp/monsters/
sed -i '/^author/d' /tmp/monsters/*.md
sed -i '/^source:/d' /tmp/monsters/*.md
sed -i '1 { /^---/ { :a N; /\n---/! ba; d} }' /tmp/monsters/*.md
pandoc --variable papersize=Letter --variable title="Cairn Monsters" --variable subtitle="Compiled on " --variable subtitle="$date" --variable subtitle=" by Yochai Gal | CC-BY-SA 4.0" --variable mainfont=Alegreya --variable sansfont=Alegreya --variable monofont=Alegreya -f gfm --toc -s /tmp/monsters/*.md -o "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-letter-tmp.pdf"
pandoc --variable papersize=A4 --variable title="Cairn Monsters" --variable subtitle="Compiled on " --variable subtitle="$date" --variable subtitle=" by Yochai Gal | CC-BY-SA 4.0" --variable mainfont=Alegreya --variable sansfont=Alegreya --variable monofont=Alegreya -f gfm --toc -s /tmp/monsters/*.md -o "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-a4-tmp.pdf"
cd "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/"
pdftk "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-cover-letter.pdf" "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-letter-tmp.pdf" cat output "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-letter.pdf"
pdftk "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-cover-a4.pdf" "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-a4-tmp.pdf" cat output "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-a4.pdf"
pdfbook2 -p=letter -s "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-letter-tmp.pdf"
pdfbook2 -p=a4paper -s "/home/yochai/Google Drive/Games/OSR/Into The Odd/hacks/Cairn/Monsters/cairn-monsters-a4-tmp.pdf"
rm -rf /tmp/monsters