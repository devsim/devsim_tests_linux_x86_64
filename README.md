# Linux Tests

Please see ``preinstall.sh`` for installing prerequisites from the Anaconda Python distribution.

Please see ``travis_tests.sh`` for an example of how to setup and run the tests.

Results are sensitive to the CPU and system libraries that may be installed in your Linux distribution.

All tests pass on Centos 7 running in a docker image on a Ubuntu 20.04 machine with an Intel I9 processor.


```
cd devsim_tests_linux_x86_x64
source preinstall.sh
tar xzvf devsim_linux_v1.7.0.tgz
bash travis_tests.sh v1.7.0
```

