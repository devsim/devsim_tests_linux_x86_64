#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_linux_${TAG}
TAGTGZ=${TAGDIR}.tgz
#DEVSIM_PY=${TAGDIR}/bin/devsim
#DEVSIM_PY3=${TAGDIR}/bin/devsim_py3
DEVSIM_TCL=${TAGDIR}/bin/devsim_tcl
DEVSIM_LIB=${TAGDIR}/lib
ANACONDA_PATH=${HOME}/anaconda

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 
UTILITY_PATH=$(source ${ANACONDA_PATH}/bin/activate python27_devsim && echo ${CONDA_PREFIX}/bin)

mkdir -p bin
(cd bin && ln -sf ${UTILITY_PATH}/cmake && ln -sf ${UTILITY_PATH}/ctest)

cat << EOF > bin/devsim_py27
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\${progname}"\`
ANACONDA_PATH=${ANACONDA_PATH}
export PYTHONHASHSEED=0
# sequential speeds up small examples
export MKL_NUM_THREADS=1
source \${ANACONDA_PATH}/bin/activate python27_devsim
export LD_LIBRARY_PATH=\${CONDA_PREFIX}/lib
export PYTHONPATH="\${curdir}"/../${DEVSIM_LIB}
python "\$@"
EOF
chmod +x bin/devsim_py27

cat << EOF > bin/devsim_py37
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\${progname}"\`
ANACONDA_PATH=${ANACONDA_PATH}
export PYTHONHASHSEED=0
# sequential speeds up small examples
export MKL_NUM_THREADS=1
source \${ANACONDA_PATH}/bin/activate python37_devsim
export PYTHONPATH="\${curdir}"/../${DEVSIM_LIB}
python "\$@"
EOF
chmod +x bin/devsim_py37

cat << EOF > bin/devsim_tcl
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\${progname}"\`
ANACONDA_PATH=${ANACONDA_PATH}
export LD_LIBRARY_PATH=\${ANACONDA_PATH}/lib
export TCL_LIBRARY=\${ANACONDA_PATH}/lib/tcl8.6
# sequential speeds up small examples
export MKL_NUM_THREADS=1
\${curdir}/../${DEVSIM_TCL} "\$@"
EOF
chmod +x bin/devsim_tcl

ln -sf ${TAGDIR}/testing .
ln -sf ${TAGDIR}/examples .

rm -rf run && mkdir run
(cd run && ../bin/cmake -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY2_TEST_EXE=${BASEDIR}/bin/devsim_py27 -DDEVSIM_PY3_TEST_EXE=${BASEDIR}/bin/devsim_py37 -DDEVSIM_TCL_TEST_EXE=${BASEDIR}/bin/devsim_tcl ..)
(cd run && ../bin/ctest -j4)

