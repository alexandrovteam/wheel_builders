#/usr/bin/env bash

SUBMODULE=$1
TARGET=$2

mnt="/code"

build_cmd="
cd $mnt/$SUBMODULE/build &&\
cmake -DCMAKE_BUILD_TYPE=Release .. &&\
make -B -j8 $TARGET && cd $mnt && rm -r dist/*;
source activate py2; python setup.py bdist_wheel;
source activate py3; python setup.py bdist_wheel;
source activate py3; bash -c 'for fn in `ls dist/*.whl`; do auditwheel repair \$fn; done'
"

image=devtoolset-3

docker build -t $image $SUBMODULE && mkdir -p $SUBMODULE/build &&\
    echo $build_cmd &&\
    docker run -v `pwd`:$mnt $image /bin/bash -c "$build_cmd"
