#!/bin/sh
# ./myblog/build.sh

# other build commands such as javascript or css minifiers

rm -r ./build/
wintersmith build
cd build
mongoose
