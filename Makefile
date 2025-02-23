.PHONY: all
all: dist/index.js

venv: Makefile
	rm -rf venv
	virtualenv venv -p python3
	venv/bin/pip install markdown-to-presentation

node_modules: package.json
	npm install --silent
	test -d node_modules
	touch node_modules

dist/index.js: index.js node_modules
	node_modules/.bin/webpack --config webpack.config.js
	# terrible hack to prevent lookup of `navigator`
	# if someone knows the correct way to use webpack, PRs welcome!
	sed -i 's/\bnavigator\b/({})/g' $@
