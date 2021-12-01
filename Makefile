EMCC = /usr/lib/emscripten/emcc
SHELLFILE = shell.html
EMCCFLAGS = -s WASM=1 -s NO_EXIT_RUNTIME=1 -s "EXPORTED_RUNTIME_METHODS=['ccall']" \
        --shell-file $(SHELLFILE)
CXXFLAGS = -O0 -g3 -fsanitize=address,leak
LDFLAGS = -fsanitize=address,leak
SRCS = smf.cc
OBJS = smf.o

.PHONY: all
all: wasm native

.PHONY: wasm
wasm: index.html

index.html: smf.cc $(SHELLFILE)
	$(EMCC) -o index.html $(SRCS) $(EMCCFLAGS)

.PHONY: native
native: smf

smf: $(OBJS)
	$(CXX) $(LDFLAGS) -o smf $^

.PHONY: clean
clean:
	$(RM) index.html index.wasm index.js $(OBJS) smf
