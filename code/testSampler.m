function [  ] = testSampler( class, chooseMetric)
    metric.impl.ExplicitMetricSpace(randn(10));
    datasets = {'SO', 'U', 'SU'};
    samplers = {@sampleSO, @sampleU, @sampleSU};
    metrics = {@norm2mat, @norm1vec, @norm2vec};
    
    fprintf('Working on class %s\n', datasets{class});
    
    
    n = 3;
    numExamples = 20;
    
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
    metric.impl.ExplicitMetricSpace(randn(10));
    computeHomology(distances);
    
    
end

