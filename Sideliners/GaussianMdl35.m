function [trainedClassifier, validationAccuracy] = GaussianMdl35(datasetTable)
% Extract predictors and response
predictorNames = datasetTable.Properties.VariableNames(1:end-1);
                  

predictors = datasetTable(:,predictorNames);
predictors = table2array(varfun(@double, predictors));
response = datasetTable.Grid;

% Train a classifier
template = templateSVM('KernelFunction', 'gaussian', 'PolynomialOrder', [],...
                       'KernelScale',11, 'BoxConstraint',10, 'Standardize', 1);
                   
% template = templateSVM('KernelFunction', 'polynomial', 'PolynomialOrder', 2,...
%                    'KernelScale', 7, 'BoxConstraint', 10, 'Standardize', 1);  

trainedClassifier = fitcecoc(predictors, response, 'Learners', template,'Coding', 'onevsone','FitPosterior',1,...
                            'PredictorNames',predictorNames ,...
                             'ResponseName', 'Grid', 'ClassNames',...
                             categorical({'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I'}));


% Set up holdout validation
cvp = cvpartition(response, 'Holdout', 0.2);
trainingPredictors = predictors(cvp.training,:);
trainingResponse = response(cvp.training,:);

% Train a classifier
% template = templateSVM('KernelFunction', 'gaussian', 'PolynomialOrder', [], 'KernelScale', 11, 'BoxConstraint', 10, 'Standardize', 1);
template = templateSVM('KernelFunction',  'Polynomial', 'PolynomialOrder', 2, 'KernelScale', 10, 'BoxConstraint', 1, 'Standardize', 1);
validationModel = fitcecoc(trainingPredictors, trainingResponse, 'Learners', template, 'Coding', 'onevsone', 'PredictorNames',...
                           predictorNames ,...
                            'ResponseName', 'Grid', 'ClassNames', categorical({'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I'}));

% Compute validation accuracy
validationPredictors = predictors(cvp.test,:);
validationResponse = response(cvp.test,:);
validationAccuracy = 1 - loss(validationModel, validationPredictors, validationResponse, 'LossFun', 'ClassifError');

%% Uncomment this section to compute validation predictions and scores:
% % Compute validation predictions and scores
% [validationPredictions, validationScores] = predict(validationModel, validationPredictors);