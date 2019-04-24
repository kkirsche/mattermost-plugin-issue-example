GO ?= $(shell command -v go 2> /dev/null)
MANIFEST_FILE ?= plugin.json
PLUGIN_ID ?= example-plugin-failure
PLUGIN_VERSION ?= 0.0.1

BUNDLE_NAME ?= $(PLUGIN_ID)-$(PLUGIN_VERSION).tar.gz

.PHONY: build
build:
	@echo [+] Beginning build process
	rm -rf server/dist
	mkdir -p server/dist
	cd server && env GOOS=linux GOARCH=amd64 $(GO) build -v -o dist/plugin-linux-amd64;
	cd server && env GOOS=darwin GOARCH=amd64 $(GO) build -v -o dist/plugin-darwin-amd64;
	cd server && env GOOS=windows GOARCH=amd64 $(GO) build -v -o dist/plugin-windows-amd64.exe;

.PHONY: bundle
bundle: build
	@echo [+] beginning plugin bundling
	rm -rf dist/
	mkdir -p dist/$(PLUGIN_ID)
	cp $(MANIFEST_FILE) dist/$(PLUGIN_ID)/
	mkdir -p dist/$(PLUGIN_ID)/server/dist;
	cp -r server/dist/* dist/$(PLUGIN_ID)/server/dist/;
	cd dist && tar -cvzf $(BUNDLE_NAME) $(PLUGIN_ID)
	@echo [+] plugin built and bundled at: dist/$(BUNDLE_NAME)
