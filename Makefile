EMCC = /usr/lib/emscripten/emcc
SHELLFILE = shell.html
EMCCFLAGS = -s WASM=1 -s NO_EXIT_RUNTIME=1 -s "EXPORTED_RUNTIME_METHODS=['ccall']" \
        --shell-file $(SHELLFILE)

.PHONY: all
all: wasm native

.PHONY: wasm
wasm: index.html

index.html: smf.cc $(SHELLFILE)
	$(EMCC) -o index.html smf.cc $(EMCCFLAGS)

.PHONY: native
native: smf

smf: smf.o
	$(CXX) $(LDFLAGS) -o smf $^

.PHONY: clean
clean:
	$(RM) index.html index.wasm index.js smf.o smf
