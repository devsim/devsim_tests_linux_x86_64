#!/bin/bash
#set -e

conda install -y --name base cmake
conda create  -y --name devsim_test python=3 numpy mkl cmake
conda activate devsim_test

