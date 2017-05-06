#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_osx_${TAG}
TAGTGZ=${TAGDIR}.tgz
DEVSIM_PY=${TAGDIR}/bin/devsim
DEVSIM_TCL=${TAGDIR}/bin/devsim_tcl
ANACONDA_PATH=${HOME}/anaconda

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 

mkdir -p bin

cat << EOF > bin/devsim
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\$progname"\`
ANACONDA_PATH=${ANACONDA_PATH}
export DYLD_INSERT_LIBRARIES=\${ANACONDA_PATH}/lib/libpython2.7.dylib:\${ANACONDA_PATH}/lib/libmkl_rt.dylib
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
export DYLD_INSERT_LIBRARIES=\${ANACONDA_PATH}/lib/libtcl8.5.dylib:\${ANACONDA_PATH}/lib/libmkl_rt.dylib
export TCL_LIBRARY=\${ANACONDA_PATH}/lib/tcl8.5
# sequential really speeds things up
export MKL_NUM_THREADS=1
\${curdir}/../${DEVSIM_TCL} \$*
EOF
chmod +x bin/devsim_tcl

ln -sf ${TAGDIR}/testing .
ln -sf ${TAGDIR}/examples .

rm -rf run && mkdir run
(cd run && cmake -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY_TEST_EXE=${BASEDIR}/bin/devsim -DDEVSIM_TCL_TEST_EXE=${BASEDIR}/bin/devsim_tcl ..)
(cd run && ctest -j2)
