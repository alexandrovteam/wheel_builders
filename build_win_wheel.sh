#/usr/bin/env bash

SUBMODULE=$1
TARGET=$2

for PLATFORM in 32 64; do

    [[ $PLATFORM == 64 ]] && platName=win_amd64 || platName=win32;

    export PATH=/mingw${PLATFORM}/bin:$PATH
    CC=gcc.exe
    CXX=g++.exe

    PYTHON2=/c/Users/"`whoami`"/Miniconda2-${PLATFORM}bit/python

    cd $SUBMODULE && mkdir -p build && cd build &&\
        cmake -DCMAKE_C_COMPILER=${CC} -DCMAKE_CXX_COMPILER=${CXX} -DCMAKE_BUILD_TYPE=Release -G "MSYS Makefiles" .. &&\
        make $TARGET && cd ../../ &&\
        "${PYTHON2}" setup.py bdist_wheel --universal --plat-name=$platName

done
