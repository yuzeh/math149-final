#!/usr/bin/env bash

n_matrix_dims=3
n_matrix_norms=3
n_matrix_groups=4
min_samples=1000
max_samples=2000
min_landmark_prop=1
max_landmark_prop=2

for (( mat_grp=1; mat_grp<=$n_matrix_groups; mat_grp++ )); do
for (( mat_dim=3; mat_dim<=$n_matrix_dims; mat_dim++ )); do
for (( mat_norm=1; mat_norm<=$n_matrix_norms; mat_norm++ )); do
for (( n_samp=$min_samples; n_samp<=$max_samples; n_samp*=2 )); do
for (( prop=$min_landmark_prop; prop<=$max_landmark_prop; prop++ )); do
  n_landmark_pts=$(($prop*$n_samp/10))
  echo "cd `pwd` && ./run_test.sh $mat_grp $mat_dim $mat_norm $n_samp $n_landmark_pts"
done
done
done
done
done

