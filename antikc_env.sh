# source me under bash with:
#
#   source ~/antikc/antikc_env.sh

# Most of these options are for building more software against Antikc-installed libraries
# You won't want them if you're trying to build 64-bit
export ROOT=$HOME/antikc
export PREFIX32=$ROOT/32bit
export PREFIX64=$ROOT/32bit
export CC="setarch i386 gcc -m32"
export CFLAGS="-m32 -I$PREFIX32/include"
export CPPFLAGS=$CFLAGS
export CXXFLAGS=$CFLAGS
export LDFLAGS="-m32 -L$PREFIX32/lib -L/lib -L/usr/lib -Wl,-rpath,$PREFIX32/lib:/lib:/usr/lib -ldl"
export SHARED_LDFLAGS="-L$PREFIX32/lib -L/lib -L/usr/lib -Wl,-rpath,$PREFIX32/lib:/lib:/usr/lib -ldl"
export PKG_CONFIG_PATH=$PREFIX32/lib/pkgconfig
export OPTS=-fPIC
export ABI=32
export FFLAGS=-m32

# This is what you really need for runtime
export PATH=$HOME/antikc/scripts:$HOME/antikc/32bit/bin:$PATH
export MANPATH=$HOME/antikc/32bit/share/man:/usr/share/man:/usr/local/share/man:/usr/X11R6/man
