% Hyperparameters
%  - matrix_norm
%  - num_samples
%  - num_landmark_points
%  - max_filtration_value
% Non-hyperparameter settings
%  - matrix_group
%  - matrix_dimension

datasets = {'O', 'SO', 'U', 'SU'};
samplers = {@sampleO, @sampleSO, @sampleU, @sampleSU};
norms = {@norm2mat, @norm2vec, @norm1vec};
norms_label = {'norm2mat', 'norm2vec', 'norm1vec'};

fprintf('Working on matrix group %s', datasets{matrix_group});

data = cell(num_samples, 1);

for column = 1:num_samples,
    data{column} = samplers{matrix_group}(matrix_dimension);
end

distances = zeros(num_samples, num_samples);

chosen_norm = norms{matrix_norm};
for row = 1:num_samples,
    rowVal = data{row};
    for col = row:num_samples,
        distances(row,col) = chosen_norm(rowVal-data{col});
        distances(col,row) = distances(row,col);
    end
end

numPoints = size(distances,1);

if matrix_group == 2,
	max_dimension = matrix_dimension*(matrix_dimension-1)/2+1;
end

if matrix_group == 3
	max_dimension = 1+matrix_dimension^2;
end

if matrix_group == 4
	max_dimension = matrix_dimension^2;
end

num_divisions = 50;

m_space = metric.impl.ExplicitMetricSpace(distances);

landmark_selector = api.Plex4.createMaxMinSelector(m_space, num_landmark_points);

max_filtration_value = landmark_selector.getMaxDistanceFromPointsToLandmarks()/2;

stream = api.Plex4.createWitnessStream(landmark_selector, max_dimension, ...
   max_filtration_value, num_divisions);

num_simplices = stream.getSize();

persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension,2);

intervals = persistence.computeIntervals(stream);
intervals
options.filename = ...
sprintf('%s_%d__%s_%dsamples_%dlandmarks.pdf', ...
  datasets{matrix_group}, matrix_dimension, ...
  norms_label{matrix_norm}, ...
  num_samples, ...
  num_landmark_points);

options.caption = ...
sprintf('%s(%d), %s, %d samples, %d landmarks %d simplices', ...
  datasets{matrix_group}, matrix_dimension, ...
  norms_label{matrix_norm}, ...
  num_samples, ...
  num_landmark_points, ...
  num_simplices);

options.file_format = 'pdf';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;

plot_barcodes(intervals, options);
