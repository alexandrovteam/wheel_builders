#/usr/bin/env bash

# the official distribution from python.org should be used instead of the system one,
# see reasons here: https://github.com/MacPython/wiki/wiki/Spinning-wheels

SUBMODULE=$1
TARGET=$2

rm -rf dist &&\
cd $SUBMODULE && mkdir -p build && cd build &&\
    cmake -DCMAKE_C_COMPILER=gcc-6 -DCMAKE_CXX_COMPILER=g++-6 -DCMAKE_BUILD_TYPE=Release .. &&\
    make $TARGET && cd ../../ &&\
    /usr/local/bin/python3 setup.py bdist_wheel --universal --plat-name=macosx_10_6_intel &&\
    delocate-wheel dist/*.whl

# the resulting wheel must be uploaded to PyPI using 'twine upload' command
# (this is also recommended due to security concerns over 'python setup.py upload',
# but main reason here is that 'setup.py bdist_wheel upload' rebuilds the wheel,
# and it no longer contains the dynamic libs)
