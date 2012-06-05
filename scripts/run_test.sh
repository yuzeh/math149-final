#!/usr/bin/env bash

if [[ `echo ${PWD##*/} | tr -d '\n'` != 'scripts' ]]; then
  echo 'Please run script from the "scripts" directory!'
  exit 1
fi

if [[ $# -lt 5 ]]; then
  echo "usage: $0 matrix_group matrix_dimension matrix_norm num_samples num_landmark_points"
  exit 1
fi

# Get arguments
matrix_group=$1
matrix_dimension=$2
matrix_norm=$3
num_samples=$4
num_landmark_points=$5

read -d '' command <<EOF
load_javaplex;
matrix_group = $matrix_group;
matrix_dimension = $matrix_dimension;
matrix_norm = $matrix_norm;
num_samples = $num_samples;
num_landmark_points = $num_landmark_points;
run_persistence
EOF
command=`echo "$command"`

pushd ../code

matlab -Xmm2048m -nodesktop -nosplash <<EOF
`echo "$command"`
EOF

popd
