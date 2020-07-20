#!/bin/bash
set -e
# preinstall packages
yum install -y perl

if [ ! -d ${HOME}/anaconda ]; then
( cd ${HOME} && curl -L -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  && bash Miniconda3-latest-Linux-x86_64.sh -b -p ${HOME}/anaconda )
fi

${HOME}/anaconda/bin/conda install -y --name base cmake
${HOME}/anaconda/bin/conda create  -y --name python37_devsim python=3.7
${HOME}/anaconda/bin/conda install -y --name python37_devsim numpy mkl

