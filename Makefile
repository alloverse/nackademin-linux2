SOURCES := $(wildcard *-lektion.md)
PREPROCESSED := := $(patsubst %.md, preprocessed/%.pdf, $(SOURCES))
RENDERS := $(patsubst %.md, renders/%.pdf, $(SOURCES))

all: $(RENDERS)

preprocessed/%.md: %.md
	sed 's/DEVOPS21/ITINF21/g' $< | sed 's/DEVOPS 2021/ITINF 2021\&nbsp;\&nbsp;\&nbsp;\&nbsp;/' > $@

renders/%.pdf: preprocessed/%.md
	CHROME_PATH=/snap/chromium/current/usr/lib/chromium-browser/chrome npx @marp-team/marp-cli@2.1.2 --allow-local-files $< -o $@
#	xdg-open $@
