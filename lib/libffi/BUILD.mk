
LIBFFI_SRC := https://github.com/libffi/libffi/archive/refs/tags/v3.5.2.tar.gz 

LIBFFI_CONFIG_ARGS = --prefix=$$(COSMOS)\
    --disable-shared --enable-static\
    --without-pic --with-gnu-ld\
    --disable-exec-static-tramp\
    CFLAGS="-Os"

$(eval $(call DOWNLOAD_SOURCE,lib/libffi,$(LIBFFI_SRC)))
$(eval $(call AUTOTOOLS_BUILD,lib/libffi,$(LIBFFI_CONFIG_ARGS),$(LIBFFI_CONFIG_ARGS)))

o/lib/libffi/setup: o/lib/libffi/patched
	cd $(BASELOC)/o/lib/libffi/libffi* && autoreconf -fi $(ERRLOG)
	touch $@

o/lib/libffi/configured.x86_64: o/lib/libffi/setup
o/lib/libffi/configured.aarch64: o/lib/libffi/setup

o/lib/libffi/built.fat: FATTEN_COMMAND = $(DUMMYLINK0)
