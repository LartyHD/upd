##
##  UPD -- Upgrade NPM Package Dependencies
##  Copyright (c) 2015-2023 Dr. Ralf S. Engelschall <rse@engelschall.com>
##
##  Permission is hereby granted, free of charge, to any person obtaining
##  a copy of this software and associated documentation files (the
##  "Software"), to deal in the Software without restriction, including
##  without limitation the rights to use, copy, modify, merge, publish,
##  distribute, sublicense, and/or sell copies of the Software, and to
##  permit persons to whom the Software is furnished to do so, subject to
##  the following conditions:
##
##  The above copyright notice and this permission notice shall be included
##  in all copies or substantial portions of the Software.
##
##  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
##  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
##  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
##  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
##  CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
##  TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
##  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
##

NPM     = npm
DOCKER  = docker
JQ      = jq

VERSION = `$(JQ) -r .version package.json`

all: build

bootstrap:
	@if [ ! -x $(GRUNT) ]; then $(NPM) install; fi

build: bootstrap

clean: bootstrap

distclean: bootstrap

docker-build:
	@$(DOCKER) build --build-arg UPD_VERSION=$(VERSION) -t engelschall/upd:latest -t engelschall/upd:$(VERSION) .
docker-inspect:
	@$(DOCKER) run --rm -i -t -v $$PWD:/pwd -e TERM --entrypoint /bin/sh engelschall/upd:$(VERSION)
docker-run:
	@$(DOCKER) run --rm -i -t -v $$PWD:/pwd -e TERM engelschall/upd:$(VERSION)
docker-push:
	@$(DOCKER) push engelschall/upd:$(VERSION)
	@$(DOCKER) push engelschall/upd:latest

