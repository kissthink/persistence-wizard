#!/bin/sh
cd $(dirname $0)

intltool-extract --type="gettext/ini" persistence-wizard.desktop.in
intltool-extract --type="gettext/ini" persistence-wizard-kde.desktop.in
xgettext --from-code=utf-8 -L shell -o po/persistence-wizard.pot src/persistence-wizard
xgettext --from-code=utf-8 -j -L C -kN_ -o po/persistence-wizard.pot persistence-wizard.desktop.in.h
xgettext --from-code=utf-8 -j -L C -kN_ -o po/persistence-wizard.pot persistence-wizard-kde.desktop.in.h

rm persistence-wizard.desktop.in.h persistence-wizard-kde.desktop.in.h

cd po
for i in `ls *.po`; do
	msgmerge -U $i persistence-wizard.pot
done
rm -f ./*~