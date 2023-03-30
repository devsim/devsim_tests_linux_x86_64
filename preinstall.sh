#!/bin/bash
#set -e
conda create  -y --name devsim_test python=3 numpy mkl cmake blas=*=*mkl
conda activate devsim_test

