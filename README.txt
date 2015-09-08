Centos 5 with Anaconda Python 2.7 and Intel MKL 11.3
Place this directory in devsim/goldenresults as centos_5_x86_64/

Use cmake28 and ctest28 from epel.

These tests will fail:
         49 - testing/sqlite1 (Failed)
         52 - testing/thread_1 (Failed)
         54 - testing/fpetest2 (Timeout)

