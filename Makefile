SOURCES := $(wildcard *-lektion.md)
PREPROCESSED := := $(patsubst %.md, preprocessed/%.pdf, $(SOURCES))
RENDERS := $(patsubst %.md, renders/%.pdf, $(SOURCES))

all: $(RENDERS)

preprocessed:
	mkdir -p preprocessed
	ln -s `pwd`/img preprocessed/img

preprocessed/%.md: %.md preprocessed
	sed 's/DEVOPS21/ITINF21/g' $< | sed 's/DEVOPS 2021/ITINF 2021\&nbsp;\&nbsp;\&nbsp;\&nbsp;/' > $@

renders/%.pdf: preprocessed/%.md
	CHROME_PATH=/snap/chromium/current/usr/lib/chromium-browser/chrome npx @marp-team/marp-cli@2.1.4 --allow-local-files $< -o $@
#	xdg-open $@
