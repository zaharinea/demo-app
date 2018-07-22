.PHONY: test run clean dep rpm

all: test

test:
	./scripts/test.sh

clean:
	rm -rf .tnt*

run:
	FG=1 CONF=./conf.lua tarantoolctl start demo-app.lua

dep:
	tarantoolapp dep --meta-file ./meta.yaml --tree ./.rocks

rpm:
	rpmbuild -ba --define="SRC_DIR ${PWD}" rpm/demo-app.spec
