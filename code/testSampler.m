class = 1;
chooseMetric = 1;
datasets = {'SO', 'U', 'SU'};
samplers = {@sampleSO, @sampleU, @sampleSU};
metrics = {@norm2mat, @norm1vec, @norm2vec};

fprintf('Working on class %s\n', datasets{class});


n = 2;
numExamples = 1000;

data = {};

for column = 1:numExamples,
    data{end+1} = samplers{class}(n);
end

distances = zeros(numExamples, numExamples);

for row = 1:numExamples,
    for col = 1:numExamples,
        distances(row,col) = metrics{chooseMetric}(data{row}-data{col});
    end
end

numPoints = size(distances,1);
max_dimension = 3;
num_landmark_points = ceil(.1*numPoints);
num_divisions = 20;

metric.impl.ExplicitMetricSpace(randn(10));

m_space = metric.impl.ExplicitMetricSpace(distances);

landmark_selector = api.Plex4.createRandomSelector(m_space, num_landmark_points);
max_filtration_value = landmark_selector.getMaxDistanceFromPointsToLandmarks();

stream = api.Plex4.createWitnessStream(landmark_selector, max_dimension, ...
    max_filtration_value, num_divisions);


num_simplices = stream.getSize();

persistence = api.Plex4.getModularSimplicialAlgorithm(max_dimension,2);

intervals = persistence.computeIntervals(stream);

options.filename = 'Not Sure, this is general';
options.max_filtration_value = max_filtration_value;
options.max_dimension = max_dimension - 1;
plot_barcodes(intervals, options);