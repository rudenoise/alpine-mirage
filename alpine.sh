# /bin/bash

apk add bridge-utils dnsmasq
apk add rsync make m4 musl-dev ncurses-libs build-base gmp-dev perl ncurses-dev
apk add opam
opam init
eval `opam config env`
opam upgrade
opam switch 4.02.3
