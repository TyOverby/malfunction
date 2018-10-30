#!/bin/bash

# FIXME: should we support compiling files in non-current directories?
cd "$(dirname "$0")"

set -e
# set -x

malfunction compile helloworld.mlf
[ "$(./helloworld)" = "Hello, world!" ]
rm -f helloworld

malfunction compile -o foo helloworld.mlf
[ "$(./foo)" = "Hello, world!" ]
rm -f foo

malfunction cmx helloworld.mlf
ocamlopt helloworld.cmx -o exec
[ "$(./exec)" = "Hello, world!" ]
rm -f exec helloworld.{cmx,o}

ocamlopt -c module.mli
malfunction cmx module.mlf
ocamlopt module.cmx main.ml -o main
[ "$(./main)" = 42 ]
rm -f {main,module}.{cmi,cmx,o} main

