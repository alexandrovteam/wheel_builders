# Scripts for building binary wheels

These scripts are meant to simplify life of a developer who wants to distribute a cross-platform Python package with dynamic libraries through PyPI binary wheel system.

The scripts assume use of CFFI and don't work for Cython extensions, as this would be much more complicated.

## Assumptions

* The dynamic library to be used is built as one of the targets specified in `CMakelists.txt` inside a submodule
* CFFI is used in ABI mode, that is, the dynamic library doesn't have any references to Python whatsoever
* The Python code is compatible with both 2 and 3 versions

### Linux

* The submodule directory must contain a Dockerfile based on CentOS 6, so that manylinux1 wheels can be built
* The script will use the default G++ compiler; tweak $PATH in the Dockerfile to use a custom one

### OS X

* `brew install python3 gcc cmake`
* If GCC version is > 7, edit `CC` and `CXX` in `build_osx_wheel.sh` accordingly
* `pip3 install cffi delocate`

### Windows

* Miniconda-32bit and Miniconda-64bit must be both installed into Windows home directory
* Build happens in `msys2` environment, run `pacman -S git make mingw-w64-{i686,x86_64}-{cmake,toolchain}` to install necessary dependencies

## Usage

Under the above assumptions it's relatively easy to build binary wheels for all platforms and Python versions.

Each script takes two arguments:
* submodule directory name;
* name of the cmake target

For linux and OS X only 64-bit versions are produced, for Windows both 32-bit and 64-bit.
