#!/bin/bash
set -e
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_linux_${TAG}
TAGTGZ=${TAGDIR}.tgz
DEVSIM_LIB=${TAGDIR}/lib
ANACONDA_PATH=${HOME}/anaconda

#curl -L -O https://github.com/devsim/devsim/releases/download/${TAG}/${TAGTGZ}
#tar xzf ${TAGTGZ} 

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
cp CMakeLists.txt ${TAGDIR}/
rm -rf run && mkdir run
(cd run && cmake -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY3_TEST_EXE=${BASEDIR}/bin/devsim_py37 ../${TAGDIR})
(cd run && ctest -j4)

