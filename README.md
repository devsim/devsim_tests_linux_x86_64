Please see preinstall.sh for installing prerequisites from the Anaconda Python distribution.

Please see ``travis_tests.sh`` for an example of how to setup and run the tests.

Results are sensitive to the CPU and system libraries that may be installed in your Linux distribution.

All tests pass on Centos 7 running in a docker image on a Ubuntu 20.04 machine with an Intel I9 processor.

Trial run from a Anaconda Python environment:
```
source preinstall.sh
pip install --target devsim_linux_2.8.1 devsim-2.8.1-cp37-abi3-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
chmod u+x devsim_linux_2.8.1/devsim_data/testing/rundifftest.py
bash travis_tests.sh 2.8.1
```

