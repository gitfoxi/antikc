# source me under bash with:
#
#   source ~/antikc/antikc_env.sh

export ROOT=$HOME/antikc
export PREFIX32=$ROOT/32bit
export PREFIX64=$ROOT/32bit
export CC="gcc -m32"
export CFLAGS="-m32 -I$PREFIX32/include"
export LDFLAGS="-L$PREFIX32/lib -L/lib -L/usr/lib -Wl,-rpath,$PREFIX32/lib:/lib:/usr/lib -ldl"

export PATH=$HOME/antikc/32bit/bin:$PATH
export MANPATH=$HOME/antikc/32bit/share/man:/usr/share/man:/usr/local/share/man:/usr/X11R6/man
