#!/usr/bin/env bash

n_matrix_dims=3
n_matrix_norms=1
n_matrix_groups=4
min_samples=100
max_samples=2000
min_landmark_prop=1
max_landmark_prop=1



for (( prop=$min_landmark_prop; prop<=$max_landmark_prop; prop++ )); do
for (( mat_dim=2; mat_dim<=$n_matrix_dims; mat_dim++ )); do
for (( n_samp=$min_samples; n_samp<=$max_samples; n_samp*=2 )); do
for (( mat_grp=2; mat_grp<=$n_matrix_groups; mat_grp++ )); do
for (( mat_norm=1; mat_norm<=$n_matrix_norms; mat_norm++ )); do
    n_landmark_pts=$(($prop*$n_samp/10))

	name=${mat_grp}_${mat_dim}_${mat_norm}_${n_samp}_${n_landmark_pts}
	basedir=${mat_grp}_${mat_dim}_${mat_norm}_${n_samp}_${n_landmark_pts}

    script_name=toRun/${name}.sh


	command_starttimestamp="date > `pwd`/output/${basedir}.starttime"
	command_hostname="hostname> `pwd`/output/${basedir}.hostname"
	command_endtimestamp="date > `pwd`/output/${basedir}.endtime" 
	command_starttime='START=$(date +%s)'
	command_endtime='END=$(date +%s)'
	command_difference='DIFF=$(( $END - $START ))'
	command_time_passed="echo \${DIFF} > `pwd`/output/${basedir}.totaltime"

    echo "cd `pwd`" > $script_name
    echo $command_starttimestamp >> $script_name
	echo $command_starttime >> $script_name
	echo "./run_test.sh $mat_grp $mat_dim $mat_norm $n_samp $n_landmark_pts" >> $script_name
	echo $command_endtime >> $script_name
	echo $command_endtimestamp >> $script_name
	echo $command_difference >> $script_name
	echo $command_time_passed >> $script_name

	chmod +x $script_name
	echo `pwd`/$script_name
done
done
done
done
done

