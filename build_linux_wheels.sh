#/usr/bin/env bash

SUBMODULE=$1
TARGET=$2

mnt="/code"

build_cmd="
cd $mnt/$SUBMODULE/build &&\
cmake -DCMAKE_BUILD_TYPE=Release .. &&\
make -B -j8 $TARGET && cd $mnt && rm -r dist/*;
source activate py2; pip install -U wheel; python setup.py bdist_wheel --universal --plat-name manylinux1_x86_64;
source activate py3; pip install -U wheel; python setup.py bdist_wheel --universal --plat-name manylinux1_x86_64;
"

image=devtoolset-3

docker build -t $image $SUBMODULE && mkdir -p $SUBMODULE/build &&\
    echo $build_cmd &&\
    docker run -v `pwd`:$mnt $image /bin/bash -c "$build_cmd"
