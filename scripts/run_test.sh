#!/usr/bin/env bash

if [[ `echo ${PWD##*/} | tr -d '\n'` != 'scripts' ]]; then
  echo 'Please run script from the "scripts" directory!'
  exit 1
fi

if [[ $# -lt 6 ]]; then
  echo "usage: $0 matrix_group matrix_dimension matrix_norm num_samples num_landmark_points max_filtration_value"
  exit 1
fi

# Get arguments
matrix_group=$1
matrix_dimension=$2
matrix_norm=$3
num_samples=$4
num_landmark_points=$5
max_filtration_value=$6

read -d '' command <<EOF
load_javaplex;
matrix_group = $matrix_group;
matrix_dimension = $matrix_dimension;
matrix_norm = $matrix_norm;
num_samples = $num_samples;
num_landmark_points = $num_landmark_points;
max_filtration_value = $max_filtration_value;
testSampler
EOF
command=`echo "$command"`

pushd ../code

matlab -nodesktop -nosplash <<EOF
`echo "$command"`
EOF

popd
