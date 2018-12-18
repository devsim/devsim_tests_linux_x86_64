#!/bin/bash
set -e
# preinstall packages
yum install -y perl

if [ ! -d ${HOME}/anaconda ]; then
( cd ${HOME} && curl -O https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh  && bash Miniconda2-latest-Linux-x86_64.sh -b -p ${HOME}/anaconda )
fi

${HOME}/anaconda/bin/conda install -y --name base mkl cmake
${HOME}/anaconda/bin/conda create  -y --name python27_devsim python=2.7
${HOME}/anaconda/bin/conda install -y --name python27_devsim numpy mkl cmake
${HOME}/anaconda/bin/conda create  -y --name python37_devsim python=3.7
${HOME}/anaconda/bin/conda install -y --name python37_devsim numpy mkl
