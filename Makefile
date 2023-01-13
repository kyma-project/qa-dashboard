.PHONY: resolve
resolve:
	npm install

.PHONY: validate
validate:
	npm run lint-check

pull-licenses:
ifdef LICENSE_PULLER_PATH
	mkdir -p ../licenses && bash $(LICENSE_PULLER_PATH) --dirs-to-pulling="../"
else
	mkdir -p ../licenses
endif

test:
	npm run test

build:
	npm run build
