renders/%.pdf: %.md
	CHROME_PATH=/snap/chromium/current/usr/lib/chromium-browser/chrome npx @marp-team/marp-cli@latest --allow-local-files $< -o $@
	xdg-open $@
