#!/bin/bash
set -e
set -u
BASEDIR="${PWD}"
TAG=${1}
TAGDIR=devsim_linux_${TAG}
DEVSIM_LIB=${TAGDIR}

mkdir -p bin
cat << EOF > bin/devsim_py37
#!/bin/bash
set -e
progname="\$0"
curdir=\`dirname "\${progname}"\`
export PYTHONHASHSEED=0
# sequential speeds reduces over all testing time
export OMP_NUM_THREADS=1
export MKL_NUM_THREADS=1
export PYTHONPATH="\${curdir}"/../${DEVSIM_LIB}
python "\$@"
EOF
chmod +x bin/devsim_py37
cp CMakeLists.txt ${TAGDIR}/devsim_data
rm -rf run && mkdir run
(cd run && cmake -DDEVSIM_TEST_GOLDENDIR=${BASEDIR}/goldenresults -DDEVSIM_PY3_TEST_EXE=${BASEDIR}/bin/devsim_py37 ../${TAGDIR}/devsim_data)
(cd run && ctest -j4)

