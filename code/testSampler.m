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
metrics = {@norm2mat, @norm1vec, @norm2vec};

fprintf('Working on matrix group %s\matrix_dimension', datasets{matrix_group});

data = {};

for column = 1:num_samples,
    data{end+1} = samplers{matrix_group}(matrix_dimension);
end

distances = zeros(num_samples, num_samples);


chosenMetric = metrics{matrix_norm};
for row = 1:num_samples,
    rowVal = data{row};
    for col = row:num_samples,
        distances(row,col) = chosenMetric(rowVal-data{col});
        distances(col,row) = distances(row,col);
    end
    row
end

numPoints = size(distances,1);
max_dimension = matrix_dimension*(matrix_dimension-1)/2+1;
num_landmark_points = 20;
num_divisions = 100;

m_space = metric.impl.ExplicitMetricSpace(distances);

landmark_selector = api.Plex4.createRandomSelector(m_space, num_landmark_points);

max_filtration_value = 1e-16;%landmark_selector.getMaxDistanceFromPointsToLandmarks()/5;

stream = api.Plex4.createWitnessStream(landmark_selector, max_dimension, ...
   max_filtration_value, num_divisions);

num_simplices = stream.getSize();

persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension,2);

intervals = persistence.computeIntervals(stream);

options.filename = sprintf('%s(%d)', datasets{matrix_group}, matrix_dimension);
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
plot_barcodes(intervals, options);
