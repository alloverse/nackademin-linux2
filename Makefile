SOURCES := $(wildcard *-lektion.md)
RENDERS := $(patsubst %.md, renders/%.pdf, $(SOURCES))

all: $(RENDERS)

renders/%.pdf: %.md
	CHROME_PATH=/snap/chromium/current/usr/lib/chromium-browser/chrome npx @marp-team/marp-cli@2.1.2 --allow-local-files $< -o $@
#	xdg-open $@
