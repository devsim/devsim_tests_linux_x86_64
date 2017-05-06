#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_linux_${TAG}
TAGTGZ=${TAGDIR}.tgz
DEVSIM_PY=${TAGDIR}/bin/devsim
DEVSIM_TCL=${TAGDIR}/bin/devsim_tcl
ANACONDA_PATH=${HOME}/anaconda

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 
yum install -y epel-release
yum install -y cmake3

if [ ! -d ${HOME}/anaconda ]; then
( cd ${HOME} && curl -O https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh  && bash Miniconda2-latest-Linux-x86_64.sh -b -p ${HOME}/anaconda )
${HOME}/anaconda/bin/conda install -y numpy mkl
fi

mkdir -p bin

cat << EOF > bin/devsim
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\$progname"\`
ANACONDA_PATH=${ANACONDA_PATH}
export LD_LIBRARY_PATH=\${ANACONDA_PATH}/lib
export PYTHONHOME=\${ANACONDA_PATH}
# sequential really speeds things up
export MKL_NUM_THREADS=1
\${curdir}/../${DEVSIM_PY} \$*
EOF
chmod +x bin/devsim

cat << EOF > bin/devsim_tcl
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\$progname"\`
ANACONDA_PATH=${ANACONDA_PATH}
export LD_LIBRARY_PATH=\${ANACONDA_PATH}/lib
export TCL_LIBRARY=\${ANACONDA_PATH}/lib/tcl8.5
# sequential really speeds things up
export MKL_NUM_THREADS=1
\${curdir}/../${DEVSIM_TCL} \$*
EOF
chmod +x bin/devsim_tcl

ln -sf ${TAGDIR}/testing .
ln -sf ${TAGDIR}/examples .

rm -rf run && mkdir run
(cd run && cmake3 -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY_TEST_EXE=${BASEDIR}/bin/devsim -DDEVSIM_TCL_TEST_EXE=${BASEDIR}/bin/devsim_tcl ..)
(cd run && ctest3 -j2)
