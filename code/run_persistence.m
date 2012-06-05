% Hyperparameters
%  - matrix_norm
%  - num_samples
%  - num_landmark_points
%  - max_filtration_value
% Non-hyperparameter settings
%  - matrix_group
%  - matrix_dimension

datasets = {'SO', 'U', 'SU'};
samplers = {@sampleSO, @sampleU, @sampleSU};
norms = {@norm2mat, @norm1vec, @norm2vec};
norms_label = {'norm2mat', 'norm1vec', 'norm2vec'};

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
    row
end

numPoints = size(distances,1);
max_dimension = matrix_dimension*(matrix_dimension-1)/2+1;
num_divisions = 100;

m_space = metric.impl.ExplicitMetricSpace(distances);

landmark_selector = api.Plex4.createRandomSelector(m_space, num_landmark_points);

max_filtration_value = 1e-16;%landmark_selector.getMaxDistanceFromPointsToLandmarks()/5;

stream = api.Plex4.createWitnessStream(landmark_selector, max_dimension, ...
   max_filtration_value, num_divisions);

num_simplices = stream.getSize();

persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension,2);

intervals = persistence.computeIntervals(stream);

options.filename = sprintf('%s_%s__%s__%d_samples__%d_landmarks__%f_maxfilval', ...
  datasets{matrix_group}, matrix_dimension, ...
  norms_label{matrix_norm}, ...
  num_samples, ...
  num_landmarks, ...
  max_filtration_value);
options.file_format = 'eps';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
plot_barcodes(intervals, options);
