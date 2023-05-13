Please see preinstall.sh for installing prerequisites from the Anaconda Python distribution.

Please see ``travis_tests.sh`` for an example of how to setup and run the tests.

Results are sensitive to the CPU and system libraries that may be installed in your Linux distribution.

All tests pass on Centos 7 running in a docker image on a Ubuntu 20.04 machine with an Intel I9 processor.

Trial run from a Anaconda Python environment:
```
source preinstall.sh
pip install --target devsim_linux_2.5.0 devsim-2.5.0-cp36-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
bash travis_tests.sh 2.5.0
```

# without Intel MKL

```
conda create  -y --name devsim_test python=3 numpy nomkl cmake
```

